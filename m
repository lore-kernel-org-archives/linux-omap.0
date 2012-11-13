From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 13 Nov 2012 15:26:58 +0000
Message-ID: <50A266C2.4030303@mimc.co.uk>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com> <508FB226.20604@mimc.co.uk> <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com> <508FE8BA.1080404@ti.com> <50912A6F.1040501@mimc.co.uk> <79CD15C6BA57404B839C016229A409A83EB563F8@DBDE01.ent.ti.com> <5097EF44.5030706@mimc.co.uk> <79CD15C6BA57404B839C016229A409A83EB63609@DBDE01.ent.ti.com> <5098DC9E.3090307@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:58035 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750779Ab2KMP1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 10:27:00 -0500
In-Reply-To: <5098DC9E.3090307@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 06/11/12 09:47, Mark Jackson wrote:
> On 06/11/12 06:16, Hiremath, Vaibhav wrote:
>>
>> Where is your DTB? Is it appended to Kernel image?
>> Can you try below sequence/commands from u-boot?
>>
>>
>> mmc rescan 0
>> fatload mmc 0 80000000 am335x-bone.dtb
>> fatload mmc 0 81000000 uImage
>> setenv bootargs console=ttyO0,115200n8 mem=256M root=/dev/mmcblk0p2 rw noinitrd rootfstype=ext3 rootwait earlyprink=serial
>> sendln 'bootm 81000000 - 80000000'
>>
>>
>>
>> To build DTB files, use "make dtbs" command on your kernel home directory.
> 
> That works ... great !!
> 
> But now I'm confused, since I thought the DTB was appended to the uImage file.
> 
> I have the following in my .config:-
> 
> ARM_ATAG_DTB_COMPAT=y
> ARM_APPENDED_DTB=y
> ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
> 
> And then I create my uImage file using:-
> 
> $ make -j 8 ARCH=arm CROSS_COMPILE=arm-linux- uImage
> $ make -j 8 ARCH=arm CROSS_COMPILE=arm-linux- am335x-bone.dtb
> $ cat arch/arm/boot/uImage arch/arm/boot/am335x-bone.dtb > arch/arm/boot/uImage-dtb.am335x-bone
> $ cp arch/arm/boot/uImage-dtb.am335x-bone /media/boot/uImage
> 
> Do you now have to load the DTB as a separate file ?
> 
> Or should the appended DTB still work ?

Any update on this ?

Cheers
Mark J.

