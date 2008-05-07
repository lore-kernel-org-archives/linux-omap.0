From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH] OMAP:DISPC Register name typo
Date: Wed, 7 May 2008 13:00:34 +0530
Message-ID: <c656a4d20805070030k1e5bcd39md4a7d3ce3730c56c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8670_10534250.1210145434972"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.152]:40402 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760070AbYEGHah (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 03:30:37 -0400
Received: by po-out-1718.google.com with SMTP id y22so259162pof.1
        for <linux-omap@vger.kernel.org>; Wed, 07 May 2008 00:30:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

------=_Part_8670_10534250.1210145434972
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

This patch corrects the register name typo in dispc.c.
False read happens just after the reset(reading DISPC_CONTROL returns
zero), this
might be the reason it worked fine without any issue.

############################################
>From 8734c18115caf53121c46002983b6c4763bd7f2b Mon Sep 17 00:00:00 2001
From: arun <arunedarath@mistralsolutions.com>
Date: Wed, 7 May 2008 12:25:40 +0530
Subject: [PATCH] OMAP:DISPC Register name typo

DISPC_CONTROL was used instead of DISPC_SYSCONFIG.

Signed-off-by: arun <arunedarath@mistralsolutions.com>
---
 drivers/video/omap/dispc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 4c055a2..6aff476 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -1393,7 +1393,7 @@ static int omap_dispc_init(struct omapfb_device
*fbdev, int ext_mode,
 	}

 	/* Enable smart idle and autoidle */
-	l = dispc_read_reg(DISPC_CONTROL);
+	l = dispc_read_reg(DISPC_SYSCONFIG);
 	l &= ~((3 << 12) | (3 << 3));
 	l |= (2 << 12) | (2 << 3) | (1 << 0);
 	dispc_write_reg(DISPC_SYSCONFIG, l);
-- 
1.5.3.4

##########################################

Regards,
Arun C

------=_Part_8670_10534250.1210145434972
Content-Type: text/x-patch; name=0001-OMAP-DISPC-Register-name-typo.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffxiv7s60
Content-Disposition: attachment;
 filename=0001-OMAP-DISPC-Register-name-typo.patch

RnJvbSA4NzM0YzE4MTE1Y2FmNTMxMjFjNDYwMDI5ODNiNmM0NzYzYmQ3ZjJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBhcnVuIDxhcnVuZWRhcmF0aEBtaXN0cmFsc29sdXRpb25zLmNv
bT4KRGF0ZTogV2VkLCA3IE1heSAyMDA4IDEyOjI1OjQwICswNTMwClN1YmplY3Q6IFtQQVRDSF0g
T01BUDpESVNQQyBSZWdpc3RlciBuYW1lIHR5cG8KCkRJU1BDX0NPTlRST0wgd2FzIHVzZWQgaW5z
dGVhZCBvZiBESVNQQ19TWVNDT05GSUcuCgpTaWduZWQtb2ZmLWJ5OiBhcnVuIDxhcnVuZWRhcmF0
aEBtaXN0cmFsc29sdXRpb25zLmNvbT4KLS0tCiBkcml2ZXJzL3ZpZGVvL29tYXAvZGlzcGMuYyB8
ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vb21hcC9kaXNwYy5jIGIvZHJpdmVycy92aWRl
by9vbWFwL2Rpc3BjLmMKaW5kZXggNGMwNTVhMi4uNmFmZjQ3NiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy92aWRlby9vbWFwL2Rpc3BjLmMKKysrIGIvZHJpdmVycy92aWRlby9vbWFwL2Rpc3BjLmMKQEAg
LTEzOTMsNyArMTM5Myw3IEBAIHN0YXRpYyBpbnQgb21hcF9kaXNwY19pbml0KHN0cnVjdCBvbWFw
ZmJfZGV2aWNlICpmYmRldiwgaW50IGV4dF9tb2RlLAogCX0KIAogCS8qIEVuYWJsZSBzbWFydCBp
ZGxlIGFuZCBhdXRvaWRsZSAqLwotCWwgPSBkaXNwY19yZWFkX3JlZyhESVNQQ19DT05UUk9MKTsK
KwlsID0gZGlzcGNfcmVhZF9yZWcoRElTUENfU1lTQ09ORklHKTsKIAlsICY9IH4oKDMgPDwgMTIp
IHwgKDMgPDwgMykpOwogCWwgfD0gKDIgPDwgMTIpIHwgKDIgPDwgMykgfCAoMSA8PCAwKTsKIAlk
aXNwY193cml0ZV9yZWcoRElTUENfU1lTQ09ORklHLCBsKTsKLS0gCjEuNS4zLjQKCg==
------=_Part_8670_10534250.1210145434972--
