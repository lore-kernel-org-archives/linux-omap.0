From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v13 10/11] OMAP: dmtimer: mark clocksource and
 clockevent timers reserved
Date: Mon, 25 Apr 2011 15:11:42 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037AD277AF@dbde02.ent.ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
 <1302969063-8231-11-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_5A47E75E594F054BAF48C5E4FC4B92AB037AD277AFdbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38986 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758103Ab1DYJmG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Apr 2011 05:42:06 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3P9g3xn007871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 25 Apr 2011 04:42:05 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p3P9g2Mj014127
	for <linux-omap@vger.kernel.org>; Mon, 25 Apr 2011 15:12:02 +0530 (IST)
In-Reply-To: <1302969063-8231-11-git-send-email-tarun.kanti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_5A47E75E594F054BAF48C5E4FC4B92AB037AD277AFdbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

In driver probe use sys_timer_reserved to identify which all timers
have already been used for clocksource and clockevent. Mark all those
timers as reserved so that no one else can use them.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
Changed CONFIG_ARCH_OMAP2 to CONFIG_ARCH_OMAP2PLUS.

 arch/arm/plat-omap/dmtimer.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index e15b3a8..14d01ec 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -554,7 +554,13 @@ static int __devinit omap_dm_timer_probe(struct platfo=
rm_device *pdev)
 	timer->id =3D pdev->id;
 	timer->irq =3D irq->start;
 	timer->pdev =3D pdev;
-	timer->reserved =3D 0;
+#if defined(CONFIG_ARCH_OMAP2PLUS)
+	/* Mark clocksource and clockevent timers as reserved */
+	if ((sys_timer_reserved >> (pdev->id - 1)) & 0x1)
+		timer->reserved =3D 1;
+	else
+#endif
+		timer->reserved =3D 0;
=20
 	 /* Skip pm_runtime_enable for OMAP1 */
 	if (!pdata->needs_manual_reset)
--=20
1.6.0.4


--_002_5A47E75E594F054BAF48C5E4FC4B92AB037AD277AFdbde02enttico_
Content-Type: application/octet-stream;
	name="0010-OMAP-dmtimer-mark-clocksource-and-clockevent-timer.patch"
Content-Description: 0010-OMAP-dmtimer-mark-clocksource-and-clockevent-timer.patch
Content-Disposition: attachment;
	filename="0010-OMAP-dmtimer-mark-clocksource-and-clockevent-timer.patch";
	size=1260; creation-date="Mon, 18 Apr 2011 15:26:01 GMT";
	modification-date="Mon, 18 Apr 2011 15:26:01 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwZWZkNGY4NjAxNGE3ZWJlNWIxZWMzM2UzOTI5NmZmMjcyZjU1MzdjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYXJ1biBLYW50aSBEZWJCYXJtYSA8dGFydW4ua2FudGlAdGku
Y29tPgpEYXRlOiBNb24sIDE4IEFwciAyMDExIDE1OjIzOjIwICswNTMwClN1YmplY3Q6IFtQQVRD
SCB2MTQgMTAvMTJdIE9NQVA6IGRtdGltZXI6IG1hcmsgY2xvY2tzb3VyY2UgYW5kIGNsb2NrZXZl
bnQgdGltZXJzIHJlc2VydmVkCgpJbiBkcml2ZXIgcHJvYmUgdXNlIHN5c190aW1lcl9yZXNlcnZl
ZCB0byBpZGVudGlmeSB3aGljaCBhbGwgdGltZXJzCmhhdmUgYWxyZWFkeSBiZWVuIHVzZWQgZm9y
IGNsb2Nrc291cmNlIGFuZCBjbG9ja2V2ZW50LiBNYXJrIGFsbCB0aG9zZQp0aW1lcnMgYXMgcmVz
ZXJ2ZWQgc28gdGhhdCBubyBvbmUgZWxzZSBjYW4gdXNlIHRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBU
YXJ1biBLYW50aSBEZWJCYXJtYSA8dGFydW4ua2FudGlAdGkuY29tPgotLS0KIGFyY2gvYXJtL3Bs
YXQtb21hcC9kbXRpbWVyLmMgfCAgICA4ICsrKysrKystCiAxIGZpbGVzIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9t
YXAvZG10aW1lci5jIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2RtdGltZXIuYwppbmRleCBlMTViM2E4
Li4xNGQwMWVjIDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW9tYXAvZG10aW1lci5jCisrKyBi
L2FyY2gvYXJtL3BsYXQtb21hcC9kbXRpbWVyLmMKQEAgLTU1NCw3ICs1NTQsMTMgQEAgc3RhdGlj
IGludCBfX2RldmluaXQgb21hcF9kbV90aW1lcl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQogCXRpbWVyLT5pZCA9IHBkZXYtPmlkOwogCXRpbWVyLT5pcnEgPSBpcnEtPnN0YXJ0
OwogCXRpbWVyLT5wZGV2ID0gcGRldjsKLQl0aW1lci0+cmVzZXJ2ZWQgPSAwOworI2lmIGRlZmlu
ZWQoQ09ORklHX0FSQ0hfT01BUDJQTFVTKQorCS8qIE1hcmsgY2xvY2tzb3VyY2UgYW5kIGNsb2Nr
ZXZlbnQgdGltZXJzIGFzIHJlc2VydmVkICovCisJaWYgKChzeXNfdGltZXJfcmVzZXJ2ZWQgPj4g
KHBkZXYtPmlkIC0gMSkpICYgMHgxKQorCQl0aW1lci0+cmVzZXJ2ZWQgPSAxOworCWVsc2UKKyNl
bmRpZgorCQl0aW1lci0+cmVzZXJ2ZWQgPSAwOwogCiAJIC8qIFNraXAgcG1fcnVudGltZV9lbmFi
bGUgZm9yIE9NQVAxICovCiAJaWYgKCFwZGF0YS0+bmVlZHNfbWFudWFsX3Jlc2V0KQotLSAKMS42
LjAuNAoK

--_002_5A47E75E594F054BAF48C5E4FC4B92AB037AD277AFdbde02enttico_--
