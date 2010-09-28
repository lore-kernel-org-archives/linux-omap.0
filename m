From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: Issue : jffs2 and ecc layout
Date: Tue, 28 Sep 2010 18:16:31 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03560990E3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52620 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712Ab0I1Mqk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 08:46:40 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
I was using the following ecc layout which is not working to mount the =
jffs2 File-system. I was in 2.6.32 kernel and working; but same layout =
is not working with latest 2.6 kernel.

Observation is that - no read request issued to the driver (say omap2.c=
).

# mount -t jffs2 /dev/mtdblock4 /mnt/nand
[=A0=A0 32.505218] cannot read OOB for EB at 00000000, requested 8 byte=
s, read 0 bytes, error -22
mount: Mounting /dev/mtdblock4 on /mnt/nand failed: Input/output error

# dmesg=20
<3>[=A0=A0 32.505218] cannot read OOB for EB at 00000000, requested 8 b=
ytes, read 0 bytes, error -22

Code:
=A0178 static struct nand_ecclayout hw_x16_romcode_oob_64 =3D {
=A0179=A0=A0=A0=A0=A0=A0=A0=A0 .eccbytes =3D 12,
=A0180=A0=A0=A0=A0=A0=A0=A0=A0 .eccpos =3D {
=A0181=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2, 3=
, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
=A0182=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
=A0183=A0=A0=A0=A0=A0=A0=A0=A0 .oobfree =3D {
=A0184=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=
=A0=A0{.offset =3D 14,
=A0185=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 .length =3D 50}
=A0186=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0187 };

=A01188=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->nand.ecc.layout =3D=
 &hw_x16_romcode_oob_64;

Regards,
Ghorai

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
