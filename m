From: "Jeff Graham" <Jeff.Graham@brukeroptics.com>
Subject: Re: general kernel building questions
Date: Fri, 18 Feb 2011 15:55:07 -0500
Message-ID: <F752F64AD8BC1D42B49B877FEE3CD34901410C2A@USTED.BOPTUS.OPTIK.LAN>
Reply-To: <jeg@brukeroptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.bruker.com ([173.13.75.234]:3872 "EHLO mx1.bruker.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598Ab1BRU50 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 15:57:26 -0500
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: gadiyar@ti.com

Hello,

I have downloaded the kernel yesterday (Feb 17) using:
git clone -depth 1 git://git.kernel.org/pub/scm/linux/kernel/git/tmlind=
/linux-omap-2.6.git

Then today I did a "git pull" to sync up. So I think I am ready to atte=
mpt a kernel compile. I hope this kernel is stable. I need the touchscr=
een, USB and Ethernet to work.

Now I need to find the config files for the Overo Fire and the TI DM373=
0 EVM board. In the directory <kernel>/arch/arm/configs I see these can=
didates:
=A0=A0=A0=A0=A0 davinci_all_defconfig
=A0=A0=A0=A0=A0 omap2plus_defconfig

I assume that one of these is correct.

Is there a 'special' config file I should download from somewhere for t=
he Overo Fire or TI EVM? Or do both boards (or all omap boards?) use th=
e same defconfig?

I have configured Intel kernels before, but not an Arm kernel, so I don=
't know where the dragons are. What I am asking is how to config the ke=
rnel for my 2 boards...I don't find a canonical .config file anywhere t=
o start from: what menu options need to be configured, need to be modul=
es or need to be built in, which ones to not enable, etc. As a strategy=
 I can start from the current /proc/config.gz, but since this is for ol=
der kernels I assume there are changes that must be made.

Does the configure script somehow pick up the correct defconfig when I =
specify the arch from within menuconfig?


My two systems are:

Component=A0=A0TI MISTRAL OMAP EVM=A0=A0=A0=A0Overo FIRE
---------=A0=A0---------------------=A0=A0---------------
x-loader=A0=A0=A01.46 (Aug 16 2010)=A0=A0=A0=A0=A01.4.2 (Jan 13 2010)
U-boot=A0=A0=A0=A0=A02009.11 (Aug 16 2010)=A0=A02009.11 (Jan 13 2010)
kernel=A0=A0=A0=A0=A02.6.32 (sdk@nemo)=A0=A0=A0=A0=A0=A02.6.32 (steve@w=
ww.sakoman.com)
distro=A0=A0=A0=A0=A0Arago 2010.05 ttyS0=A0=A0=A0=A0Angstrom 2009.X-tes=
t-20100101 ttyS2

Is it possible to upgrade both the same x-loader and boot loader?

As I have seen already in this forum, it seems that I need to worry abo=
ut:
a) change the boot arg from "console=3DttyS2,115200" to =A0"console=3Dt=
ty02,115200"
b) change /etc/inittab line to S:2345:respawn:/sbin/getty 115200 tty02,=
 and similarly for other serial devices in there


As a strategy, should I keep the existing boot loaders and first upgrad=
e the kernels, then consider upgrading the boot loaders? Or should I tr=
y to first upgrade the boot loaders with existing kernels then try new =
kernels?

Thanks for the help.



-----Original Message-----
=46rom: Anand Gadiyar [mailto:gadiyar@ti.com]=20
Sent: Friday, February 04, 2011 11:33 AM
Subject: RE: general kernel building questions

> I have an Overo Fire board (OMAP 3530) and also a Mistral DM3730 EVM
> board.
>
> I would like to try some of the newer kernels on each, and maybe some
> patches mentioned in this list. I could be a tester for these once I
> figure out how to update bootloaders and build and install kernels. I=
s
> there a how-to guide somewhere?
Nothing comes to mind right now.

There is some useful reading material on elinux.org and omappedia.org.
I'll see if I can locate a good guide - if no one else points one out,
I'll try and put something together.

> So some newb questions if I may:
>
> 1. Where do I grab the latest kernels that have some chance at
> stability?
The mainline kernel will at least boot up on most OMAP boards.
The master branch of linux-omap closely tracks the mainline kernel
and is a little more likely to work.

> 2. Where are the def config files?

There are now only 2 defconfig files for the OMAPs.
omap1_defconfig for all OMAP1 platforms
and
omap2plus_defconfig for all OMAP2,3,4 platforms

They enable support for multiple boards, and contain
drivers that may not always be useful. So they are bigger
than absolutely necessary.

> 3. I know how to apply kernel patches, but where are the
> patches and how to I git specific ones?
Which patches are you interested in?

Anything that is queued up in a maintainer's tree can
be cherry picked by you.

Patches submitted to this list are also available
on patchwork.
https://patchwork.kernel.org/project/linux-omap/list/

> 4. Will 2.6.37, 2.6.38 mainline (currently rc3), linux-next and/or
> snapshot from kernel.org work?

I'm not very sure about the status of individual boards in the .37
kernel, but I expect that most of them will at least boot.
A recent snapshot from kernel.org should also be about the same.

2.6.38-rc3 will have more new features than the .37 kernel, and
I believe it is reasoably stable. Again, I expect it to at least
boot on most OMAP platforms. If it doesn't work for you,
please report it to this list and work with us to fix it.

Some features may not be present in the .38-rc releases.
Patches posted here and to other mailing lists which are not
bug-fixes will get queued up only for the merge window after
2.6.38 is released.

linux-next is the bleeding-edge kernel - it will start looking
like a preview of the next -rc1 kernel, but it could easily be broken
as there are frequent changes. These start stabilizing around -rc6
or so of the current kernel. Testing linux-next would certainly
be useful in ensuring the next merge window goes smoothly.

> 5. How quickly do the patches mentioned in this list land there?
That depends, mostly on the quality of the patches, and how
non-controversial they are. Fixes usually make it through
quickly, as long as the code quality is good.

Non-fixes can take a few weeks, depending on how good the
initial patch is, how responsive the submitter is to
comments, and how many people find the patch useful.

Non-fixes can also take months, if the right conditions
are not met. :(

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
