From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v4 0/4] OMAP: Adding flash support to SDP, ZOOM2 and LDP
	boards
Date: Wed, 4 Nov 2009 16:58:20 +0530
Message-ID: <ce9ab5790911040328p215dede2v37db38a966a5bbd5@mail.gmail.com>
References: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com>
	<ce9ab5790909251957t5598e4efq765f86420426392e@mail.gmail.com>
	<ce9ab5790910260507y2d0067dk1c12f0439c6fe5d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:32820 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224AbZKDL2i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 06:28:38 -0500
Received: by fg-out-1718.google.com with SMTP id d23so1794422fga.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2009 03:28:40 -0800 (PST)
In-Reply-To: <ce9ab5790910260507y2d0067dk1c12f0439c6fe5d7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, vimal singh <vimalsingh@ti.com>

Hi Tony,

I did not see any comment on these patches. Could you please upstream t=
hese?
Or, do you have some other plan?

-
vimal

On Mon, Oct 26, 2009 at 5:37 PM, Vimal Singh <vimal.newwork@gmail.com> =
wrote:
> I posted a patch series for this sometime back and did not get any re=
spose.. :(
> http://marc.info/?l=3Dlinux-omap&m=3D125258227301958&w=3D2
>
> This time again I am posting these patches, with one more patch added
> in series, after re-basing the patches on top of LO master head.
>
> This patch series adds flash support for NAND (in sdp, zoom2 and ldp)=
,
> OneNAND and NOR (in sdp)
>
> Tested on Zoom2 by Vikram, On SDP by Vimal
>
> [PATCH-v4 1/4] OMAP2/3: Add support for flash on SDP boards
> [PATCH-v4 2/4] OMAP3: Add support for NAND on ZOOM2/LDP boards
> [PATCH-v4 3/4] OMAP: Zoom2: Enable NAND and JFFS2 support in defconfi=
g
> [PATCH 4/4] OMAP: 3430SDP: Enable NAND in defconfig
>
> =A0arch/arm/configs/omap_3430sdp_defconfig =A0 =A0 =A0| =A0574 ++++++=
+++++--------------
> =A0arch/arm/configs/omap_zoom2_defconfig =A0 =A0 =A0 =A0| =A0334 ++++=
++++++----
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02
> =A0arch/arm/mach-omap2/board-2430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A02
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A02
> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2
> =A0arch/arm/mach-omap2/board-sdp-flash.c =A0 =A0 =A0 =A0| =A0327 ++++=
++++++++++
> =A0arch/arm/mach-omap2/board-zoom-flash.c =A0 =A0 =A0 | =A0196 ++++++=
++
> =A0arch/arm/mach-omap2/board-zoom2.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2
> =A0arch/arm/plat-omap/include/plat/board-sdp.h =A0| =A0 15
> =A0arch/arm/plat-omap/include/plat/board-zoom.h | =A0 36 +
> =A0arch/arm/plat-omap/include/plat/gpmc.h =A0 =A0 =A0 | =A0 =A02
> =A0arch/arm/plat-omap/include/plat/nand.h =A0 =A0 =A0 | =A0 =A02
> =A014 files changed, 1095 insertions(+), 403 deletions(-)
>
> --
> Regards,
> Vimal Singh
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
