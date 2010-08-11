From: Gregory CLEMENT <gclement00@gmail.com>
Subject: [PATCH 2/2] spi/omap2_mcspi: When SPI wake up from OFF mode, CS is in
	wrong state: force it to unactive state
Date: Wed, 11 Aug 2010 16:44:02 +0200
Message-ID: <AANLkTi=y_phvzqeg0wy+FMVsm-0O9gv1gobCe0qzSXEE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016368e2bdadbf195048d8d4709
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50348 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab0HKOoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 10:44:03 -0400
Received: by mail-fx0-f46.google.com with SMTP id 13so147283fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 07:44:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general <spi-devel-general@lists.sourceforge.net>
Cc: linux-omap <linux-omap@vger.kernel.org>, Gregory CLEMENT <gclement00@gmail.com>

--0016368e2bdadbf195048d8d4709
Content-Type: text/plain; charset=ISO-8859-1

When SPI wake up from OFF mode, CS is in wrong state: force it to unactive state

Signed-off-by: Gregory CLEMENT <gclement00@gmail.com>
---
 drivers/spi/omap2_mcspi.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index b3a94ca..3083bd0 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -1137,7 +1137,15 @@ static u8 __initdata spi4_txdma_id[] = {
 	OMAP34XX_DMA_SPI4_TX0,
 };
 #endif
-
+/* When SPI wake up, CS is in wrong state: force it to unactive state*/
+static void omap2_mcspi_resume(struct spi_device *spi)
+{
+	omap2_mcspi_enable_clocks( spi_master_get_devdata(spi->master));
+/* We need to togle CS state for OMAP take this chang in account*/
+	omap2_mcspi_force_cs(spi, 1);
+	omap2_mcspi_force_cs(spi, 0);
+	omap2_mcspi_disable_clocks( spi_master_get_devdata(spi->master));
+}
 static int __init omap2_mcspi_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
@@ -1193,6 +1201,7 @@ static int __init omap2_mcspi_probe(struct
platform_device *pdev)
 	master->transfer = omap2_mcspi_transfer;
 	master->cleanup = omap2_mcspi_cleanup;
 	master->num_chipselect = num_chipselect;
+	master->resume = omap2_mcspi_resume;

 	dev_set_drvdata(&pdev->dev, master);

--0016368e2bdadbf195048d8d4709
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-spi-omap2_mcspi-When-SPI-wake-up-from-OFF-mode-CS-is.patch"
Content-Disposition: attachment;
	filename="0002-spi-omap2_mcspi-When-SPI-wake-up-from-OFF-mode-CS-is.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7da9a884b5f67f18_0.1

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL29tYXAyX21jc3BpLmMgYi9kcml2ZXJzL3NwaS9vbWFw
Ml9tY3NwaS5jDQppbmRleCBiM2E5NGNhLi4zMDgzYmQwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9z
cGkvb21hcDJfbWNzcGkuYw0KKysrIGIvZHJpdmVycy9zcGkvb21hcDJfbWNzcGkuYw0KQEAgLTEx
MzcsNyArMTEzNywxNSBAQCBzdGF0aWMgdTggX19pbml0ZGF0YSBzcGk0X3R4ZG1hX2lkW10gPSB7
DQogCU9NQVAzNFhYX0RNQV9TUEk0X1RYMCwNCiB9Ow0KICNlbmRpZg0KLQ0KKy8qIFdoZW4gU1BJ
IHdha2UgdXAsIENTIGlzIGluIHdyb25nIHN0YXRlOiBmb3JjZSBpdCB0byB1bmFjdGl2ZSBzdGF0
ZSovDQorc3RhdGljIHZvaWQgb21hcDJfbWNzcGlfcmVzdW1lKHN0cnVjdCBzcGlfZGV2aWNlICpz
cGkpDQorew0KKwlvbWFwMl9tY3NwaV9lbmFibGVfY2xvY2tzKCBzcGlfbWFzdGVyX2dldF9kZXZk
YXRhKHNwaS0+bWFzdGVyKSk7DQorLyogV2UgbmVlZCB0byB0b2dsZSBDUyBzdGF0ZSBmb3IgT01B
UCB0YWtlIHRoaXMgY2hhbmcgaW4gYWNjb3VudCovDQorCW9tYXAyX21jc3BpX2ZvcmNlX2NzKHNw
aSwgMSk7DQorCW9tYXAyX21jc3BpX2ZvcmNlX2NzKHNwaSwgMCk7DQorCW9tYXAyX21jc3BpX2Rp
c2FibGVfY2xvY2tzKCBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKHNwaS0+bWFzdGVyKSk7DQorfQ0K
IHN0YXRpYyBpbnQgX19pbml0IG9tYXAyX21jc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogew0KIAlzdHJ1Y3Qgc3BpX21hc3RlcgkqbWFzdGVyOw0KQEAgLTExOTMsNiAr
MTIwMSw3IEBAIHN0YXRpYyBpbnQgX19pbml0IG9tYXAyX21jc3BpX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQogCW1hc3Rlci0+dHJhbnNmZXIgPSBvbWFwMl9tY3NwaV90cmFu
c2ZlcjsNCiAJbWFzdGVyLT5jbGVhbnVwID0gb21hcDJfbWNzcGlfY2xlYW51cDsNCiAJbWFzdGVy
LT5udW1fY2hpcHNlbGVjdCA9IG51bV9jaGlwc2VsZWN0Ow0KKwltYXN0ZXItPnJlc3VtZSA9IG9t
YXAyX21jc3BpX3Jlc3VtZTsNCiANCiAJZGV2X3NldF9kcnZkYXRhKCZwZGV2LT5kZXYsIG1hc3Rl
cik7DQogDQo=
--0016368e2bdadbf195048d8d4709--
