From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: [PATCHv2 0/4] Omap-related warnings compiling current mainline 3.1-rc tree
Date: Fri, 12 Aug 2011 17:27:17 +0200
Message-ID: <CAFULf_yYdu1jMSxou-GPr7voXArTnm5=s0U1ZcP=FQ3VUzhs0g@mail.gmail.com>
References: <CAFULf_yR-Z8p4CWaM6i1A9GedvRGG2omBG2TVtmma09n1jyHWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43415 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab1HLP1S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 11:27:18 -0400
Received: by vws1 with SMTP id 1so2527379vws.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Aug 2011 08:27:18 -0700 (PDT)
In-Reply-To: <CAFULf_yR-Z8p4CWaM6i1A9GedvRGG2omBG2TVtmma09n1jyHWw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

V2:
 - Add missing sob.
 - Warnings verified to be present in 3.1-rc1 also.

---
Compiling the current mainline tree (commit
288d5abec8314ae50fe6692f324b0444acae8486) produces some omap-related
warnings.  Most of them are harmless, and they are simple enough to
fix that even I can do it.  I hope..

The compiler warnings from running `make omap2plus_defconfig uImage
CONFIG_DEBUG_SECTION_MISMATCH=1':
...
 CC      arch/arm/mach-omap2/clock44xx_data.o
arch/arm/mach-omap2/clock44xx_data.c: In function 'omap4xxx_clk_init':
arch/arm/mach-omap2/clock44xx_data.c:3371: warning: 'cpu_clkflg' may
be used uninitialized in this function
...
 CC      arch/arm/mach-omap2/usb-musb.o
arch/arm/mach-omap2/usb-musb.c:71: warning: 'usb_musb_mux_init'
defined but not used
arch/arm/mach-omap2/usb-musb.c: In function 'usb_musb_init':
arch/arm/mach-omap2/usb-musb.c:141: warning: 'dev' may be used
uninitialized in this function
...
 CC      arch/arm/mach-omap2/display.o
arch/arm/mach-omap2/display.c: In function 'omap_display_init':
arch/arm/mach-omap2/display.c:101: warning: assignment from
incompatible pointer type
...
 LD      arch/arm/mach-omap2/built-in.o
WARNING: arch/arm/mach-omap2/built-in.o(.data+0x354d0): Section
mismatch in reference from the variable keypad_data to the (unknown
reference) .init.data:(unknown)
The variable keypad_data references
the (unknown reference) __initdata (unknown)

By applying the patches is this series, most of these warnings are gone.

The warning from omap_display has not been fixed.  I could do
something similar to what hsmmc.c is using, but I think this is
unnessarily complex.  I think the real fix for this warning is to make
the type of the returned value from
omap_pm_get_dev_context_loss_count() be the same as the prototype in
struct omap_dss_board_info.  I can't see why one should be u32, and
the other int.  However, I don't know which to fix..

The resulting kernel has been booted on a pandaboard.

Bjarne Steinsbo
