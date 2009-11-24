From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH-v6 0/4] OMAP: Adding flash support to SDP, ZOOM2 and
 LDP boards
Date: Tue, 24 Nov 2009 17:06:13 +0200
Message-ID: <1259075173.29118.20.camel@localhost>
References: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com>
	 <ce9ab5790909251957t5598e4efq765f86420426392e@mail.gmail.com>
	 <ce9ab5790910260507y2d0067dk1c12f0439c6fe5d7@mail.gmail.com>
	 <ce9ab5790911040328p215dede2v37db38a966a5bbd5@mail.gmail.com>
	 <20091109205250.GB23952@atomide.com>
	 <ce9ab5790911100201j6b1ef5e1g43a992b00e69ade4@mail.gmail.com>
	 <ce9ab5790911190608r5b7e8226j3546714957ce70e6@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62882 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbZKXPGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 10:06:21 -0500
In-Reply-To: <ce9ab5790911190608r5b7e8226j3546714957ce70e6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, vimal singh <vimalsingh@ti.com>

On Thu, 2009-11-19 at 19:38 +0530, Vimal Singh wrote:
> Here is the v6 of this patch series. I am cc'ing mtd list too this ti=
me.
>=20
>=20
> From 8bc97108cf9c78216f1ea5407ccbd900e6b63dc2 Mon Sep 17 00:00:00 200=
1
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Thu, 19 Nov 2009 19:28:11 +0530
>=20
> This patch series adds flash support for NAND (in sdp, zoom and ldp),
> OneNAND and NOR (in sdp)
>=20
> Tested on Zoom2 and 3430SDP
>=20
> Vimal Singh (4):
> [PATCH-v6 1/4] OMAP2/3: Add support for flash on SDP boards
> [PATCH-v6 2/4] OMAP3: Add support for NAND on ZOOM/LDP boards
> [PATCH-v6 3/4] OMAP: Zoom2: Enable NAND and JFFS2 support in defconfi=
g
> [PATCH-v6 4/4] OMAP: 3430SDP: Enable NAND in defconfig

Is it possible to separate the MTD and OMAP parts?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
