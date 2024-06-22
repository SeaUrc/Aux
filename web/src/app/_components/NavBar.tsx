
export default function NavBar() {

    const handleNavClick = (sectionId: string) => {
        const section = document.getElementById(sectionId);
        if (section) {
          section.scrollIntoView({
            behavior: 'smooth',
            block: 'start',
            inline: 'nearest'
          });
        }
      };

    return (
        <nav className="top-0 sticky max-h-16 min-h-16 py-5 pr-20 text-white bg-gray-900">
            <div className="flex items-center justify-between text-2xl">
                <a onClick={() => handleNavClick('home')}>
                    <div className="text-4xltransition-all duration-200 ease-in-out hover:-translate-y-[0.2rem] hover:shadow-2xl">
                        Aux
                    </div>
                </a>
                <a onClick={() => handleNavClick('about')}>
                    <div className="transition-all duration-200 ease-in-out hover:-translate-y-[0.2rem] hover:shadow-2xl">
                        About
                    </div>
                </a>
                <a onClick={() => handleNavClick('faq')}>
                    <div className="transition-all duration-200 ease-in-out hover:-translate-y-[0.2rem] hover:shadow-2xl">
                        FAQ
                    </div>
                </a>
                <a onClick={() => handleNavClick('contact')}>
                    <div className="transition-all duration-200 ease-in-out hover:-translate-y-[0.2rem] hover:shadow-2xl">
                        Contact
                    </div>
                </a>
            </div>
        </nav>
    );
}