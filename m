From: "Hemanth V" <hemanthv@ti.com>
Subject: [RESEND][PATCH V2 3/3] Add support for Slave mode
Date: Thu, 18 Feb 2010 16:18:54 +0530 (IST)
Message-ID: <50566.10.24.255.18.1266490134.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20100218161854_93180"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38610 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0BRKtD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 05:49:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net

------=_20100218161854_93180
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Pl also find the patch attached, incase corrupted by mailer

Thanks
Hemanth

>From ae4c6a91bbcfc842f97cf48dd13f6de02baae1d3 Mon Sep 17 00:00:00 2001
From: Hemanth V <hemanthv@ti.com>
Date: Fri, 27 Nov 2009 14:37:20 +0530
Subject: [PATCH 3/3] Add McSPI slave support.

This patch adds support for mcspi slave mode.

Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 drivers/spi/omap2_mcspi.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 75a3f04..03d61cf 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -428,6 +428,18 @@ static void omap2_mcspi_set_master_mode(struct spi_master
*master)
 	omap2_mcspi_ctx[master->bus_num - 1].modulctrl = l;
 }

+static void omap2_mcspi_set_slave_mode(struct spi_master *master)
+{
+	u32 l;
+
+	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
+	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_STEST, 0);
+	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_MS, 1);
+	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
+
+	omap2_mcspi_ctx[master->bus_num - 1].modulctrl = l;
+}
+
 static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
 {
 	unsigned long timeout;
@@ -827,10 +839,11 @@ static int omap2_mcspi_setup_transfer(struct spi_device
*spi,
 		l &= ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1);
 		l |= OMAP2_MCSPI_CHCONF_DPE0;
 	} else {
-		return -EINVAL;
+		l |= OMAP2_MCSPI_CHCONF_IS;
+		l |= OMAP2_MCSPI_CHCONF_DPE1;
+		l &= ~OMAP2_MCSPI_CHCONF_DPE0;
 	}

-
 	/* wordlength */
 	l &= ~OMAP2_MCSPI_CHCONF_WL_MASK;
 	l |= (word_len - 1) << 7;
@@ -1214,7 +1227,6 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi
*mcspi)
 {
 	struct spi_master	*master = mcspi->master;
 	u32			tmp;
-	u32			error = 0;

 	if (omap2_mcspi_enable_clocks(mcspi))
 		return -1;
@@ -1238,10 +1250,10 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi
*mcspi)
 	if (mcspi->mcspi_mode == OMAP2_MCSPI_MASTER)
 		omap2_mcspi_set_master_mode(master);
 	else
-		error = -EINVAL;
+		omap2_mcspi_set_slave_mode(master);

 	omap2_mcspi_disable_clocks(mcspi);
-	return error;
+	return 0;
 }

 static u8 __initdata spi1_rxdma_id [] = {
@@ -1353,7 +1365,7 @@ static int __init omap2_mcspi_probe(struct
platform_device *pdev)

 	mcspi = spi_master_get_devdata(master);
 	mcspi->master = master;
-	mcspi->mcspi_mode = OMAP2_MCSPI_MASTER;
+	mcspi->mcspi_mode = pdata->mode;
 	mcspi->dma_mode = pdata->dma_mode;
 	mcspi->force_cs_mode = pdata->force_cs_mode;

-- 
1.6.3.3

------=_20100218161854_93180
Content-Type: application/octet-stream;
      name="0003-Add-McSPI-slave-support.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename="0003-Add-McSPI-slave-support.patch"

RnJvbSBhZTRjNmE5MWJiY2ZjODQyZjk3Y2Y0OGRkMTNmNmRlMDJiYWFlMWQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIZW1hbnRoIFYgPGhlbWFudGh2QHRpLmNvbT4KRGF0ZTogRnJp
LCAyNyBOb3YgMjAwOSAxNDozNzoyMCArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMy8zXSBBZGQgTWNT
UEkgc2xhdmUgc3VwcG9ydC4KClRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBtY3NwaSBzbGF2
ZSBtb2RlLgoKU2lnbmVkLW9mZi1ieTogSGVtYW50aCBWIDxoZW1hbnRodkB0aS5jb20+Ci0tLQog
ZHJpdmVycy9zcGkvb21hcDJfbWNzcGkuYyB8ICAgMjQgKysrKysrKysrKysrKysrKysrLS0tLS0t
CiAxIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zcGkvb21hcDJfbWNzcGkuYyBiL2RyaXZlcnMvc3BpL29tYXAyX21j
c3BpLmMKaW5kZXggNzVhM2YwNC4uMDNkNjFjZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9zcGkvb21h
cDJfbWNzcGkuYworKysgYi9kcml2ZXJzL3NwaS9vbWFwMl9tY3NwaS5jCkBAIC00MjgsNiArNDI4
LDE4IEBAIHN0YXRpYyB2b2lkIG9tYXAyX21jc3BpX3NldF9tYXN0ZXJfbW9kZShzdHJ1Y3Qgc3Bp
X21hc3RlciAqbWFzdGVyKQogCW9tYXAyX21jc3BpX2N0eFttYXN0ZXItPmJ1c19udW0gLSAxXS5t
b2R1bGN0cmwgPSBsOwogfQogCitzdGF0aWMgdm9pZCBvbWFwMl9tY3NwaV9zZXRfc2xhdmVfbW9k
ZShzdHJ1Y3Qgc3BpX21hc3RlciAqbWFzdGVyKQoreworCXUzMiBsOworCisJbCA9IG1jc3BpX3Jl
YWRfcmVnKG1hc3RlciwgT01BUDJfTUNTUElfTU9EVUxDVFJMKTsKKwlNT0RfUkVHX0JJVChsLCBP
TUFQMl9NQ1NQSV9NT0RVTENUUkxfU1RFU1QsIDApOworCU1PRF9SRUdfQklUKGwsIE9NQVAyX01D
U1BJX01PRFVMQ1RSTF9NUywgMSk7CisJbWNzcGlfd3JpdGVfcmVnKG1hc3RlciwgT01BUDJfTUNT
UElfTU9EVUxDVFJMLCBsKTsKKworCW9tYXAyX21jc3BpX2N0eFttYXN0ZXItPmJ1c19udW0gLSAx
XS5tb2R1bGN0cmwgPSBsOworfQorCiBzdGF0aWMgaW50IG1jc3BpX3dhaXRfZm9yX3JlZ19iaXQo
dm9pZCBfX2lvbWVtICpyZWcsIHVuc2lnbmVkIGxvbmcgYml0KQogewogCXVuc2lnbmVkIGxvbmcg
dGltZW91dDsKQEAgLTgyNywxMCArODM5LDExIEBAIHN0YXRpYyBpbnQgb21hcDJfbWNzcGlfc2V0
dXBfdHJhbnNmZXIoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwKIAkJbCAmPSB+KE9NQVAyX01DU1BJ
X0NIQ09ORl9JU3xPTUFQMl9NQ1NQSV9DSENPTkZfRFBFMSk7CiAJCWwgfD0gT01BUDJfTUNTUElf
Q0hDT05GX0RQRTA7CiAJfSBlbHNlIHsKLQkJcmV0dXJuIC1FSU5WQUw7CisJCWwgfD0gT01BUDJf
TUNTUElfQ0hDT05GX0lTOworCQlsIHw9IE9NQVAyX01DU1BJX0NIQ09ORl9EUEUxOworCQlsICY9
IH5PTUFQMl9NQ1NQSV9DSENPTkZfRFBFMDsKIAl9CiAKLQogCS8qIHdvcmRsZW5ndGggKi8KIAls
ICY9IH5PTUFQMl9NQ1NQSV9DSENPTkZfV0xfTUFTSzsKIAlsIHw9ICh3b3JkX2xlbiAtIDEpIDw8
IDc7CkBAIC0xMjE0LDcgKzEyMjcsNiBAQCBzdGF0aWMgaW50IF9faW5pdCBvbWFwMl9tY3NwaV9y
ZXNldChzdHJ1Y3Qgb21hcDJfbWNzcGkgKm1jc3BpKQogewogCXN0cnVjdCBzcGlfbWFzdGVyCSpt
YXN0ZXIgPSBtY3NwaS0+bWFzdGVyOwogCXUzMgkJCXRtcDsKLQl1MzIJCQllcnJvciA9IDA7CiAK
IAlpZiAob21hcDJfbWNzcGlfZW5hYmxlX2Nsb2NrcyhtY3NwaSkpCiAJCXJldHVybiAtMTsKQEAg
LTEyMzgsMTAgKzEyNTAsMTAgQEAgc3RhdGljIGludCBfX2luaXQgb21hcDJfbWNzcGlfcmVzZXQo
c3RydWN0IG9tYXAyX21jc3BpICptY3NwaSkKIAlpZiAobWNzcGktPm1jc3BpX21vZGUgPT0gT01B
UDJfTUNTUElfTUFTVEVSKQogCQlvbWFwMl9tY3NwaV9zZXRfbWFzdGVyX21vZGUobWFzdGVyKTsK
IAllbHNlCi0JCWVycm9yID0gLUVJTlZBTDsKKwkJb21hcDJfbWNzcGlfc2V0X3NsYXZlX21vZGUo
bWFzdGVyKTsKIAogCW9tYXAyX21jc3BpX2Rpc2FibGVfY2xvY2tzKG1jc3BpKTsKLQlyZXR1cm4g
ZXJyb3I7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyB1OCBfX2luaXRkYXRhIHNwaTFfcnhkbWFf
aWQgW10gPSB7CkBAIC0xMzUzLDcgKzEzNjUsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBvbWFwMl9t
Y3NwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCiAJbWNzcGkgPSBzcGlf
bWFzdGVyX2dldF9kZXZkYXRhKG1hc3Rlcik7CiAJbWNzcGktPm1hc3RlciA9IG1hc3RlcjsKLQlt
Y3NwaS0+bWNzcGlfbW9kZSA9IE9NQVAyX01DU1BJX01BU1RFUjsKKwltY3NwaS0+bWNzcGlfbW9k
ZSA9IHBkYXRhLT5tb2RlOwogCW1jc3BpLT5kbWFfbW9kZSA9IHBkYXRhLT5kbWFfbW9kZTsKIAlt
Y3NwaS0+Zm9yY2VfY3NfbW9kZSA9IHBkYXRhLT5mb3JjZV9jc19tb2RlOwogCi0tIAoxLjYuMy4z
Cgo=
------=_20100218161854_93180--


