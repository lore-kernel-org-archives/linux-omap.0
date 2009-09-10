From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v2 0/3] OMAP: Adding flash support to SDP, ZOOM2 and LDP
	boards
Date: Thu, 10 Sep 2009 16:08:21 +0530
Message-ID: <ce9ab5790909100338t2c2324b4ja3ed176140772949@mail.gmail.com>
References: <1252005950-17610-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f203.google.com ([209.85.211.203]:54009 "EHLO
	mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbZIJKo2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Sep 2009 06:44:28 -0400
Received: by ywh41 with SMTP id 41so14575ywh.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2009 03:44:31 -0700 (PDT)
In-Reply-To: <1252005950-17610-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Vikram,

I am going to post version-3 for these patches due to below updates/fix=
es:

PATCH 2/3: Add support for NAND on ZOOM2/LDP boards
1. prototype mismatch for 'unlock' funtion pointer in 'mach/nand.h and
in 'mtd_struct'
2. typo error (Singned -> Signed) indicated by Kishore.

PATCH 3/3: Zoom2: Enable NAND in defconfig
1. Disabling 'CONFIG_MTD_NAND_VERIFY_WRITE' and
'CONFIG_MTD_NAND_ECC_SMC' in from previous patch
2. Enabling CONFIG_JFFS2_FS in addition, to support NAND devices.

Patch 1/3:  Add support for flash on SDP boards
will remain unchanged.

--=20
Regards,
Vimal Singh


On Fri, Sep 4, 2009 at 12:55 AM, Vikram Pandita <vikram.pandita@ti.com>=
 wrote:
> This patch series adds flash support for NAND (in sdp, zoom2 and ldp)=
,
> OneNAND and NOR (in sdp)
>
> Tested on Zoom2 by Vikram, On SDP by Vimal
>
> Vikram Pandita (1):
> =A0OMAP: Zoom2: Enable NAND in defconfig
>
> Vimal Singh (2):
> =A0OMAP2/3: Add support for flash on SDP boards
> =A0OMAP3: Add support for NAND on ZOOM2/LDP boards
>
> =A0arch/arm/configs/omap_zoom2_defconfig =A0 =A0 =A0 =A0| =A0224 ++++=
+++++++++-----
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A04 +
> =A0arch/arm/mach-omap2/board-2430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 =
+
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 =
+
> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +
> =A0arch/arm/mach-omap2/board-sdp-flash.c =A0 =A0 =A0 =A0| =A0326 ++++=
++++++++++++++++++++++
> =A0arch/arm/mach-omap2/board-sdp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 1=
5 ++
> =A0arch/arm/mach-omap2/board-zoom-flash.c =A0 =A0 =A0 | =A0196 ++++++=
++++++++++
> =A0arch/arm/mach-omap2/board-zoom2.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +
> =A0arch/arm/plat-omap/include/mach/board-zoom.h | =A0 36 +++
> =A0arch/arm/plat-omap/include/mach/gpmc.h =A0 =A0 =A0 | =A0 =A02 +
> =A0arch/arm/plat-omap/include/mach/nand.h =A0 =A0 =A0 | =A0 =A01 +
> =A012 files changed, 748 insertions(+), 64 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
> =A0create mode 100644 arch/arm/mach-omap2/board-sdp.h
> =A0create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
> =A0create mode 100644 arch/arm/plat-omap/include/mach/board-zoom.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
