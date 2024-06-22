export default function ReviewCards(props: { reviews: string[][], reviewInd: number, reviewVis: number }) {
    return (
        <div className="flex flex-row items-center justify-evenly w-1/2 my-20">
            {props.reviews.map((review, i) => {
                if (i - props.reviewInd >= 0 && i - props.reviewInd < props.reviewVis) {
                    return (
                        <div key={i} className="rounded-xl text-white max-w-sm text-xl text-center">
                            <div>
                                {`${review[0]}`}
                            </div>
                            <div>
                                {`- ${review[1]}`}
                            </div>
                        </div>
                    )
                }
            })}
        </div>
    );
} 