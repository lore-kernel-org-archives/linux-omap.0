From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Mistral AM37x (with AM3715) devel board networking broken
Date: Mon, 8 Nov 2010 17:36:51 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302348EE00F@dbde02.ent.ti.com>
References: <E1PF7Q8-0004IQ-8y@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36437 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701Ab0KHMG7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 07:06:59 -0500
In-Reply-To: <E1PF7Q8-0004IQ-8y@amazonia.comcast.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>, "srinath@mistralsolutions.com" <srinath@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rick Bronson
> Sent: Sunday, November 07, 2010 9:15 PM
> To: srinath@mistralsolutions.com; linux-omap@vger.kernel.org
> Subject: RE: Mistral AM37x (with AM3715) devel board networking broken
> 
> sanjeev,
> 
>   Thanks much for the help.
> 
> > [sp] On first looks I would suspect the u-boot. 2009.11 
> seems to be quite old.
> >      Can you try using version 2010.09?
> 
>   I had tried 2010.09 on this board originally but found that it
> wasn't stable, it was almost like the SDRAM wasn't set up correctly.
> I'd get random panic's on bad pointers in Linux.  But I tried it
> anyway on this new kernel and it does set up the networking about 1 in
> 5 boots.  Here is a boot where it set up the network
> http://www.efn.org/~rick/pub/boot4.log, it still has the 
> warnings though.

[sp] If you noticed, earlier u-boot version was identifying your board as:

U-Boot 2009.11 (Oct 30 2010 - 13:14:45)                                         
                                                                                
OMAP34xx/35xx-GP ES1.0, CPU-OPP2 L3-165MHz                                      
OMAP3 EVM board + LPDDR/NAND                                                    

Now,

U-Boot 2010.09 (Nov 07 2010 - 07:08:44)                                         
                                                                                
OMAP3630/3730-GP ES1.0, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz                
OMAP3 EVM board + LPDDR/NAND     

That's ai improvement.

However, in your log, I see folloing:

[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Could not get gpios_ick
[    0.000000] Could not get gpios_fck

Looks like there are some changes - either in your Kconfig or
elsewhere in the code that "get" gpio clocks is failing.

The SMSC chip is "virtually" non-existent for the Linux kernel
here onwards.

My kernel version is "Linux-2.6.36-rc8-09072-g661df74-"

I have not yet looked at, but there is possible "break" on on mainline for EVM due to gpio related changes.
You could be experiencing this break...

~sanjeev

> 
>   Please check my setup of u-boot, here is what I did:
> 
> wget ftp://ftp.denx.de/pub/u-boot/u-boot-2010.09.tar.bz2
> tar jxf u-boot-2010.09.tar.bz2
> cd u-boot-2010.09; make omap3_evm_config; make
> 
>   Is this the correct config (omap3_evm_config) to use for this board?
> Maybe you could tell me what exact u-boot and kernel you'd recommend
> and the steps to get them for this board.
> 
>   Thanks,
> 
>   Rick
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 