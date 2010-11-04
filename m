From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board
 file
Date: Thu, 4 Nov 2010 06:32:17 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0356BABFAE@dbde02.ent.ti.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
	<1285596710-25658-5-git-send-email-s-ghorai@ti.com>
 <AANLkTikKMnzHR5DZqzGdJJbnCXhCpxKA7K2C2ZtPhNke@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60831 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753948Ab0KDBCe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Nov 2010 21:02:34 -0400
In-Reply-To: <AANLkTikKMnzHR5DZqzGdJJbnCXhCpxKA7K2C2ZtPhNke@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Vimal Singh <vimalsingh@ti.com>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>



> -----Original Message-----
> From: Grazvydas Ignotas [mailto:notasas@gmail.com]
> Sent: Wednesday, November 03, 2010 6:33 PM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-=
arm-
> kernel@lists.infradead.org; Vimal Singh; Artem.Bityutskiy@nokia.com
> Subject: Re: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from
> board file
>=20
> On Mon, Sep 27, 2010 at 5:11 PM, Sukumar Ghorai <s-ghorai@ti.com> wro=
te:
> > This patch makes it possible to select sw or hw (different layout
> options)
> > ecc scheme supported by omap nand driver. =A0And hw ecc layout sele=
cted
> for
> > sdp and zoom boards, by default.
> >
> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
>=20
> Any news on this? Commit 2c01946c accidentally (?) enabled hardware
> ECC and now my board is broken, as the driver always used sw ecc and
> my NAND partitions are formatted accordingly. We should at least
> switch the default back to sw ecc, don't you think?
[Ghorai]=20
1. which board you are working.=20
2. and the default layout is the same as previous=20
+       board_nand_data.ecc_opt         =3D OMAP_ECC_HAMMING_CODE_DIFF_=
LAYOUT;
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
