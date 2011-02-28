From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [omap-for-linus] Un-used DSS regulator data
Date: Mon, 28 Feb 2011 14:20:18 +0530
Message-ID: <a46904cc06b5f68124e65086b9961d02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cd308047215049d53c5f6
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39376 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752924Ab1B1IuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 03:50:21 -0500
Received: by qyk2 with SMTP id 2so2794285qyk.9
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:50:20 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, Sumit Semwal <sumit.semwal@ti.com>
Cc: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com

--0015175cd308047215049d53c5f6
Content-Type: text/plain; charset=ISO-8859-1

Tomi/Sumit,

Today while building Tony's 'omap-for-linus' branch I came
across below build warning.
warning: 'sdp3430_vdda_dac_supply' defined but not used

It seems the DSS regulator data is not being used. Are you missing
any patch which will use it eventually?

If not I propose to remove that data to kill the warning.
Below is the patch for the same. Also attached the same

Regards,
Santosh

>From 037f1122d0bfe77883e6cf937009fd955be253a0 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 28 Feb 2011 13:54:19 +0530
Subject: [PATCH] omap: 3430sdp-board: Fix warning:
'sdp3430_vdda_dac_supply' defined but not used

The DSS regulator data not seems to be used. So remove the
un-used sdp3430_vdda_dac_supply to avoid build warning

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>
Cc: Sumit Semwal <sumit.semwal@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c
b/arch/arm/mach-omap2/board-3430sdp.c
index 8950ecc..19a36a3 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -307,9 +307,6 @@ static struct omap_dss_board_info sdp3430_dss_data = {
 	.default_device	= &sdp3430_lcd_device,
 };

-static struct regulator_consumer_supply sdp3430_vdda_dac_supply =
-	REGULATOR_SUPPLY("vdda_dac", "omapdss");
-
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 };

-- 
1.6.0.4

--0015175cd308047215049d53c5f6
Content-Type: application/octet-stream;
	name="0001-omap-3430sdp-board-Fix-warning-sdp3430_vdda_dac_.patch"
Content-Disposition: attachment;
	filename="0001-omap-3430sdp-board-Fix-warning-sdp3430_vdda_dac_.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 10e932623b34bb5f_0.1

RnJvbSAwMzdmMTEyMmQwYmZlNzc4ODNlNmNmOTM3MDA5ZmQ5NTViZTI1M2EwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBNb24sIDI4IEZlYiAyMDExIDEzOjU0OjE5ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gb21hcDogMzQzMHNkcC1ib2FyZDogRml4IHdhcm5pbmc6ICdzZHAzNDMwX3ZkZGFfZGFj
X3N1cHBseScgZGVmaW5lZCBidXQgbm90IHVzZWQKClRoZSBEU1MgcmVndWxhdG9yIGRhdGEgbm90
IHNlZW1zIHRvIGJlIHVzZWQuIFNvIHJlbW92ZSB0aGUKdW4tdXNlZCBzZHAzNDMwX3ZkZGFfZGFj
X3N1cHBseSB0byBhdm9pZCBidWlsZCB3YXJuaW5nCgpTaWduZWQtb2ZmLWJ5OiBTYW50b3NoIFNo
aWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJAdGkuY29tPgpDYzogU2VudGhpbHZhZGl2dSBHdXJ1
c3dhbXkgPHN2YWRpdnVAdGkuY29tPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAdGku
Y29tPgpDYzogVG9taSBWYWxrZWluZW4gPHRvbWkudmFsa2VpbmVuQHRpLmNvbT4KLS0tCiBhcmNo
L2FybS9tYWNoLW9tYXAyL2JvYXJkLTM0MzBzZHAuYyB8ICAgIDMgLS0tCiAxIGZpbGVzIGNoYW5n
ZWQsIDAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLW9tYXAyL2JvYXJkLTM0MzBzZHAuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQt
MzQzMHNkcC5jCmluZGV4IDg5NTBlY2MuLjE5YTM2YTMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21h
Y2gtb21hcDIvYm9hcmQtMzQzMHNkcC5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQt
MzQzMHNkcC5jCkBAIC0zMDcsOSArMzA3LDYgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2Rzc19ib2Fy
ZF9pbmZvIHNkcDM0MzBfZHNzX2RhdGEgPSB7CiAJLmRlZmF1bHRfZGV2aWNlCT0gJnNkcDM0MzBf
bGNkX2RldmljZSwKIH07CiAKLXN0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX2NvbnN1bWVyX3N1cHBs
eSBzZHAzNDMwX3ZkZGFfZGFjX3N1cHBseSA9Ci0JUkVHVUxBVE9SX1NVUFBMWSgidmRkYV9kYWMi
LCAib21hcGRzcyIpOwotCiBzdGF0aWMgc3RydWN0IG9tYXBfYm9hcmRfY29uZmlnX2tlcm5lbCBz
ZHAzNDMwX2NvbmZpZ1tdIF9faW5pdGRhdGEgPSB7CiB9OwogCi0tIAoxLjYuMC40Cgo=
--0015175cd308047215049d53c5f6--
