From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info clean up
Date: Wed, 12 Jun 2013 15:39:05 -0700
Message-ID: <87mwqvar92.fsf@linaro.org>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
	<1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
	<87zjv2ooxi.fsf@linaro.org> <51B58FE9.5040309@ti.com>
	<877gi1ew3r.fsf@linaro.org> <51B6A43C.10301@ti.com>
	<79CD15C6BA57404B839C016229A409A83ECAF76E@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:37665 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab3FLWjJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 18:39:09 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so4470952pab.22
        for <linux-omap@vger.kernel.org>; Wed, 12 Jun 2013 15:39:08 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83ECAF76E@DBDE04.ent.ti.com>
	(Vaibhav Hiremath's message of "Wed, 12 Jun 2013 06:00:12 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Vutla, Lokesh" <lokeshvutla@ti.com>, Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Hi Vaibhav,

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

[...]

> Paul/Kevin/Santosh,
>
> AM335x is booting up from Mainline, starting from v3.7, that=E2=80=99=
s where HWMOD data got merged to
> Mainline.
>
> We have discussed on this in the past as well, let me explain the iss=
ue here in detail
> again for everybody -

Thanks for the detail.

In my case, after more debug, it appears that where I was putting the
DTB in memory from u-boot was not working.   Using the addresses you
used gets things working again.  Thanks.

u-boot mainline (v2013.04) for BeagleBone has defaults that don't work
appear together:

U-Boot# printenv loadaddr
loadaddr=3D0x80200000
U-Boot# printenv fdtaddr
fdtaddr=3D0x80F80000

Changing fdtaddr around got things working again.  It's probably a good
idea to change the u-boot defaults to values that work, since that's a
likely starting point for people.

I'm now back to mainline booting well on both my original BeagleBone an=
d
my BeagleBone black.

Thanks,

Kevin

> In case of Am335x we have only two possible options, as AM335x only b=
oots up
> With DTB (Tested in BBB) -
>
> 1. Mainline u-boot + mainline Kernel:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1.a. Appended DTB method
> ------------------------
>
> Here you __must__ enabled below config options in order to get kernel=
 booting,
>
> CONFIG_ARM_APPENDED_DTB=3Dy
> CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=3Dy
>
> And, I have used below command to append DTB to kernel image
>
> # cat arch/arm/boot/zImage arch/arm/boot/dts/am335x-bone.dtb >
> zImage-append && mkimage -A arm -O linux -T kernel -C none -a
> 0x80008000 -e 0x80008000 -n "Linux" -d zImage-append uImage-append
>
>
> I have attached complete log here with this mail for reference
> http://pastebin.com/82duFh78
>
>
> 1.b. Discrete DTB and uImage method:
> ------------------------------------
>
> Here you don=E2=80=99t need to enable any extra config options. Plain=
 omap2plus_defconfig
> Should work without any issues.
>
> I have attached complete log here with this mail for reference
> http://pastebin.com/Nqr0PiwW
>
>
> 2. Older U-Boot (without DTB) + Mainline Kernel:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> This is same as #OPTION-1.a above.
>
>
> Thanks,
> Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
