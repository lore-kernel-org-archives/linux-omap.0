From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFCv3 0/7] OMAP SSI driver
Date: Thu, 24 Oct 2013 08:27:17 +0000 (UTC)
Message-ID: <19700101000313.GA1434__9154.5024690733$1382603247$gmane$org@xo-6d-61-c0.localdomain>
References: <1381091235-18293-1-git-send-email-sre@debian.org>
 <20131008172815.GA8313@atomide.com>
 <20131010172128.GF28657@earth.universe>
 <20131010182801.GB29989@blackmetal.musicnaut.iki.fi>
 <20131010200236.GA6603@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Date: Thu, 1 Jan 1970 01:03:13 +0100
Content-Disposition: inline
In-Reply-To: <20131010200236.GA6603@earth.universe>
Sender: linux-doc-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Stephen Rothwell <sfr@canb.auug.org.au>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, 'Beno?t Cousson' <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 'Pali Roh?r' <pali.rohar@gmail.com>, '???????????? ????????????????' <freemangordon@abv.bg>, Jon
List-Id: linux-omap@vger.kernel.org

Hi!

> 3. cmt_speech
> 
>  This is an hsi client driver, which takes care of interchanging
>  speech data with the modem. This one is needed for calling. I
>  will have a look at it once the basic stuff is working.
> 
> P.S.: You can get a mainline kernel status matrix for the Nokia
>       N900 on this page: http://elinux.org/N900

Thanks a lot for the page. I did not realize how well is N900 supported in
latest mainline...

What do you use as userland? Is there specific userland 3.13 is expected
to work with?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
