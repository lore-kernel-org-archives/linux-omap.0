From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 0/3] nand support on zoom boards
Date: Thu, 11 Feb 2010 10:47:28 +0530
Message-ID: <ce9ab5791002102117u551c783dndcbbc5bdc67aa282@mail.gmail.com>
References: <ce9ab5791001122301xb852c95i116a50bf7e71d1cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62838 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab0BKFRt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 00:17:49 -0500
Received: by bwz19 with SMTP id 19so20366bwz.28
        for <linux-omap@vger.kernel.org>; Wed, 10 Feb 2010 21:17:48 -0800 (PST)
In-Reply-To: <ce9ab5791001122301xb852c95i116a50bf7e71d1cc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Re-posting this patch series once again after re-basing on latest LO ma=
ster.

-
vimal

On Wed, Jan 13, 2010 at 12:31 PM, Vimal Singh <vimal.newwork@gmail.com>=
 wrote:
> From 345704a79f15b0481b14d5d504b0bcdf55f2a9a6 Mon Sep 17 00:00:00 200=
1
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Tue, 12 Jan 2010 18:12:53 +0530
> Subject: [PATCH] nand support on zoom boards
>
> I have verified it on zoom2/3 support on zoom boards.
> I still have not tried it on LDP (zoom1) board. So, I'll post patch
> for same later.
>
>
> Vimal Singh (3):
> =A0OMAP: ZOOM: Introducing 'board-zoom-flash.c'
> =A0OMAP3: Add support for NAND on ZOOM2 board
> =A0OMAP3: Add support for NAND on ZOOM3 board
>
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +
> =A0arch/arm/mach-omap2/board-zoom-flash.c =A0 =A0 =A0 =A0| =A0 85 +++=
++++++++++++++++++++++
> =A0arch/arm/mach-omap2/board-zoom2.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 49=
 ++++++++++++++
> =A0arch/arm/mach-omap2/board-zoom3.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 49=
 ++++++++++++++
> =A0arch/arm/mach-omap2/include/mach/board-zoom.h | =A0 11 +++
> =A05 files changed, 196 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
