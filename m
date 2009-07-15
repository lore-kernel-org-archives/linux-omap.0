From: arno@natisbad.org (Arnaud Ebalard)
Subject: Re: N8x0 to mainline patches
Date: Wed, 15 Jul 2009 18:19:17 +0200
Message-ID: <873a8xor5m.fsf@small.ssi.corp>
References: <200907130950.09887.luke@dashjr.org>
	<87my776e9t.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:35594 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932142AbZGOQZG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jul 2009 12:25:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MR7Hz-0007as-6K
	for linux-omap@vger.kernel.org; Wed, 15 Jul 2009 16:25:03 +0000
Received: from cct.net8.nerim.net ([213.41.184.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 15 Jul 2009 16:25:03 +0000
Received: from arno by cct.net8.nerim.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 15 Jul 2009 16:25:03 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Valo <kalle.valo@iki.fi>

Hi,

Kalle Valo <kalle.valo@iki.fi> writes:

> "Luke-Jr" <luke@dashjr.org> writes:
>
>> I noticed that the patch adding board-n8x0.c seems to be much smaller
>> than the older one used in Linux-OMAP. In particular, it lacks the
>> keymaps and such. Are those somewhere else now? 
>
> It's just not implemented yet. If you look at the plan, you see lots
> of things we need to implement:
>
> http://www.elinux.org/N800#The_Plan

Just noticed the thread and the link today. I will try and merge some
notes I have on the topic (http://natisbad.org/N810/) tomorrow.


>> Was the Linux-OMAP keyboard bug taken into consideration for the new
>> keyboard config struct?
>
> I'm not familiar with the issue. But if it makes sense, sure, we want
> to include the fix.

I use the patch on a 2.6.30-rc8-omap1 based l-o commit on my N810 and it
fixes the reported issue (missing keys).

BTW, I also use the following patch to be able to use the fn key with
xorg. One would argue this would be better to handle the issue at
another level but it is worth discussing considering what I read on
various ML:

http://lists.freedesktop.org/archives/hal/2009-January/012860.html
http://lists.freedesktop.org/archives/hal/2009-January/012868.html
http://lists.freedesktop.org/archives/hal/2009-January/012794.html
http://www.gossamer-threads.com/lists/maemo/developers/35105,

When the rx44 keymap support is added back in your quilt set, can we
discuss it. IIRC, the same kind of value (i.e. > 255) is also in the
rx-51. Any specific reason? 

Cheers,

a+

Index: linux-omap-2.6/arch/arm/mach-omap2/board-n800.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-n800.c	2009-06-20 12:07:11.000000000 +0200
+++ linux-omap-2.6/arch/arm/mach-omap2/board-n800.c	2009-06-27 20:29:00.000000000 +0200
@@ -85,7 +85,11 @@
 	[0x22] = KEY_SEMICOLON,
 	[0x23] = KEY_MINUS,
 	[0x24] = KEY_EQUAL,
+#ifdef CONFIG_REMAP_N810_FN_KEY
+	[0x2b] = KEY_LEFTALT,
+#else
 	[0x2b] = KEY_FN,
+#endif
 	[0x2c] = KEY_M,
 	[0x2f] = KEY_F8,
 
Index: linux-omap-2.6/drivers/input/keyboard/Kconfig
===================================================================
--- linux-omap-2.6.orig/drivers/input/keyboard/Kconfig	2009-06-20 12:07:11.000000000 +0200
+++ linux-omap-2.6/drivers/input/keyboard/Kconfig	2009-06-20 12:07:35.000000000 +0200
@@ -294,6 +294,20 @@
 	  If you say yes here you get support for the National Semiconductor
 	  LM8323 keypad controller.
 
+config REMAP_N810_FN_KEY
+       boolean "Nokia N810 keyboard Fn key remapping"
+       depends on MACH_NOKIA_N810 && KEYBOARD_LM8323
+       help
+          If you build your kernel for your Nokia N810 (which would
+	  possibly explain you selected LM8323 keypad chip above),
+	  you might want to select this option in order to have the
+	  Fn key (KEY_FN) advertise itself as left alt key
+          (KEY_LEFTALT).
+
+	  This is because KEY_FN value is higher than 255, and Xorg
+	  basically drops those values. Selecting the option allows
+	  you to use the key under X
+
 config KEYBOARD_PXA27x
 	tristate "PXA27x/PXA3xx keypad support"
 	depends on PXA27x || PXA3xx


