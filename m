From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] twl4030_charger: fix warnings
Date: Fri,  3 Jun 2011 14:43:11 +0300
Message-ID: <1307101391-10898-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: linux-omap@vger.kernel.org

=46ix warnings emitted by some versions of gcc:
drivers/power/twl4030_charger.c:490: warning: overflow in implicit cons=
tant conversion
drivers/power/twl4030_charger.c:498: warning: overflow in implicit cons=
tant conversion

While at it, also fix module_param permissions and a typo in my name.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/power/twl4030_charger.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_ch=
arger.c
index 92c16e1..54b9198 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -62,7 +62,7 @@
 #define TWL4030_MSTATEC_COMPLETE4	0x0e
=20
 static bool allow_usb;
-module_param(allow_usb, bool, 1);
+module_param(allow_usb, bool, 0644);
 MODULE_PARM_DESC(allow_usb, "Allow USB charge drawing default current"=
);
=20
 struct twl4030_bci {
@@ -425,7 +425,7 @@ static int __init twl4030_bci_probe(struct platform=
_device *pdev)
 {
 	struct twl4030_bci *bci;
 	int ret;
-	int reg;
+	u32 reg;
=20
 	bci =3D kzalloc(sizeof(*bci), GFP_KERNEL);
 	if (bci =3D=3D NULL)
@@ -486,7 +486,7 @@ static int __init twl4030_bci_probe(struct platform=
_device *pdev)
 	}
=20
 	/* Enable interrupts now. */
-	reg =3D ~(TWL4030_ICHGLOW | TWL4030_ICHGEOC | TWL4030_TBATOR2 |
+	reg =3D ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC | TWL4030_TBATOR2 |
 		TWL4030_TBATOR1 | TWL4030_BATSTS);
 	ret =3D twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, reg,
 			       TWL4030_INTERRUPTS_BCIIMR1A);
@@ -495,7 +495,7 @@ static int __init twl4030_bci_probe(struct platform=
_device *pdev)
 		goto fail_unmask_interrupts;
 	}
=20
-	reg =3D ~(TWL4030_VBATOV | TWL4030_VBUSOV | TWL4030_ACCHGOV);
+	reg =3D ~(u32)(TWL4030_VBATOV | TWL4030_VBUSOV | TWL4030_ACCHGOV);
 	ret =3D twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, reg,
 			       TWL4030_INTERRUPTS_BCIIMR2A);
 	if (ret < 0)
@@ -572,7 +572,7 @@ static void __exit twl4030_bci_exit(void)
 }
 module_exit(twl4030_bci_exit);
=20
-MODULE_AUTHOR("Gra=C5=BEydas Ignotas");
+MODULE_AUTHOR("Gra=C5=BEvydas Ignotas");
 MODULE_DESCRIPTION("TWL4030 Battery Charger Interface driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:twl4030_bci");
--=20
1.7.0.4
