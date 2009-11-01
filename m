From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: EHCI on 2.6.32-rc5-git4 + patches
Date: Sun, 01 Nov 2009 23:29:56 +0000
Message-ID: <4AEE19F4.70000@blueyonder.co.uk>
References: <4AEC544A.4000304@blueyonder.co.uk>	 <5A47E75E594F054BAF48C5E4FC4B92AB0309C86298@dbde02.ent.ti.com>	 <4AECCB34.9010003@blueyonder.co.uk> <4551feaf0911010742j6b68113cgb2e4246ca8b26237@mail.gmail.com>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:51847 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752123AbZKAX36 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Nov 2009 18:29:58 -0500
In-Reply-To: <4551feaf0911010742j6b68113cgb2e4246ca8b26237@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 01/11/09 15:42, Robert Nelson wrote:
>> I am tried "beagleboard_defconfig" I downloaded, but when the .config
>> was written at the start of the kernel build ....
>> # CONFIG_USB_ARCH_HAS_EHCI is not set.
>> " make CROSS_COMPILE=/opt/arm-2009q1/bin/arm-none-linux-gnueabi-" on
>> Fedora 12.
>> Regards
>> Sid.
> 
> Hi Sid,
> 
> You need atleast the "ehci glue commit" from here to enable the option:
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=refs/heads/ehci
> 
> Regards,
> 

I've used the "Merge EHCI" snapshot, but guess there is something not
right in my .config.
  CC      drivers/usb/musb/musb_core.o
In file included from drivers/usb/musb/musb_core.c:108:
drivers/usb/musb/musb_core.h:94:2: error: #error bogus Kconfig output
... select CONFIG_USB_GADGET_MUSB_HDRC
drivers/usb/musb/musb_core.c: In function 'musb_init_controller':
drivers/usb/musb/musb_core.c:1906: error: label 'bad_config' used but
not defined
make[2]: *** [drivers/usb/musb/musb_core.o] Error 1
make[1]: *** [drivers/usb/musb] Error 2
make: *** [drivers] Error 2
[root@localhost linux-omap-2.6]# grep MUSB .config
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_SOC=y
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_PERIPHERAL is not set
CONFIG_USB_MUSB_OTG=y
# CONFIG_USB_GADGET_MUSB_HDRC is not set
CONFIG_USB_MUSB_HDRC_HCD=y
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_MUSB_DEBUG is not set

Regards
Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

