From: Felipe Balbi <balbi@ti.com>
Subject: Re: twl4030_usb porting advice
Date: Thu, 16 Dec 2010 11:09:56 +0200
Message-ID: <20101216090956.GG2601@legolas.emea.dhcp.ti.com>
References: <4D08ACAC.8070900@xlogic.pl>
 <20101215121023.GN2997@legolas.emea.dhcp.ti.com>
 <4D08B41E.7090400@xlogic.pl>
 <20101215123912.GC6734@legolas.emea.dhcp.ti.com>
 <4D08BE16.4020704@xlogic.pl>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51095 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752136Ab0LPJKC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 04:10:02 -0500
Received: by eyh5 with SMTP id 5so1591665eyh.9
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 01:10:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D08BE16.4020704@xlogic.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomasz Mloduchowski <tomasz.mloduchowski@xlogic.pl>
Cc: balbi@ti.com, linux-omap@vger.kernel.org

On Wed, Dec 15, 2010 at 01:09:42PM +0000, Tomasz Mloduchowski wrote:
>On 12/15/10 12:39, Felipe Balbi wrote:
>>On Wed, Dec 15, 2010 at 12:27:10PM +0000, Tomasz Mloduchowski wrote:
>>>>>I would gladly welcome any pointers that could help me solve this
>>>>>issue.
>>>>
>>>>you're connecting a FS/LS device to EHCI port, that doesn't work. OMAP
>>>>can't handle port handoff to companion OHCI controller, then it fails
>>>>not being able to enumerate the device. Try remuxing your port to OHCI
>>>>controller and disabling EHCI from Kconfig.
>>>
>>>It actually is a HS device (it's a 4-port hub) - when booting the
>>>vendor supplied kernel (based off 2.6.32, i.e. pre -IR redesign), the
>>>device identifies as follows:
>>>
>>>Bus 001 Device 002: ID 05e3:0608 Genesys Logic, Inc. USB-2.0 4-Port HUB
>>>
>>>with the following boot messages:
>>>
>>>usb 1-2: new high speed USB device using ehci-omap and address 2
>>>usb 1-2: New USB device found, idVendor=05e3, idProduct=0608
>>>usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
>>>usb 1-2: Product: USB2.0 Hub
>>>hub 1-2:1.0: USB hub found
>>>hub 1-2:1.0: 4 ports detected
>>>
>>>
>>>I've pasted the boot log for my kernel:
>>>http://pastie.org/1379102
>>>
>>>And the boot log for the original kernel:
>>>http://pastie.org/1379100
>>
>>It could be a bug on the reset sequence on ehci-omap.c, do you have
>>anything connected to any of the hub ports ?
>>
>>Please enable CONFIG_USB_DEBUG on your kernel config and grab a bit more
>>information.
>>
>>Also, boot the machine without the device attached and after booting
>>run:
>>
>># dmesg -c
>>
>>then attach the device, then grab the output of dmesg.
>>
>
>I don't have the ability to disconnect the hub - it's integrated on 
>the board :(

I see.

>I've also made a mistake describing the pastebins - the working, PSP 
>kernel boot log is here:
>http://pastie.org/1379102
>
>while the non-working git kernel messages are here (with CONFIG_USB_DEBUG):
>http://pastie.org/1379100

I'm quoting a snippet below for commenting.

> [    1.639892] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.646759] ehci_hcd: block sizes: qh 60 qtd 96 itd 160 sitd 96
> [    1.646881] ehci-omap ehci-omap.0: failed to get ehci port1 regulator

This is alarming. Please add this patch to get the error code:

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 116ae28..5da3fa3 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -682,7 +682,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
                 if (IS_ERR(omap->regulator[i])) {
                         omap->regulator[i] = NULL;
                         dev_dbg(&pdev->dev,
-                       "failed to get ehci port%d regulator\n", i);
+                       "failed to get ehci port%d regulator --> %d\n", i,
+                       PTR_ERR(omap->regulator[i]));
                 } else {
                         regulator_enable(omap->regulator[i]);
                 }

> [    1.646911] ehci-omap ehci-omap.0: starting TI EHCI USB Controller
> [    1.647064] ehci-omap ehci-omap.0: OMAP UHH_REVISION 0x10
> [    1.647094] ehci-omap ehci-omap.0: TLL RESET DONE
> [    1.647094] ehci-omap ehci-omap.0: OMAP3 ES version > ES2.1
> [    1.647125] ehci-omap ehci-omap.0: UHH setup done, uhh_hostconfig=21c
> [    2.649841] ehci-omap ehci-omap.0: phy reset operation timed out

This is also alarming... Let's increase the timeout just for a debugging
purpose:

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 116ae28..fa8bff0 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -239,7 +239,7 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
  
  static void omap_ehci_soft_phy_reset(struct ehci_hcd_omap *omap, u8 port)
  {
-       unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+       unsigned long timeout = jiffies + msecs_to_jiffies(10000);
         unsigned reg = 0;
  
         reg = ULPI_FUNC_CTRL_RESET

beware, this might slow your boot time quite a lot :-p

The rest is just continuing the enumeration and there's not much
interesting there besides the "unable to enumerate" message, which could
be caused by the two problems above.

-- 
balbi
