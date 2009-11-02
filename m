From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: EHCI on 2.6.32-rc5-git4 + patches
Date: Mon, 2 Nov 2009 09:04:09 +0200
Message-ID: <20091102070409.GA17351@nokia.com>
References: <4AEC544A.4000304@blueyonder.co.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C86298@dbde02.ent.ti.com>
 <4AECCB34.9010003@blueyonder.co.uk>
 <4551feaf0911010742j6b68113cgb2e4246ca8b26237@mail.gmail.com>
 <4AEE19F4.70000@blueyonder.co.uk>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61160 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbZKBHFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 02:05:17 -0500
Content-Disposition: inline
In-Reply-To: <4AEE19F4.70000@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sid Boyce <sboyce@blueyonder.co.uk>
Cc: Robert Nelson <robertcnelson@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Nov 02, 2009 at 12:29:56AM +0100, ext Sid Boyce wrote:
> On 01/11/09 15:42, Robert Nelson wrote:
> >> I am tried "beagleboard_defconfig" I downloaded, but when the .config
> >> was written at the start of the kernel build ....
> >> # CONFIG_USB_ARCH_HAS_EHCI is not set.
> >> " make CROSS_COMPILE=/opt/arm-2009q1/bin/arm-none-linux-gnueabi-" on
> >> Fedora 12.
> >> Regards
> >> Sid.
> > 
> > Hi Sid,
> > 
> > You need atleast the "ehci glue commit" from here to enable the option:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=refs/heads/ehci
> > 
> > Regards,
> > 
> 
> I've used the "Merge EHCI" snapshot, but guess there is something not
> right in my .config.
>   CC      drivers/usb/musb/musb_core.o
> In file included from drivers/usb/musb/musb_core.c:108:
> drivers/usb/musb/musb_core.h:94:2: error: #error bogus Kconfig output
> ... select CONFIG_USB_GADGET_MUSB_HDRC

Go to gadget support and select Inventra MUSB on "USB Peripheral
Controller"

-- 
balbi
