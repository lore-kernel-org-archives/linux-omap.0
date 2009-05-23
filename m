From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Patch: Fix N770 MMC support
Date: Sat, 23 May 2009 17:49:39 +0100
Message-ID: <20090523174939.45129s043kunkc2o@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_qgw897tu0ww"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:50425 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbZEWQti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 May 2009 12:49:38 -0400
Received: from lidskialf.net (beyond.lidskialf.net [172.16.1.1])
	by mail.lidskialf.net (Postfix) with ESMTP id 398E948A6119C
	for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 17:49:39 +0100 (BST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This message is in MIME format.

--=_qgw897tu0ww
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Some of the N770's MMC configuration options seem to have been  
dropped. This patch adds them back in again.

Note that only the .ocr_mask change was /critical/, but I've added the  
.max_freq setting back as well, as the original sources had it. Can  
anyone confirm if this is unnecessary?

Secondly, there is support in the original code for a 4wire/higher  
speed mode. As I don't have the requisite N770 hardware (I think it  
was a rev2 N770?) to test this, I can't really add it back.


--=_qgw897tu0ww
Content-Type: text/x-patch;
	charset=UTF-8;
	name="fix-n770-mmc.patch"
Content-Disposition: attachment;
	filename="fix-n770-mmc.patch"
Content-Transfer-Encoding: quoted-printable

commit b67345993d494a1dd5021e29de9611af80cbf1cd
Author: Andrew de Quincey <adq@lidskialf.net>
Date:   Sat May 23 17:43:19 2009 +0100

    Fix n770 MMC support
   =20
    Some of the necessary configuration settings for the N770's MMC support =
had been
    dropped. Add them back in again.
   =20
    Signed-off-by: Andrew de Quincey <adq@lidskialf.net>

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/boar=
d-nokia770.c
index 2c4785e..bfed959 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -209,9 +209,11 @@ static int nokia770_mmc_get_cover_state(struct device *=
dev, int slot)
 static struct omap_mmc_platform_data nokia770_mmc2_data =3D {
 =09.nr_slots                       =3D 1,
 =09.dma_mask=09=09=09=3D 0xffffffff,
+=09.max_freq                       =3D 12000000,
 =09.slots[0]       =3D {
 =09=09.set_power=09=09=3D nokia770_mmc_set_power,
 =09=09.get_cover_state=09=3D nokia770_mmc_get_cover_state,
+=09=09.ocr_mask               =3D MMC_VDD_32_33|MMC_VDD_33_34,
 =09=09.name                   =3D "mmcblk",
 =09},
 };
--=_qgw897tu0ww--

