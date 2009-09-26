From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v3 0/3] OMAP: Adding flash support to SDP, ZOOM2 and LDP
	boards
Date: Fri, 25 Sep 2009 19:57:50 -0700
Message-ID: <ce9ab5790909251957t5598e4efq765f86420426392e@mail.gmail.com>
References: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:15903 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbZIZC6H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 22:58:07 -0400
Received: by an-out-0708.google.com with SMTP id d40so2437265and.1
        for <linux-omap@vger.kernel.org>; Fri, 25 Sep 2009 19:58:10 -0700 (PDT)
In-Reply-To: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimalsingh@ti.com>
Cc: linux-omap@vger.kernel.org

Tony,

Can you please upstream these patches, or there is still something to f=
ix?

--vimal

On Thu, Sep 10, 2009 at 4:31 AM, vimal singh <vimalsingh@ti.com> wrote:
> This patch series adds flash support for NAND (in sdp, zoom2 and ldp)=
,
> OneNAND and NOR (in sdp)
>
> Tested on Zoom2 by Vikram, On SDP by Vimal
>
> =A0OMAP: Zoom2: Enable NAND and JFFS2 in defconfig
> =A0OMAP2/3: Add support for flash on SDP boards
> =A0OMAP3: Add support for NAND on ZOOM2/LDP boards
>
> =A0arch/arm/omap_zoom2_defconfig | =A0241 +++++++++++++++++++++++++++=
++++++++++--------------
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04
> =A0arm/mach-omap2/board-2430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A02
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 | =A0 =A02
> =A0arch/arm/mach-omap2/board-sdp-flash.c =A0 | =A0327 +++++++++++++++=
+++++++++++++++++++++++++++
> =A0arch/arm/mach-omap2/board-sdp.h =A0 =A0 =A0 =A0 | =A0 15 +
> =A0arch/arm/plat-omap/include/mach/gpmc.h =A0| =A0 =A02
> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2
> =A0arch/arm/mach-omap2/board-zoom-flash.c =A0 =A0 =A0 | =A0196 ++++++=
++++++++++++++++++++++++++++++
> =A0arch/arm/mach-omap2/board-zoom2.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2
> =A0arch/arm/plat-omap/include/mach/board-zoom.h | =A0 36 ++++++
> =A0arch/arm/plat-omap/include/mach/nand.h =A0 =A0 =A0 | =A0 =A02
> =A012 files changed, 767 insertions(+), 64 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
> =A0create mode 100644 arch/arm/mach-omap2/board-sdp.h
> =A0create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
> =A0create mode 100644 arch/arm/plat-omap/include/mach/board-zoom.h
>
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
