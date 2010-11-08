From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Mistral AM37x (with AM3715) devel board networking broken
Date: Mon, 8 Nov 2010 20:55:06 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302348EE0D4@dbde02.ent.ti.com>
References: <E1PF7Q8-0004IQ-8y@amazonia.comcast.net>
 <B85A65D85D7EB246BE421B3FB0FBB59302348EE00F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56158 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab0KHPZR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 10:25:17 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302348EE00F@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Rick Bronson <rick@efn.org>, "srinath@mistralsolutions.com" <srinath@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Monday, November 08, 2010 5:37 PM
> To: Rick Bronson; srinath@mistralsolutions.com; 
> linux-omap@vger.kernel.org
> Subject: RE: Mistral AM37x (with AM3715) devel board networking broken
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rick Bronson
> > Sent: Sunday, November 07, 2010 9:15 PM
> > To: srinath@mistralsolutions.com; linux-omap@vger.kernel.org
> > Subject: RE: Mistral AM37x (with AM3715) devel board 
> networking broken
> > 
> > sanjeev,
> > 
> >   Thanks much for the help.
> > 
> > > [sp] On first looks I would suspect the u-boot. 2009.11 
> > seems to be quite old.
> > >      Can you try using version 2010.09?
> > 
> >   I had tried 2010.09 on this board originally but found that it
> > wasn't stable, it was almost like the SDRAM wasn't set up correctly.
> > I'd get random panic's on bad pointers in Linux.  But I tried it
> > anyway on this new kernel and it does set up the networking 
> about 1 in
> > 5 boots.  Here is a boot where it set up the network
> > http://www.efn.org/~rick/pub/boot4.log, it still has the 
> > warnings though.
> 
> [sp] If you noticed, earlier u-boot version was identifying 
> your board as:
> 
> U-Boot 2009.11 (Oct 30 2010 - 13:14:45)                       
>                   
>                                                               
>                   
> OMAP34xx/35xx-GP ES1.0, CPU-OPP2 L3-165MHz                    
>                   
> OMAP3 EVM board + LPDDR/NAND                                  
>                   
> 
> Now,
> 
> U-Boot 2010.09 (Nov 07 2010 - 07:08:44)                       
>                   
>                                                               
>                   
> OMAP3630/3730-GP ES1.0, CPU-OPP2, L3-165MHz, Max CPU Clock 1 
> Ghz                
> OMAP3 EVM board + LPDDR/NAND     
> 
> That's ai improvement.
> 
> However, in your log, I see folloing:
> 
> [    0.000000] Total of 96 interrupts on 1 active controller
> [    0.000000] Could not get gpios_ick
> [    0.000000] Could not get gpios_fck
> 
> Looks like there are some changes - either in your Kconfig or
> elsewhere in the code that "get" gpio clocks is failing.
> 
> The SMSC chip is "virtually" non-existent for the Linux kernel
> here onwards.
> 
> My kernel version is "Linux-2.6.36-rc8-09072-g661df74-"
> 
> I have not yet looked at, but there is possible "break" on on 
> mainline for EVM due to gpio related changes.
> You could be experiencing this break...
> 
> ~sanjeev

[snip]

I tried building the latest on l-o master and was able to boot consistently
in 4 times I tried. Didn't notice the gpio clock related error I noticed in
your boot log.


U-Boot 2010.09 (Nov 08 2010 - 17:11:45)

OMAP3630/3730-GP ES2.0, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
OMAP3 EVM board + LPDDR/NAND
...
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/200/600 MHz
[    0.000000] Reprogramming SDRC clock to 200000000 Hz
[    0.000000] dpll3_m2_clk rate change failed: -22
[    0.000000] GPMC revision 5.0
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP GPIO hardware version 2.5
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
...
[    2.061950] net eth0: SMSC911x/921x identified at 0xc8880000, IRQ: 336
[    3.075561] Sending DHCP requests .., OK
[    5.169769] IP-Config: Got DHCP answer from 0.0.0.0, my address is xx.yy.zz.00(edited)
...

# uname -a
Linux OMAP3EVM 2.6.37-rc1-08879-g9988a6b-dirty #1 Mon Nov 8 19:50:18 IST 2010 armv7l unknown
#
