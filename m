From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 09:40:34 -0800
Message-ID: <5e088bd90812110940k158b14dbq6ea9ff4138e52dfb@mail.gmail.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
	 <1228926833.32014.162.camel@localhost.localdomain>
	 <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>
	 <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
	 <20081211005733.GZ18138@atomide.com>
	 <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f12.google.com ([209.85.217.12]:35202 "EHLO
	mail-gx0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982AbYLKRnO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 12:43:14 -0500
Received: by gxk5 with SMTP id 5so520427gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 09:43:13 -0800 (PST)
In-Reply-To: <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>

On Thu, Dec 11, 2008 at 2:38 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
>> Can you please post whatever patches you need to apply to make it work
>> occasionally so others can also look at the issue?
>
> For pandora, making infinite while loops finite doesn't help much,
> kernel crashes later on. Steve had this too:
> http://marc.info/?l=linux-omap&m=122378604027303&w=2
>
> I did bisect and found that commit
> 8b1f0bd44fe490ec631230c8c040753a2bda8caa is causing the hang for me.
> Reverting this makes EHCI work again on pandora.
> http://marc.info/?l=linux-omap&m=122453174024860&w=2
>

A simple revert of that commit resulted in a build failure, so I tried
the following patch:

--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -265,7 +265,7 @@ static int _omap3_noncore_dpll_stop(stru
 */
 static int omap3_noncore_dpll_enable(struct clk *clk)
 {
-       int r;
+       int r, rate;
       struct dpll_data *dd;

       if (clk == &dpll3_ck)
@@ -275,7 +275,9 @@ static int omap3_noncore_dpll_enable(str
       if (!dd)
               return -EINVAL;

-       if (clk->rate == dd->bypass_clk->rate)
+       rate = omap2_get_dpll_rate(clk);
+
+       if (dd->bypass_clk->rate == rate)
               r = _omap3_noncore_dpll_bypass(clk);
       else
               r = _omap3_noncore_dpll_lock(clk);

Result: no hang at boot, but I still end up with the auto suspend,
though the behavior is slightly different (dmesg output this time
since it contains more debug info):

ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd: block sizes: qh 128 qtd 96 itd 160 sitd 96
ehci-omap ehci-omap.0: ehci_hcd_omap_drv_probe()
ehci-omap ehci-omap.0: starting TI EHCI USB Controller
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: idlest2 = 0x0
ehci-omap ehci-omap.0: TLL RESET DONE
ehci-omap ehci-omap.0: Entered ULPI PHY MODE: success
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
drivers/usb/core/inode.c: creating file '002'
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 2
ehci-omap ehci-omap.0: park 0
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: reset command 090b02 park=3 ithresh=9
period=1024 Reset HALT
ehci-omap ehci-omap.0: init command 010009 (park)=0 ithresh=1 period=256 RUN
usb 1-1: new high speed USB device using musb_hdrc and address 2
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
usb usb2: default language 0x0409
usb usb2: uevent
usb usb2: usb_probe_device
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: uevent
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: individual port power switching
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 20ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: enabling power on all ports
drivers/usb/core/inode.c: creating file '001'
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OMAP-EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.28-rc7-omap1 ehci_hcd
usb usb2: SerialNumber: ehci-omap.0
<snip>
hub 2-0:1.0: state 7 ports 3 chg 0000 evt 0000
<snip>
usb usb2: uevent
usb 2-0:1.0: uevent
<snip>
hub 2-0:1.0: hub_suspend
usb usb2: bus auto-suspend
ehci-omap ehci-omap.0: suspend root hub
<snip>
usb usb2: usb auto-resume
ehci-omap ehci-omap.0: resume root hub
hub 2-0:1.0: hub_resume
hub 2-0:1.0: state 7 ports 3 chg 0000 evt 0000
hub 2-0:1.0: hub_suspend
usb usb2: bus auto-suspend
ehci-omap ehci-omap.0: suspend root hub
