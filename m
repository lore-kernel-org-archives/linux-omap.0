From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: OMAP3: USB: EHCI broken on 3.5?
Date: Thu, 02 Aug 2012 09:18:33 +0100
Message-ID: <WC20120802081833.1103C9@terrafix.co.uk>
References: <WC20120731124207.4902F1@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:39612 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751599Ab2HBISs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 04:18:48 -0400
In-Reply-To: <WC20120731124207.4902F1@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org
Cc: balbi@ti.com, linux-usb@vger.kernel.org

(Adding in the USB mailing list)...

It seems that the clocks are registered with a .dev_id of "usbhs_omap" on OMAP3xxx, but not OMAP4xxx, and that this causes the clk_get() in ehci-omap.c to fail.

The following fixes the problem for me, but I've no idea if this is the correct fix or not?

(sorry if the patch is mangled, using a naff webmail client).

--- a/arch/arm/mach-omap2/clock3xxx_data.c	2012-07-21 21:58:29.000000000 +0100
+++ b/arch/arm/mach-omap2/clock3xxx_data.c	2012-08-02 09:07:58.205633679 +0100
@@ -3391,15 +3391,15 @@
 	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("usbhs_omap",	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_omap",	"utmi_p1_gfclk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"utmi_p2_gfclk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"xclk60mhsp1_ck",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"xclk60mhsp2_ck",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_host_hs_utmi_p1_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_host_hs_utmi_p2_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_tll_hs_usb_ch0_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_tll_hs_usb_ch1_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"init_60m_fclk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"utmi_p1_gfclk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"utmi_p2_gfclk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"xclk60mhsp1_ck",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"xclk60mhsp2_ck",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"init_60m_fclk",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),


Cheers,
Joe

-----Original Message-----
From: "Joe Woodward" <jw@terrafix.co.uk>
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Date: Tue, 31 Jul 2012 13:42:07 +0100
Subject: OMAP3: USB: EHCI broken on 3.5?

> I have a GUMSTIX Overo AirSTORM (AM3703-based).
> 
> When running a 3.4 kernel the USB host works just fine!
> 
> However when switching to 3.5 I get a few new warning messages and USB
> host no longer works.
> 
> dmesg log after successfully loading the module (modprobe echi-hcd) on
> 3.4:
> [   23.424499] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI)
> Driver
> [   23.431427] ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 96
> [   23.431732] ehci-omap ehci-omap.0: failed to get ehci port1
> regulator
> [   23.431762] gpio_request: gpio-183 (USB2 PHY reset) status -16
> [   24.433471] ehci-omap ehci-omap.0: phy reset operation timed out
> [   24.433502] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=0
> cc=1 pcc=3 ordered ports=3
> [   24.433532] ehci-omap ehci-omap.0: reset hcc_params 0016 thresh 1
> uframes 256/512/1024 park
> [   24.433532] ehci-omap ehci-omap.0: reset command 0080b02  park=3
> ithresh=8 period=1024 Reset HALT
> [   24.433563] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
> [   24.440063] ehci-omap ehci-omap.0: new USB bus registered, assigned
> bus number 1
> [   24.448120] ehci-omap ehci-omap.0: park 0
> [   24.448181] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
> [   24.454162] ehci-omap ehci-omap.0: init command 0010005 (park)=0
> ithresh=1 period=512 RUN
> [   24.474517] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
> [   24.481597] usb usb1: default language 0x0409
> [   24.481658] usb usb1: udev 1, busnum 1, minor = 0
> [   24.481689] usb usb1: New USB device found, idVendor=1d6b,
> idProduct=0002
> [   24.488830] usb usb1: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [   24.496398] usb usb1: Product: OMAP-EHCI Host Controller
> [   24.501953] usb usb1: Manufacturer: Linux 3.4.0 ehci_hcd
> [   24.507537] usb usb1: SerialNumber: ehci-omap.0
> [   24.528747] usb usb1: usb_probe_device
> [   24.528778] usb usb1: configuration #1 chosen from 1 choice
> [   24.529479] usb usb1: adding 1-0:1.0 (config #1, interface 0)
> [   24.530212] hub 1-0:1.0: usb_probe_interface
> [   24.530242] hub 1-0:1.0: usb_probe_interface - got id
> [   24.530303] hub 1-0:1.0: USB hub found
> [   24.534362] hub 1-0:1.0: 3 ports detected
> [   24.538635] hub 1-0:1.0: standalone hub
> [   24.538635] hub 1-0:1.0: individual port power switching
> [   24.538665] hub 1-0:1.0: individual port over-current protection
> [   24.538665] hub 1-0:1.0: power on to power good time: 20ms
> [   24.539031] hub 1-0:1.0: local power source is good
> [   24.539062] hub 1-0:1.0: enabling power on all ports
> [   24.540008] ehci-omap ehci-omap.0: ...powerup ports...
> [   24.637634] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> [   27.013153] hub 1-0:1.0: hub_suspend
> [   27.015319] usb usb1: bus auto-suspend, wakeup 1
> [   27.015411] ehci-omap ehci-omap.0: suspend root hub
> 
> 
> dmesg log after failing to load the module (modprobe echi-hcd) on 3.5:
> [   83.900115] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI)
> Driver
> [   83.907043] ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 96
> [   83.907379] ehci-omap ehci-omap.0: failed to get ehci port1
> regulator
> [   84.912445] ehci-omap ehci-omap.0: phy reset operation timed out
> [   84.912475] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=0
> cc=1 pcc=3 ordered ports=3
> [   84.912475] ehci-omap ehci-omap.0: reset hcc_params 0016 thresh 1
> uframes 256/512/1024 park
> [   84.912506] ehci-omap ehci-omap.0: reset command 0080b02  park=3
> ithresh=8 period=1024 Reset HALT
> [   84.912506] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
> [   84.919097] ehci-omap ehci-omap.0: new USB bus registered, assigned
> bus number 1
> [   84.927154] ehci-omap ehci-omap.0: park 0
> [   84.927215] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
> [   84.933197] ehci-omap ehci-omap.0: init command 0010005 (park)=0
> ithresh=1 period=512 RUN
> [   84.946655] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
> [   84.953796] usb usb1: default language 0x0409
> [   84.953887] usb usb1: udev 1, busnum 1, minor = 0
> [   84.953887] usb usb1: New USB device found, idVendor=1d6b,
> idProduct=0002
> [   84.961059] usb usb1: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [   84.968627] usb usb1: Product: OMAP-EHCI Host Controller
> [   84.974151] usb usb1: Manufacturer: Linux 3.5.0 ehci_hcd
> [   84.979736] usb usb1: SerialNumber: ehci-omap.0
> [   84.987518] usb usb1: usb_probe_device
> [   84.987548] usb usb1: configuration #1 chosen from 1 choice
> [   84.988220] usb usb1: adding 1-0:1.0 (config #1, interface 0)
> [   84.988891] hub 1-0:1.0: usb_probe_interface
> [   84.988922] hub 1-0:1.0: usb_probe_interface - got id
> [   84.988983] hub 1-0:1.0: USB hub found
> [   84.993133] hub 1-0:1.0: 3 ports detected
> [   84.997344] hub 1-0:1.0: standalone hub
> [   84.997344] hub 1-0:1.0: individual port power switching
> [   84.997344] hub 1-0:1.0: individual port over-current protection
> [   84.997375] hub 1-0:1.0: power on to power good time: 20ms
> [   84.997711] hub 1-0:1.0: local power source is good
> [   84.997741] hub 1-0:1.0: enabling power on all ports
> [   84.998840] ehci-omap ehci-omap.0: ...powerup ports...
> [   85.030212] ehci-omap ehci-omap.0: utmi_p1_gfclk failed error:-2
> [   85.036560] ehci-omap: probe of ehci-omap.0 failed with error -2
> [   85.093658] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> [   87.093780] hub 1-0:1.0: hub_suspend
> [   87.095977] usb usb1: bus auto-suspend, wakeup 1
> [   87.096099] platform ehci-omap.0: suspend root hub
> 
> You can see that the following two new warnings are produced:
> [   85.030212] ehci-omap ehci-omap.0: utmi_p1_gfclk failed error:-2
> [   85.036560] ehci-omap: probe of ehci-omap.0 failed with error -2
> 
> If I (rather crudely) take ehci-omap.c from 3.4, drop it in to 3.5 and
> re-build then 3.5 works fine.
> 
> Any ideas?
> 
> Cheers,
> Joe Woodward
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


