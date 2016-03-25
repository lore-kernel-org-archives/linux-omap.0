From: Pavel Machek <pavel@ucw.cz>
Subject: Re: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
Date: Fri, 25 Mar 2016 22:15:42 +0100
Message-ID: <20160325211542.GA11978@amd>
References: <20160317212603.GA16651@amd>
 <CAB=otbSfj24nSUe1DyfVBDKD=trCp2-X-S-AcA1D+PTHZuP1Bg@mail.gmail.com>
 <20160318202041.GA20196@amd>
 <56EFE057.7070106@samsung.com>
 <20160323122143.GB32031@amd>
 <CAB=otbT2VsZ8Rhc-jbKwtRAssn01ecVFyTyAp+5hS=d40AsGKA@mail.gmail.com>
 <CAB=otbQdpEtsXg2etX+3YYjrTfPYGtdKJo_V_rtfNb+VNV7g-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAB=otbQdpEtsXg2etX+3YYjrTfPYGtdKJo_V_rtfNb+VNV7g-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, serge@hallyn.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Peter Chen <peter.chen@freescale.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> OK, so at last I finished charging of my N900; found 1.8V USB
> to UART adapter and soldered it to the phone.
> 
> I managed to boot N900 with working USB gadget (builtin g_ether)
> in boardfile mode, can ping it from PC and transfer data. I don't
> see any issue (except of musb name issue in twl phy driver, I've
> already sent a fix for that: https://lkml.org/lkml/2016/3/24/670 )

I tried to add that one, too, and no change. Can I get your .config?

Thanks and best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
