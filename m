From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 5/5 v2] ASoC Adds DSP DAI format support for platform driver
Date: Thu, 2 Oct 2008 15:07:06 +0530
Message-ID: <dfeb90390810020237r2f5b0fbdpeced17effcfba3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_68218_22594813.1222940226803"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:12291 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbYJBJhH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 05:37:07 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1053114rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 02 Oct 2008 02:37:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com, troy.kisky@boundarydevices.com

------=_Part_68218_22594813.1222940226803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Enables DSP DAI format for mcbsp in omap platform driver

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/omap-mcbsp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 35310e1..fb920e1 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -245,6 +245,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct
snd_soc_dai *cpu_dai,
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		/* 0-bit data delay */
+		regs->rcr2      |= RDATDLY(0);
+		regs->xcr2      |= XDATDLY(0);
+		break;
 	default:
 		/* Unsupported data format */
 		return -EINVAL;
-- 
1.5.3.4

------=_Part_68218_22594813.1222940226803
Content-Type: text/x-patch;
 name=0005-ASoC-Adds-DSP-DAI-format-support-for-platform-driver.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_flt71u1s0
Content-Disposition: attachment;
 filename=0005-ASoC-Adds-DSP-DAI-format-support-for-platform-driver.patch

RnJvbSAzZjNjMjUyNjI1MjM2YmQ3ZjNhM2M5NDk3NjlkNDFiMjZlZmJjODA1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IFR1ZSwgMzAgU2VwIDIwMDggMTM6MzA6MTUgKzA1MzAKU3ViamVjdDogW1BBVENIXSBB
U29DIEFkZHMgRFNQIERBSSBmb3JtYXQgc3VwcG9ydCBmb3IgcGxhdGZvcm0gZHJpdmVyCgpFbmFi
bGVzIERTUCBEQUkgZm9ybWF0IGZvciBtY2JzcCBpbiBvbWFwIHBsYXRmb3JtIGRyaXZlcgoKU2ln
bmVkLW9mZi1ieTogQXJ1biBLUyA8YXJ1bmtzQG1pc3RyYWxzb2x1dGlvbnMuY29tPgotLS0KIHNv
dW5kL3NvYy9vbWFwL29tYXAtbWNic3AuYyB8ICAgIDUgKysrKysKIDEgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9v
bWFwL29tYXAtbWNic3AuYyBiL3NvdW5kL3NvYy9vbWFwL29tYXAtbWNic3AuYwppbmRleCAzNTMx
MGUxLi5mYjkyMGUxIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvb21hcC9vbWFwLW1jYnNwLmMKKysr
IGIvc291bmQvc29jL29tYXAvb21hcC1tY2JzcC5jCkBAIC0yNDUsNiArMjQ1LDExIEBAIHN0YXRp
YyBpbnQgb21hcF9tY2JzcF9kYWlfc2V0X2RhaV9mbXQoc3RydWN0IHNuZF9zb2NfZGFpICpjcHVf
ZGFpLAogCQlyZWdzLT5yY3IyCXw9IFJEQVRETFkoMSk7CiAJCXJlZ3MtPnhjcjIJfD0gWERBVERM
WSgxKTsKIAkJYnJlYWs7CisJY2FzZSBTTkRfU09DX0RBSUZNVF9EU1BfQToKKwkJLyogMC1iaXQg
ZGF0YSBkZWxheSAqLworCQlyZWdzLT5yY3IyICAgICAgfD0gUkRBVERMWSgwKTsKKwkJcmVncy0+
eGNyMiAgICAgIHw9IFhEQVRETFkoMCk7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCS8qIFVuc3Vw
cG9ydGVkIGRhdGEgZm9ybWF0ICovCiAJCXJldHVybiAtRUlOVkFMOwotLSAKMS41LjMuNAoK
------=_Part_68218_22594813.1222940226803--
