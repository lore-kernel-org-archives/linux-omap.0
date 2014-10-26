From: Pavel Machek <pavel@ucw.cz>
Subject: Re: USB Ethernet gadget on Nokia n900
Date: Sun, 26 Oct 2014 22:55:48 +0100
Message-ID: <20141026215548.GA9004@amd>
References: <20141019090107.GA19132@amd>
 <201410261212.46582@pali>
 <20141026211721.GA7351@amd>
 <201410262222.39892@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201410262222.39892@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


> > I have root prepared on /dev/mmcblk0p6. I tried 3.17 with
> > rx51_defconfig, but no, it refuses to mount it.
> > 
> > VFS: Cannot open root device "mmcblk0p6" or ....: error -19.
> > 
> > And then it proceeds to list mmcblk0p6 as one of available
> > options
> > 
> > :-(.
> > 
> > Ideas welcome.
> 
> Try to add rootdelay=30 or rootwait to kernel cmdline.

I had rootdelay=3. Will try rootwait... no change. This is v3.17 with
rx51_defconfig. CONFIG_MACH_NOKIA_RX51=y => device tree will not be
used AFAICT.

Now I'm back at 3.14 without device tree; same setup works there. I
tried disabling RX51 support in 3.14 (to make it boot using device
tree) but that did not work.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
