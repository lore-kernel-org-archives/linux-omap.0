From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.20-rc0 breaks nfsroot over usb
Date: Thu, 26 Feb 2015 23:19:50 +0100
Message-ID: <20150226221950.GC10204@amd>
References: <20150217185518.GA3825@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150217185518.GA3825@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

> It no longer works after I merged
> 
> commit 796e1c55717e9a6ff5c81b12289ffa1ffd919b6f
> Merge: 8c334ce 45ee2db
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Mon Feb 16 15:48:00 2015 -0800
> 
>     Merge branch 'drm-next' of
>     git://people.freedesktop.org/~airlied/linux
> 
>     Pull drm updates from Dave Airlie:
>          "This is the main drm pull, it has a shared branch with some
>          alsa
>       crossover but everything should be acked by relevant people.
>     
> 
> If it works for you or if you have an idea, let me know...

Ok, it seems that new config dependencies broke my kconfig. These will
not be enabled if you just to make oldconfig; you want to make sure
they are on.

 OMAP2430 and onwards (USB_MUSB_OMAP2PLUS) [N/m/y] (NEW)
TWL4030 USB Transceiver Driver (TWL4030_USB) [N/m/y/?] (NEW)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
