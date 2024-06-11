'use client';

import { useState } from "react";
import NavBar from "./_components/NavBar";
import ReviewCards from "./_components/ReviewCards";
import Link from "next/link";
import Image from "next/image";

export default function HomePage() {
  const [reviewInd, setReviewInd] = useState(0);
  const reviewVis = 1;
  let reviews = [["AMAZING APP I LOVE IT SO MUCH I SPEND 10 HOURS ON IT A DAY", "Josh"], ["review two", "nick"], ["review three", "patrick"], ["review four", "john"]];

  return (
    <main className="bg-gray-900 h-screen w-screen">

      <div className="flex flex-col items-center">
        <div className="w-4/6">
          <NavBar />
          <div className="mt-5 flex flex-row justify-between text-white">
            <div className="w-1/2">
                <section id="home">
                  <div>
                    <h1 className="text-5xl font-bold mt-10">
                      Connecting people through music
                    </h1>
                    <h2 className="text-2xl mt-7">
                      descriptiondescriptiondescriptiond<br></br>escriptiondescriptiondescr<br></br>iptiondescriptiondescript
                    </h2>
                    <ReviewCards reviews={reviews} reviewInd={reviewInd} reviewVis={reviewVis} />
                    <div className="flex flex-row items-center justify-between w-1/2">
                      <Link href="https://apps.apple.com/app" target="_blank">
                        <div className="">
                          <Image
                            src="/appStore.svg"
                            alt="app store"
                            width={200}
                            height={100}
                          />
                        </div>
                      </Link>
                      <Link href="https://play.google.com/store/apps" target="_blank">
                        <div>
                          <Image
                            src="/googlePlayStore.png"
                            alt="google play store"
                            width={250}
                            height={150}
                          />
                        </div>
                      </Link>
                    </div>
                  </div>
                </section>
                <section id="about" className="h-screen bg-gray-900">
                  about
                </section>
                <section id="faq" className="h-screen bg-gray-900">
                  faq
                </section>
                <section id="contact" className="h-screen bg-gray-900">
                  contact
                </section>
            </div>
            <div className="flex justify-center items-center w-1/2">
              SAMPLE CASE
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}
