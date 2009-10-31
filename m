From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: EHCI on 2.6.32-rc5-git4 + patches
Date: Sat, 31 Oct 2009 23:41:40 +0000
Message-ID: <4AECCB34.9010003@blueyonder.co.uk>
References: <4AEC544A.4000304@blueyonder.co.uk> <5A47E75E594F054BAF48C5E4FC4B92AB0309C86298@dbde02.ent.ti.com>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:43097 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933348AbZJaXlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 31 Oct 2009 19:41:47 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309C86298@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 31/10/09 17:08, Gadiyar, Anand wrote:
> Sid Boyce wrote:
>> There is no way to configure EHCI on beagleboard, so my devices are
>> never seen. Only OHCI has ARCH_ARM as a config option.
>> I shall edit it into drivers/usb/Kconfig and see if it works.
> 
> drivers/usb/Kconfig looks okay to me.
> 
> <http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=drivers/usb/Kconfig;h=5620e924a218da2bc5e03124934f339095dd18da;hb=HEAD>
> 
> See line 63 - it says USB_ARCH_HAS_EHCI is y if ARCH_OMAP34XX
> 
> - Anand
> 
> 
> 
> 

I am tried "beagleboard_defconfig" I downloaded, but when the .config
was written at the start of the kernel build ....
# CONFIG_USB_ARCH_HAS_EHCI is not set.
" make CROSS_COMPILE=/opt/arm-2009q1/bin/arm-none-linux-gnueabi-" on
Fedora 12.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

