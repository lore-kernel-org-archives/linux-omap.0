From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Sun, 31 Mar 2013 09:37:52 +0200
Message-ID: <20130331073752.GB13159@amd.pavel.ucw.cz>
References: <1838509461.25809.1364682678664.JavaMail.apache@mail83.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1838509461.25809.1364682678664.JavaMail.apache@mail83.abv.bg>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>
Cc: pali.rohar@gmail.com, tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

>  >You can do without ret variable... Also more detailed changelog would
>  >be nice... like what exact problem this works around.
>  >
> 
> Sure i can, but I don't see a reason to ignore SM's return value. Changelog of what?
> 
> I guess if you read the thread over the ML you'll have your questions already answered. 
> Or google for "ARM errata 430973 workaround" :).

I did my googling. But I should not have had to. Just put the
explanatory link in commit log.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
