From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [RFC] mtd: nand: Fix bad block identification issue
Date: Thu, 28 Apr 2011 20:30:43 +0300
Message-ID: <1304011843.2737.3.camel@localhost>
References: <1303906161-24175-1-git-send-email-parth.saxena@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40031 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525Ab1D1RfB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 13:35:01 -0400
Received: by ewy4 with SMTP id 4so897502ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Apr 2011 10:34:59 -0700 (PDT)
In-Reply-To: <1303906161-24175-1-git-send-email-parth.saxena@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Saxena, Parth" <parth.saxena@ti.com>, Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>, linux-omap@vger.kernel.org

On Wed, 2011-04-27 at 17:39 +0530, Saxena, Parth wrote:
> This patch solves the above issue for omap by initialising
> badblockbits. We are working further on this to find a generic fix
> to the problem in nand_base.c.

But it looks like the generic solution is to return the line which was
accidentally removed, how about this patch

=46rom: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Date: Thu, 28 Apr 2011 20:26:59 +0300
Subject: [PATCH] mtd: return badblockbits back

In commit c7b28e25cb9beb943aead770ff14551b55fa8c79 the initialization o=
f
the backblockbits was accidentally removed. This patch returns it back,
because otherwise some NAND drivers are broken.

This problem was reported by "Saxena, Parth <parth.saxena@ti.com>" here=
:
http://lists.infradead.org/pipermail/linux-mtd/2011-April/035221.html

Reported-by: Saxena, Parth <parth.saxena@ti.com>
Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Cc: stable@kernel.org [2.6.36+]
---
 drivers/mtd/nand/nand_base.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.=
c
index 15510f2..5a7f817 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -3106,6 +3106,8 @@ ident_done:
 		chip->chip_shift +=3D 32 - 1;
 	}
=20
+	chip->badblockbits =3D 8;
+
 	/* Set the bad block position */
 	if (mtd->writesize > 512 || (busw & NAND_BUSWIDTH_16))
 		chip->badblockpos =3D NAND_LARGE_BADBLOCK_POS;
--=20
1.7.2.3

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
