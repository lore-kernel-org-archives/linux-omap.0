From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 13 Nov 2012 15:35:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211131531430.22487@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com> <508FB226.20604@mimc.co.uk> <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com> <508FE8BA.1080404@ti.com> <50912A6F.1040501@mimc.co.uk>
 <79CD15C6BA57404B839C016229A409A83EB563F8@DBDE01.ent.ti.com> <5097EF44.5030706@mimc.co.uk> <79CD15C6BA57404B839C016229A409A83EB63609@DBDE01.ent.ti.com> <5098DC9E.3090307@mimc.co.uk> <50A266C2.4030303@mimc.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46815 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab2KMPfI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 10:35:08 -0500
In-Reply-To: <50A266C2.4030303@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 13 Nov 2012, Mark Jackson wrote:

> On 06/11/12 09:47, Mark Jackson wrote:
>
> > That works ... great !!
> > 
> > But now I'm confused, since I thought the DTB was appended to the uImage file.

The DTB is appended to the zImage file.  You then need to convert the 
product of the concatenation to uImage format.

So ...

> > I have the following in my .config:-
> > 
> > ARM_ATAG_DTB_COMPAT=y
> > ARM_APPENDED_DTB=y
> > ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
> > 
> > And then I create my uImage file using:-
> > 
> > $ make -j 8 ARCH=arm CROSS_COMPILE=arm-linux- uImage
> > $ make -j 8 ARCH=arm CROSS_COMPILE=arm-linux- am335x-bone.dtb

instead of this:

> > $ cat arch/arm/boot/uImage arch/arm/boot/am335x-bone.dtb > arch/arm/boot/uImage-dtb.am335x-bone
> > $ cp arch/arm/boot/uImage-dtb.am335x-bone /media/boot/uImage

something like this is what you need to do instead:

$ cat arch/arm/boot/zImage arch/arm/boot/am335x-bone.dtb > arch/arm/boot/zImage-dtb.am335x-bone
$ scripts/mkuboot.sh -A arm -O linux -C none  -T kernel -a 0x80008000 -e 0x80008000 -n 'Linux' -d arch/arm/boot/zImage-dtb.am335x-bone arch/arm/boot/uImage-dtb.am335x-bone

> > Do you now have to load the DTB as a separate file ?
> > 
> > Or should the appended DTB still work ?

Appended DTBs work fine on the testbed here.


- Paul
