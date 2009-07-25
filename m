From: Paul Walmsley <paul@pwsan.com>
Subject: Re: n800 can't mount rootfs
Date: Fri, 24 Jul 2009 19:26:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907241925010.2700@utopia.booyaka.com>
References: <87d49h4xj9.fsf@litku.valot.fi> <alpine.DEB.2.00.0907241849550.2700@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56351 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbZGYB0I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 21:26:08 -0400
In-Reply-To: <alpine.DEB.2.00.0907241849550.2700@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: linux-omap@vger.kernel.org

On Fri, 24 Jul 2009, Paul Walmsley wrote:

> On Sat, 6 Jun 2009, Kalle Valo wrote:
> 
> > [    0.000000] kobject (c031e048): tried to init an initialized object,
> > something is seriously wrong.
> > [    0.000000] [<c002c674>] (unwind_backtrace+0x0/0xdc) from
> > [<c0103654>] (kobject_init+0x38/0x70)
> > [    0.000000] [<c0103654>] (kobject_init+0x38/0x70) from [<c013fbfc>]
> > (device_initialize+0x20/0x70)
> > [    0.000000] [<c013fbfc>] (device_initialize+0x20/0x70) from
> > [<c0143408>] (platform_device_register+0x10/0x1c)
> > [    0.000000] [<c0143408>] (platform_device_register+0x10/0x1c) from
> > [<c000e7a0>] (gpmc_onenand_init+0x4c/0x74)
> > [    0.000000] [<c000e7a0>] (gpmc_onenand_init+0x4c/0x74) from
> > [<c000b13c>] (customize_machine+0x18/0x24)
> > [    0.000000] [<c000b13c>] (customize_machine+0x18/0x24) from
> > [<c00262bc>] (do_one_initcall+0x54/0x194)
> > [    0.000000] [<c00262bc>] (do_one_initcall+0x54/0x194) from
> > [<c00083b8>] (kernel_init+0x70/0xe4)
> > [    0.000000] [<c00083b8>] (kernel_init+0x70/0xe4) from [<c004d498>]
> > (do_exit+0x0/0x580)
> > [    0.000000] [<c004d498>] (do_exit+0x0/0x580) from [<00000001>] (0x1)
> > [    0.000000] ------------[ cut here ]------------
> 
> I get the same thing on N800 (compiling at 
> 7c5cb7862d32cb344be7831d466535d5255e35ac). 

For the archives: this is fixed by 

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index fee6c62..bea182d 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -566,7 +566,6 @@ static void __init nokia_n800_init(void)
 
 	n800_ts_set_config();
 	tea5761_dev_init();
-	board_onenand_init();
 }
 
 void __init nokia_n800_map_io(void)



- Paul
