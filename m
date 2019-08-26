From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ARM: OMAP2+: Delete an unnecessary kfree() call in
 omap_hsmmc_pdata_init()
Date: Mon, 26 Aug 2019 15:30:57 +0200
Message-ID: <69025c8c-8d84-6686-138b-cde59467b802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Balaji T K <balajitk@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 26 Aug 2019 15:05:31 +0200

A null pointer would be passed to a call of the function "kfree" directly
after a call of the function "kzalloc" failed at one place.
Remove this superfluous function call.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/arm/mach-omap2/hsmmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 14b9c13c1fa0..63423ea6a240 100644
=2D-- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -32,10 +32,8 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hs=
mmc_info *c,
 	char *hc_name;

 	hc_name =3D kzalloc(HSMMC_NAME_LEN + 1, GFP_KERNEL);
-	if (!hc_name) {
-		kfree(hc_name);
+	if (!hc_name)
 		return -ENOMEM;
-	}

 	snprintf(hc_name, (HSMMC_NAME_LEN + 1), "mmc%islot%i", c->mmc, 1);
 	mmc->name =3D hc_name;
=2D-
2.23.0
