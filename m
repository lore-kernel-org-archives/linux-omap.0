From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH] [OMAPZOOM]DSPBRIDGE bug in Bridge exit cleanup
Date: Mon, 23 Mar 2009 13:49:19 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2342BE9F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E2342BE9Fdlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42921 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZCWSt1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 14:49:27 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2NInLQ0018531
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 13:49:26 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2NInLKM027051
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 13:49:21 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_8F7AF80515AF0D4D93307E594F3CB40E2342BE9Fdlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The Bridge exit resource cleanup is accessing Process
context pointer after it is freed. Fixed this by holding
the next Process context pointer in a temporary variable.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/r=
mgr/drv_interface.c
index a756997..af98600 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -537,7 +537,7 @@ static void __exit bridge_exit(void)
 	DSP_STATUS dsp_status =3D DSP_SOK;
 	HANDLE hDrvObject =3D NULL;
 	struct PROCESS_CONTEXT    *pCtxtclosed =3D NULL;
-
+	struct PROCESS_CONTEXT    *pTmp =3D NULL;
 	GT_0trace(driverTrace, GT_ENTER, "-> driver_exit\n");
=20
=20
@@ -551,9 +551,10 @@ static void __exit bridge_exit(void)
 			 "process***%d\n", pCtxtclosed->pid);
 		DRV_RemoveAllResources(pCtxtclosed);
 		PROC_Detach(pCtxtclosed->hProcessor);
+		pTmp =3D  pCtxtclosed->next;
 		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
 				     pCtxtclosed, (void *)pCtxtclosed->pid);
-		pCtxtclosed =3D pCtxtclosed->next;;
+		pCtxtclosed =3D pTmp;
 	}
 func_cont:
 #ifndef CONFIG_DISABLE_BRIDGE_PM
--=20
1.5.4.3


Thank you,
Best regards,
Hari


--_002_8F7AF80515AF0D4D93307E594F3CB40E2342BE9Fdlee03entticom_
Content-Type: application/octet-stream;
	name="0001-OMAPZOOM-DSPBRIDGE-bug-in-Bridge-exit-cleanup.patch"
Content-Description: 0001-OMAPZOOM-DSPBRIDGE-bug-in-Bridge-exit-cleanup.patch
Content-Disposition: attachment;
	filename="0001-OMAPZOOM-DSPBRIDGE-bug-in-Bridge-exit-cleanup.patch";
	size=1522; creation-date="Mon, 23 Mar 2009 11:39:53 GMT";
	modification-date="Mon, 23 Mar 2009 13:19:23 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxM2I5MzU1ZGNjY2Q2MTg0YTQyNDBkNDk4NjgwODdkZGFhNzgyMTQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogSGFyaSBLYW5pZ2VyaSA8a2FuaWdlcmlATWF0cml4Lihub25l
KT4NCkRhdGU6IE1vbiwgMjMgTWFyIDIwMDkgMTA6MDQ6NTMgLTA2MDANClN1YmplY3Q6IFtQQVRD
SF0gW09NQVBaT09NXURTUEJSSURHRSBidWcgaW4gQnJpZGdlIGV4aXQgY2xlYW51cA0KDQpUaGUg
QnJpZGdlIGV4aXQgcmVzb3VyY2UgY2xlYW51cCBpcyBhY2Nlc3NpbmcgcHJvY2Vzcw0KY29udGV4
dCBwb2ludGVyIGFmdGVyIGl0IGlzIGZyZWVkLiBGaXhlZCB0aGlzIGJ5IGhvbGRpbmcNCnRoZSBu
ZXh0IFByb2Nlc3MgY29udGV4dCBwb2ludGVyIGluIGEgdGVtcG9yYXJ5IHZhcmlhYmxlLg0KDQpT
aWduZWQtb2ZmLWJ5OiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+DQotLS0NCiBk
cml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9kcnZfaW50ZXJmYWNlLmMgfCAgICA1ICsrKy0tDQogMSBm
aWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9kcnZfaW50ZXJmYWNlLmMgYi9kcml2ZXJzL2Rz
cC9icmlkZ2Uvcm1nci9kcnZfaW50ZXJmYWNlLmMNCmluZGV4IGE3NTY5OTcuLmFmOTg2MDAgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9kcnZfaW50ZXJmYWNlLmMNCisrKyBi
L2RyaXZlcnMvZHNwL2JyaWRnZS9ybWdyL2Rydl9pbnRlcmZhY2UuYw0KQEAgLTUzNyw3ICs1Mzcs
NyBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgYnJpZGdlX2V4aXQodm9pZCkNCiAJRFNQX1NUQVRVUyBk
c3Bfc3RhdHVzID0gRFNQX1NPSzsNCiAJSEFORExFIGhEcnZPYmplY3QgPSBOVUxMOw0KIAlzdHJ1
Y3QgUFJPQ0VTU19DT05URVhUICAgICpwQ3R4dGNsb3NlZCA9IE5VTEw7DQotDQorCXN0cnVjdCBQ
Uk9DRVNTX0NPTlRFWFQgICAgKnBUbXAgPSBOVUxMOw0KIAlHVF8wdHJhY2UoZHJpdmVyVHJhY2Us
IEdUX0VOVEVSLCAiLT4gZHJpdmVyX2V4aXRcbiIpOw0KIA0KIA0KQEAgLTU1MSw5ICs1NTEsMTAg
QEAgc3RhdGljIHZvaWQgX19leGl0IGJyaWRnZV9leGl0KHZvaWQpDQogCQkJICJwcm9jZXNzKioq
JWRcbiIsIHBDdHh0Y2xvc2VkLT5waWQpOw0KIAkJRFJWX1JlbW92ZUFsbFJlc291cmNlcyhwQ3R4
dGNsb3NlZCk7DQogCQlQUk9DX0RldGFjaChwQ3R4dGNsb3NlZC0+aFByb2Nlc3Nvcik7DQorCQlw
VG1wID0gIHBDdHh0Y2xvc2VkLT5uZXh0Ow0KIAkJRFJWX1JlbW92ZVByb2NDb250ZXh0KChzdHJ1
Y3QgRFJWX09CSkVDVCAqKWhEcnZPYmplY3QsDQogCQkJCSAgICAgcEN0eHRjbG9zZWQsICh2b2lk
ICopcEN0eHRjbG9zZWQtPnBpZCk7DQotCQlwQ3R4dGNsb3NlZCA9IHBDdHh0Y2xvc2VkLT5uZXh0
OzsNCisJCXBDdHh0Y2xvc2VkID0gcFRtcDsNCiAJfQ0KIGZ1bmNfY29udDoNCiAjaWZuZGVmIENP
TkZJR19ESVNBQkxFX0JSSURHRV9QTQ0KLS0gDQoxLjUuNC4zDQoNCg==

--_002_8F7AF80515AF0D4D93307E594F3CB40E2342BE9Fdlee03entticom_--
