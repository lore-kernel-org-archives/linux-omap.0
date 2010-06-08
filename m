From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v5 0/3] omap3 nand: cleanup exiting platform related code
Date: Tue, 8 Jun 2010 22:42:51 +0530
Message-ID: <AANLkTinf8OcvHbLggdEJNGLvlAtSeExKri-IqNlwLpYD@mail.gmail.com>
References: <s-ghorai@ti.com> <1275637205-489-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61377 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0FHRNM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 13:13:12 -0400
Received: by pwj5 with SMTP id 5so1454188pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Jun 2010 10:13:11 -0700 (PDT)
In-Reply-To: <1275637205-489-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, tony@atomide.com, mike@compulab.co.il

Reviewed-by: Vimal Singh <vimal.newwork@gmail.com>

On Fri, Jun 4, 2010 at 1:10 PM, Sukumar Ghorai <s-ghorai@ti.com> wrote:
> =A0 The following set of patches applies on top of for-next branch.
> =A0 =A0 =A0 =A0http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/lin=
ux-omap-2.6.git
> =A0 Patches verified on: omap3430-SDP, omap3630-sdp, zoom3 and beagle=
 board
>
> =A0 And these are the patches required to address the following input=
 -
> =A0 =A0 1. The NAND driver needs to stop tinkering with the GPMC regi=
sters
> =A0 =A0 =A0 =A0The omap General Purpose Memory Controller (GPMC) regi=
sters are omap
> =A0 =A0 =A0 =A0specific, and not driver specific. Tinkering with thes=
e registers can
> =A0 =A0 =A0 =A0cause issues with the other devices on the GPMC.
>
> =A0 =A0 2. Passing hardcoded GPMC_CS0_BASE needs to go from the board=
 files
> =A0 =A0 =A0 =A0Passing hardcoded GPMC virtual addressess is sure way =
to mess up things.
> =A0 =A0 =A0 =A0This should all become unnecessary once the NAND drive=
rs stops messing
> =A0 =A0 =A0 =A0with the GPMC registers directly.
> =A0 =A0 Discussion: http://www.mail-archive.com/linux-omap@vger.kerne=
l.org/msg27630.html
>
> =A0 Changes in this series -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Unused function removed.
>
> =A0Functions related to ecc and prefetch engine are optimized.
> =A0v4: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg2945=
8.html
>
> =A0Few functionality was missing =A0like - There should be some locki=
ng as only
> =A0 one chipselect can use the ECC or prefetch engine at a time. If y=
ou have
> =A0 NAND in two chipselects, bad things would happen.
> =A0v3: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg2871=
5.html
>
> =A0Additionally, it was needed to implement more functions for the pl=
atform
> =A0init code to use.
> =A0v2: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg2846=
7.html
>
> =A0v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg2816=
4.html
>
>
> Sukumar Ghorai (3):
> =A0 =A0 =A0 =A0omap3 gpmc: functionality enhancement
> =A0 =A0 =A0 =A0omap3 nand: cleanup virtual address usages
> =A0 =A0 =A0 =A0omap3 nand: fix issue in board file to detect nand
> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 | =A0 20 +---
> =A0arch/arm/mach-omap2/board-devkit8000.c =A0 =A0 | =A0 25 +---
> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0| =A0 24 +---
> =A0arch/arm/mach-omap2/board-omap3touchbook.c | =A0 25 +---
> =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 =A0 =A0| =A0 24 +---
> =A0arch/arm/mach-omap2/board-sdp-flash.c =A0 =A0 =A0| =A0 =A05 -
> =A0arch/arm/mach-omap2/gpmc-nand.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 39 ++=
----
> =A0arch/arm/mach-omap2/gpmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A022=
8 +++++++++++++++++++++++++---
> =A0arch/arm/plat-omap/include/plat/gpmc.h =A0 =A0 | =A0 36 ++++-
> =A0arch/arm/plat-omap/include/plat/nand.h =A0 =A0 | =A0 =A06 +-
> =A0drivers/mtd/nand/omap2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
229 ++++++++--------------------
> =A011 files changed, 320 insertions(+), 341 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
