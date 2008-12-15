From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [OMAPZOOM] [PATCH] DSPBRIDGE DSP getProcessor state fix
Date: Mon, 15 Dec 2008 14:02:49 -0600
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E1A05B697@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E1A05B697dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60012 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbYLOUCz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 15:02:55 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id mBFK2oTC013610
	for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 14:02:55 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mBFK2oxs028232
	for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 14:02:50 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E1A05B697dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

DSP getProcessor state updated to cover
DSP Hibernation state

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.=
c
index eb7781d..64bb124
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -925,6 +925,8 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
 			case BRD_STOPPED:
 				pProcStatus->iState =3D PROC_STOPPED;
 				break;
+			case BRD_DSP_HIBERNATION:
+				/* Fall through */
 			case BRD_RUNNING:
 				pProcStatus->iState =3D PROC_RUNNING;
 				break;
@@ -935,6 +937,7 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
 				pProcStatus->iState =3D PROC_ERROR;
 				break;
 			default:
+				pProcStatus->iState =3D 0xFF;
 				status =3D DSP_EFAIL;
 				break;
 			}
@@ -967,7 +970,8 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
 	}
 	GT_2trace(PROC_DebugMask, GT_ENTER,
 		 "Exiting PROC_GetState, results:\n\t"
-		 "status:  0x%x\n\tpProcStatus: 0x%x\n", status, *pProcStatus);
+		 "status:  0x%x\n\tpProcStatus: 0x%x\n", status,
+		 pProcStatus->iState);
 	return status;
 }
=20
--=20
1.5.6.rc2

Thank you,
Best regards,
Hari

--_002_8F7AF80515AF0D4D93307E594F3CB40E1A05B697dlee03entticom_
Content-Type: application/octet-stream;
	name="0001-DSPBRIDGE-DSP-getProcessor-fixed.patch"
Content-Description: 0001-DSPBRIDGE-DSP-getProcessor-fixed.patch
Content-Disposition: attachment;
	filename="0001-DSPBRIDGE-DSP-getProcessor-fixed.patch"; size=1415;
	creation-date="Mon, 15 Dec 2008 10:23:03 GMT";
	modification-date="Mon, 15 Dec 2008 10:23:03 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwZGI1ZThhYTJkZDdhY2I3ODZjODFkYmM5NDQzMGM3ZGMwYjRiZTdkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IE1vbiwgMTUgRGVjIDIwMDggMTA6MTA6MjAgLTA2MDAKU3ViamVjdDogW1BBVENIXSBEU1BC
UklER0UgRFNQIGdldFByb2Nlc3NvciBmaXhlZAoKRFNQIGdldFByb2Nlc3NvciBzdGF0ZSB1cGRh
dGVkIHRvIGNvdmVyCkRTUCBIaWJlcm5hdGlvbiBzdGF0ZQoKU2lnbmVkLW9mZi1ieTogSGFyaSBL
YW5pZ2VyaSA8aC1rYW5pZ2VyaTJAdGkuY29tPgotLS0KIGRyaXZlcnMvZHNwL2JyaWRnZS9ybWdy
L3Byb2MuYyB8ICAgIDYgKysrKystCiAxIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9wcm9j
LmMgYi9kcml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9wcm9jLmMKaW5kZXggZWI3NzgxZC4uNjRiYjEy
NAotLS0gYS9kcml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9wcm9jLmMKKysrIGIvZHJpdmVycy9kc3Av
YnJpZGdlL3JtZ3IvcHJvYy5jCkBAIC05MjUsNiArOTI1LDggQEAgRFNQX1NUQVRVUyBQUk9DX0dl
dFN0YXRlKERTUF9IUFJPQ0VTU09SIGhQcm9jZXNzb3IsCiAJCQljYXNlIEJSRF9TVE9QUEVEOgog
CQkJCXBQcm9jU3RhdHVzLT5pU3RhdGUgPSBQUk9DX1NUT1BQRUQ7CiAJCQkJYnJlYWs7CisJCQlj
YXNlIEJSRF9EU1BfSElCRVJOQVRJT046CisJCQkJLyogRmFsbCB0aHJvdWdoICovCiAJCQljYXNl
IEJSRF9SVU5OSU5HOgogCQkJCXBQcm9jU3RhdHVzLT5pU3RhdGUgPSBQUk9DX1JVTk5JTkc7CiAJ
CQkJYnJlYWs7CkBAIC05MzUsNiArOTM3LDcgQEAgRFNQX1NUQVRVUyBQUk9DX0dldFN0YXRlKERT
UF9IUFJPQ0VTU09SIGhQcm9jZXNzb3IsCiAJCQkJcFByb2NTdGF0dXMtPmlTdGF0ZSA9IFBST0Nf
RVJST1I7CiAJCQkJYnJlYWs7CiAJCQlkZWZhdWx0OgorCQkJCXBQcm9jU3RhdHVzLT5pU3RhdGUg
PSAweEZGOwogCQkJCXN0YXR1cyA9IERTUF9FRkFJTDsKIAkJCQlicmVhazsKIAkJCX0KQEAgLTk2
Nyw3ICs5NzAsOCBAQCBEU1BfU1RBVFVTIFBST0NfR2V0U3RhdGUoRFNQX0hQUk9DRVNTT1IgaFBy
b2Nlc3NvciwKIAl9CiAJR1RfMnRyYWNlKFBST0NfRGVidWdNYXNrLCBHVF9FTlRFUiwKIAkJICJF
eGl0aW5nIFBST0NfR2V0U3RhdGUsIHJlc3VsdHM6XG5cdCIKLQkJICJzdGF0dXM6ICAweCV4XG5c
dHBQcm9jU3RhdHVzOiAweCV4XG4iLCBzdGF0dXMsICpwUHJvY1N0YXR1cyk7CisJCSAic3RhdHVz
OiAgMHgleFxuXHRwUHJvY1N0YXR1czogMHgleFxuIiwgc3RhdHVzLAorCQkgcFByb2NTdGF0dXMt
PmlTdGF0ZSk7CiAJcmV0dXJuIHN0YXR1czsKIH0KIAotLSAKMS41LjYucmMyCgo=

--_002_8F7AF80515AF0D4D93307E594F3CB40E1A05B697dlee03entticom_--
