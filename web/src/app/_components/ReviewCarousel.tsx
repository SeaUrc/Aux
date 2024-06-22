import { useState, useEffect } from "react";
import { BsFillArrowRightCircleFill, BsFillArrowLeftCircleFill } from "react-icons/bs";

interface Review {
    text: string;
    author: string;
}

const ReviewCarousel: React.FC<{ reviews: Review[] }> = ({ reviews }) => {
    const [current, setCurrent] = useState(0);

    const handleSlideChange = (newIndex: number) => {
        setCurrent(newIndex);
    };

    const previousSlide = () => {
        const newIndex = current === 0 ? reviews.length - 1 : current - 1;
        setCurrent(newIndex);
    };

    const nextSlide = () => {
        const newIndex = current === reviews.length - 1 ? 0 : current + 1;
        setCurrent(newIndex);
    };

    return (
        <div className="overflow-hidden relative border-2 border-gray-200 h-[30vh]">
            <div className="flex justify-center items-center h-full w-3/4 relative items-center">
                {
                    reviews.map((review, index) => {
                        return (
                            <div
                                className={`text-center transition-opacity duration-1000`}
                                style={{ visibility: `${current === index ? "visible" : "hidden"}`, position: "absolute", left: "0", width: "100%", opacity: `${current === index ? "1" : "0"}` }}
                            >
                                {reviews[current]?.text}
                            </div>
                        )
                    })
                }

            </div>

            <div className="absolute top-0 h-full w-full justify-between items-center flex text-white px-10 text-3xl">
                <button onClick={previousSlide}>
                    <BsFillArrowLeftCircleFill />
                </button>
                <button onClick={nextSlide}>
                    <BsFillArrowRightCircleFill 
                        className="w-6 h-6"
                    />
                </button>
            </div>

            <div className="absolute bottom-0 py-4 flex justify-center gap-3 w-full">
                {reviews.map((_, i) => {
                    return (
                        <div
                            onClick={() => handleSlideChange(i)}
                            key={"circle" + i}
                            className={`rounded-full w-3 h-3 cursor-pointer  ${i === current ? "bg-white" : "bg-gray-500"
                                }`}
                        ></div>
                    );
                })}
            </div>
        </div>
    );
};

export default ReviewCarousel;