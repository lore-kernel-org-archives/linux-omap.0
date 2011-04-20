From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Subject: Re: [PATCH v3] ARM: omap2: mtd split nand_scan in ident and tail
Date: Wed, 20 Apr 2011 12:00:11 +0300
Message-ID: <1303290011.2700.12.camel@localhost>
References: <BANLkTimxgyStkfYXyHJUzQBKTR0pYsF7Qw@mail.gmail.com>
	 <1303222534-10143-1-git-send-email-j.weitzel@phytec.de>
Reply-To: Artem.Bityutskiy@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:21221 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab1DTJD3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 05:03:29 -0400
In-Reply-To: <1303222534-10143-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, dwmw2@infradead.org, tony@atomide.com, s-ghorai@ti.com, vimal.newwork@gmail.com

On Tue, 2011-04-19 at 16:15 +0200, Jan Weitzel wrote:
> nand_scan calls nand_scan_tail and here we got a ecc.layout and calcu=
late
> oobavail for this layout. After calling nand_scan, we change the layo=
ut pointer
> if OMAP_ECC_HAMMING_CODE_HW_ROMCODE is set. This results in not calcl=
uated
> oobavail. Mountig as jffs2 is not possible.
>=20
> To fix that nand_scan has to split up in nand_scan_ident and nand_sca=
n_tail
> setting ecc.layout between these calls. So nand_scan_tail calculates =
oobvail
> for the used layout. This is also done in serveral other platforms.
>=20
> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> Reviewed-by: Vimal Singh <vimal.newwork@gmail.com>

Jan,

thanks for the patch, pushed to l2-mtd-2.6.git. And apologies that I
missed.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
