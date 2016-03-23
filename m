From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Wed, 23 Mar 2016 13:38:01 +0100
Message-ID: <20160323123801.GC32031@amd>
References: <20160126140010.GA29723@amd>
 <20160126172527.GY3500@atomide.com>
 <20160130200244.GA30429@amd>
 <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd>
 <20160209172403.GK19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160209172403.GK19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > > 055555fc459 ("usb: musb: core: Fix handling of the phy notifications")
> > > 03e43528ab68 ("usb: musb: Fix unbalanced pm_runtime_enable")
> > 
> > Ok, with that, I can insmod and rmmod. But I still get:
> > 
> > 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> 
> I think the cm_idlest_per is fine.
> 
> > ffdffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200042
> > 0000000d 48004a28 (fa004a28) cm_idlest3_core
> 
> Bit 21 in cm_idlest1_core is for MCSPI4 so WLAN. Does that go
> down if do sleep 5; cat /sys/kernel/debug/pm_debug/count ?
> 
> If not, the're PM runtime missing or broken somewhere.
> 
> FYI, below is my omap3 usb test script that I use to start and
> stop USB, it also works on n900. And after stopping it n900
> continues hitting deeper idle states just fine.

You rmmod musb_hdrc, so I checked, and found:

550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1093)
static void musb_shutdown(struct platform_de
vice *pdev)
550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1094) {
550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1095)
struct musb     *musb = dev_to_musb(&pdev
->dev);
550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1096)
unsigned long   flags;
550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1097)
4f9edd2d7 (Hema HK                   2011-03-22 16:02:12 +0530 1098)
pm_runtime_get_sync(musb->controller);
24307caef (Grazvydas Ignotas         2012-01-12 15:22:45 +0200 1099)
2cc65feab (Daniel Mack               2013-04-10 21:55:47 +0200 1100)
musb_host_cleanup(musb);
24307caef (Grazvydas Ignotas         2012-01-12 15:22:45 +0200 1101)
musb_gadget_cleanup(musb);
24307caef (Grazvydas Ignotas         2012-01-12 15:22:45 +0200 1102)
550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1103)
spin_lock_irqsave(&musb->lock, flags);
550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1104)
musb_platform_disable(musb);
550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1105)
musb_generic_disable(musb);
550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1106)
spin_unlock_irqrestore(&musb->lock, flags
);
550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1107)
120d074c5 (Grazvydas Ignotas         2010-10-10 13:52:22 -0500 1108)
musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
120d074c5 (Grazvydas Ignotas         2010-10-10 13:52:22 -0500 1109)
musb_platform_exit(musb);
120d074c5 (Grazvydas Ignotas         2010-10-10 13:52:22 -0500 1110)
4f9edd2d7 (Hema HK                   2011-03-22 16:02:12 +0530 1111)
pm_runtime_put(musb->controller);
550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1112)
/* FIXME power down */
550a7375f (Felipe Balbi              2008-07-24 12:27:36 +0300 1113) }

I thought i was responsible for the FIXME, but apparently not... If
you happen to have some changes there, that would be useful to
know....

Ok, another attempt at shutting USB down:

00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
f7dffe9d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200062
0000000d 48004a28 (fa004a28) cm_idlest3_core

Tried again today:

00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
f7dffe9d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200062
0000000d 48004a28 (fa004a28) cm_idlest3_core
pavel@n900:/my/tui/ofone$ sleep test

00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
ffde7e9d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218062
0000000d 48004a28 (fa004a28) cm_idlest3_core

00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
fedffe9d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 01200062
0000000d 48004a28 (fa004a28) cm_idlest3_core

00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
ffde7e9d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218062
0000000d 48004a28 (fa004a28) cm_idlest3_core

Is there documentation for the cm_idlest1_ bits?

How idle system do I need to have? Screen is blanked and machine
should be mostly idle, but there's X running on another vt with Mate
desktop, and some python scripts... GSM modem should be online.

Are you booting over USB from NOLO?

Thanks and best regards,

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
