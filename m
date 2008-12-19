From: Jean Pihet <jpihet@mvista.com>
Subject: [PATCH] OMAP: MMC: recover from transfer failures
Date: Fri, 19 Dec 2008 10:06:49 +0100
Message-ID: <200812191006.49370.jpihet@mvista.com>
References: <200812161957.37854.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pQ2SJ20jo0V0lpd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:23722 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbYLSJGx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2008 04:06:53 -0500
Received: from ip6-localhost (asshur.mvista.com [10.0.0.11])
	by hermes.mvista.com (Postfix) with ESMTP id BD58818850
	for <linux-omap@vger.kernel.org>; Fri, 19 Dec 2008 01:06:52 -0800 (PST)
In-Reply-To: <200812161957.37854.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--Boundary-00=_pQ2SJ20jo0V0lpd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGksCgpIZXJlIGlzIGEgcGF0Y2ggdGhhdCBmaXhlcyBhIE1NQyBob3N0IGNvbnRyb2xsZXIgZGVh
ZGxvY2suIFRoZSBwcm9ibGVtIGhhcHBlbnMgCndoZW4gcmVtb3ZpbmcgdGhlIE1NQy9TRCBkZXZp
Y2Ugd2hlbiBhIHRyYW5zZmVyIGlzIG9uLWdvaW5nLgoKSXQgaGFzIGJlZW4gdGVzdGVkIG9uIE9N
QVAzNDMwIGJ1dCB0aGlzIGZpeCBzaG91bGQgYXBwbHkgdG8gT01BUDIgY2hpcHMgYXMgCndlbGws
IGFzIHNlZW4gZnJvbSB0aGUgVFJNcy4KCsKgIMKgIE9NQVA6IE1NQzogcmVjb3ZlciBmcm9tIHRy
YW5zZmVyIGZhaWx1cmVzCgrCoCDCoCBUaW1lb3V0cyBkdXJpbmcgYSBjb21tYW5kIHRoYXQgaGFz
IGEgZGF0YSBwaGFzZSBjYW4gcmVzdWx0IGluIHRoZQrCoCDCoCBuZXh0IGNvbW1hbmQgaXNzdWVk
IGFmdGVyIHRoZSBjb21tYW5kIHRoYXQgZmFpbGVkIG5vdCBiZWluZyBwcm9jZXNzZWQsCsKgIMKg
IGkuZS4gbm8gaW50ZXJydXB0IGV2ZXIgb2NjdXJzIHRvIGluZGljYXRlIHRoZSBjb21tYW5kIGhh
cyBjb21wbGV0ZWQuCsKgIMKgIFRoaXMgZmFpbHVyZSBjYW4gcmVzdWx0IGluIGEgZGVhZGxvY2su
CgrCoCDCoCBUaGUgaW5kaWNhdGlvbiB0aGF0IHRoZSBtbWMgaG9zdCBjb250cm9sbGVyIGlzIGlu
IHRoaXMgZXJyb3Igc3RhdGUgaXMKwqAgwqAgdGhhdCB0aGUgREFUSSBiaXQgaXMgc2V0IGluIHRo
ZSBQU1RBVEUgcmVnaXN0ZXIuIMKgVGhpcyBwYXRjaCBjaGVja3MKwqAgwqAgdG8gc2VlIGlmIHRo
ZSBEQVRJIGJpdCBpcyBzZXQgYmVmb3JlIHN0YXJ0aW5nIGEgbmV3IGNvbW1hbmQsIGFuZCBpZiBp
dArCoCDCoCBpcyBzZXQgaXQgcmVzZXRzIHRoZSBkYXRhIHN0YXRlIG1hY2hpbmUgdG8gY2xlYXIg
dGhlIGVycm9yLgoKwqAgwqAgVGVzdGVkIG9uIE9NQVAzNDMwIGNoaXAgYW5kIGludGVuc2l2ZSBN
TUMvU0QgZGV2aWNlIHJlbW92YWwgd2hpbGUKwqAgwqAgdHJhbnNmZXJyaW5nIGRhdGEuCgpSZWdh
cmRzLApKZWFuCgoKRnJvbSA0OGE0MDkyNWE0ZDU3ZjZlN2U0NTgwOWE0YjVjMDliMjBmOTMxNGQ3
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZWFuIFBpaGV0IDxqcGloZXRAbXZpc3Rh
LmNvbT4KRGF0ZTogVHVlLCAxNiBEZWMgMjAwOCAxOTo0NDoxMiArMDEwMApTdWJqZWN0OiBbUEFU
Q0hdIE9NQVA6IE1NQzogcmVjb3ZlciBmcm9tIHRyYW5zZmVyIGZhaWx1cmVzCgpUaW1lb3V0cyBk
dXJpbmcgYSBjb21tYW5kIHRoYXQgaGFzIGEgZGF0YSBwaGFzZSBjYW4gcmVzdWx0IGluIHRoZQpu
ZXh0IGNvbW1hbmQgaXNzdWVkIGFmdGVyIHRoZSBjb21tYW5kIHRoYXQgZmFpbGVkIG5vdCBiZWlu
ZyBwcm9jZXNzZWQsCmkuZS4gbm8gaW50ZXJydXB0IGV2ZXIgb2NjdXJzIHRvIGluZGljYXRlIHRo
ZSBjb21tYW5kIGhhcyBjb21wbGV0ZWQuClRoaXMgZmFpbHVyZSBjYW4gcmVzdWx0IGluIGEgZGVh
ZGxvY2suCgpUaGUgaW5kaWNhdGlvbiB0aGF0IHRoZSBtbWMgaG9zdCBjb250cm9sbGVyIGlzIGlu
IHRoaXMgZXJyb3Igc3RhdGUgaXMKdGhhdCB0aGUgREFUSSBiaXQgaXMgc2V0IGluIHRoZSBQU1RB
VEUgcmVnaXN0ZXIuIMKgVGhpcyBwYXRjaCBjaGVja3MKdG8gc2VlIGlmIHRoZSBEQVRJIGJpdCBp
cyBzZXQgYmVmb3JlIHN0YXJ0aW5nIGEgbmV3IGNvbW1hbmQsIGFuZCBpZiBpdAppcyBzZXQgaXQg
cmVzZXRzIHRoZSBkYXRhIHN0YXRlIG1hY2hpbmUgdG8gY2xlYXIgdGhlIGVycm9yLgoKVGVzdGVk
IG9uIE9NQVAzNDMwIGNoaXAgYW5kIGludGVuc2l2ZSBNTUMvU0QgZGV2aWNlIHJlbW92YWwgd2hp
bGUKdHJhbnNmZXJyaW5nIGRhdGEuCgpTaWduZWQtb2ZmLWJ5OiBBbmR5IExvd2UgPGFsb3dlQG12
aXN0YS5jb20+ClNpZ25lZC1vZmYtYnk6IEplYW4gUGloZXQgPGpwaWhldEBtdmlzdGEuY29tPgot
LS0KwqBkcml2ZXJzL21tYy9ob3N0L29tYXBfaHNtbWMuYyB8IMKgIDExICsrKysrKysrKysrCsKg
MSBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvb21hcF9oc21tYy5jIGIvZHJpdmVycy9tbWMvaG9zdC9v
bWFwX2hzbW1jLmMKaW5kZXggMWZjYzU0NC4uYjdkMTExZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9t
bWMvaG9zdC9vbWFwX2hzbW1jLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9vbWFwX2hzbW1jLmMK
QEAgLTQ0LDYgKzQ0LDcgQEAKwqAjZGVmaW5lIE9NQVBfSFNNTUNfUlNQNTTCoMKgwqDCoMKgwqDC
oDB4MDExOArCoCNkZWZpbmUgT01BUF9IU01NQ19SU1A3NsKgwqDCoMKgwqDCoMKgMHgwMTFDCsKg
I2RlZmluZSBPTUFQX0hTTU1DX0RBVEHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDB4
MDEyMAorI2RlZmluZSBPTUFQX0hTTU1DX1BTVEFURcKgwqDCoMKgwqDCoDB4MDEyNArCoCNkZWZp
bmUgT01BUF9IU01NQ19IQ1RMwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDAxMjgK
wqAjZGVmaW5lIE9NQVBfSFNNTUNfU1lTQ1RMwqDCoMKgwqDCoMKgMHgwMTJDCsKgI2RlZmluZSBP
TUFQX0hTTU1DX1NUQVTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDB4MDEzMApAQCAt
ODksNiArOTAsNyBAQArCoCNkZWZpbmUgRFVBTF9WT0xUX09DUl9CSVTCoMKgwqDCoMKgwqA3CsKg
I2RlZmluZSBTUkPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKDEgPDwg
MjUpCsKgI2RlZmluZSBTUkTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
KDEgPDwgMjYpCisjZGVmaW5lIERBVEnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCgxIDw8IDEpCsKgCsKgLyoKwqAgKiBGSVhNRTogTW9zdCBsaWtlbHkgYWxsIHRoZSBkYXRh
IHVzaW5nIHRoZXNlIF9ERVZJRCBkZWZpbmVzIHNob3VsZCBjb21lCkBAIC0yNzMsNiArMjc1LDE1
IEBAIG1tY19vbWFwX3N0YXJ0X2NvbW1hbmQoc3RydWN0IG1tY19vbWFwX2hvc3QgKmhvc3QsIHN0
cnVjdCAKbW1jX2NvbW1hbmQgKmNtZCwKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBt
bWNfaG9zdG5hbWUoaG9zdC0+bW1jKSwgY21kLT5vcGNvZGUsIGNtZC0+YXJnKTsKwqDCoMKgwqDC
oMKgwqDCoGhvc3QtPmNtZCA9IGNtZDsKwqAKK8KgwqDCoMKgwqDCoMKgaWYgKE9NQVBfSFNNTUNf
UkVBRChob3N0LT5iYXNlLCBQU1RBVEUpICYgREFUSSkgeworwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZGV2X2RiZyhtbWNfZGV2KGhvc3QtPm1tYyksICJtbWNfb21hcF9zdGFydF9jb21t
YW5kOiAiCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIiBy
ZXNldHRpbmcgZGF0YSBzdGF0ZSBtYWNoaW5lXG4iKTsKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoE9NQVBfSFNNTUNfV1JJVEUoaG9zdC0+YmFzZSwgU1lTQ1RMLAorwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE9NQVBfSFNNTUNfUkVBRChob3N0LT5i
YXNlLCBTWVNDVEwpIHwgU1JEKTsKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHdoaWxl
IChPTUFQX0hTTU1DX1JFQUQoaG9zdC0+YmFzZSwgU1lTQ1RMKSAmIFNSRCkKK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA7CivCoMKgwqDCoMKgwqDCoH0KKwrC
oMKgwqDCoMKgwqDCoMKgLyoKwqDCoMKgwqDCoMKgwqDCoCAqIENsZWFyIHN0YXR1cyBiaXRzIGFu
ZCBlbmFibGUgaW50ZXJydXB0cwrCoMKgwqDCoMKgwqDCoMKgICovCi0tIAoxLjUuNC40LjIxLmdj
NGE2YwoKCg==

--Boundary-00=_pQ2SJ20jo0V0lpd
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="OMAP-MMC-recover-from-transfer-failures.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="OMAP-MMC-recover-from-transfer-failures.patch"

=46rom 48a40925a4d57f6e7e45809a4b5c09b20f9314d7 Mon Sep 17 00:00:00 2001
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Tue, 16 Dec 2008 19:44:12 +0100
Subject: [PATCH] OMAP: MMC: recover from transfer failures

Timeouts during a command that has a data phase can result in the
next command issued after the command that failed not being processed,
i.e. no interrupt ever occurs to indicate the command has completed.
This failure can result in a deadlock.

The indication that the mmc host controller is in this error state is
that the DATI bit is set in the PSTATE register.  This patch checks
to see if the DATI bit is set before starting a new command, and if it
is set it resets the data state machine to clear the error.

Tested on OMAP3430 chip and intensive MMC/SD device removal while
transferring data.

Signed-off-by: Andy Lowe <alowe@mvista.com>
Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 drivers/mmc/host/omap_hsmmc.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1fcc544..b7d111e 100644
=2D-- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -44,6 +44,7 @@
 #define OMAP_HSMMC_RSP54	0x0118
 #define OMAP_HSMMC_RSP76	0x011C
 #define OMAP_HSMMC_DATA		0x0120
+#define OMAP_HSMMC_PSTATE	0x0124
 #define OMAP_HSMMC_HCTL		0x0128
 #define OMAP_HSMMC_SYSCTL	0x012C
 #define OMAP_HSMMC_STAT		0x0130
@@ -89,6 +90,7 @@
 #define DUAL_VOLT_OCR_BIT	7
 #define SRC			(1 << 25)
 #define SRD			(1 << 26)
+#define DATI			(1 << 1)
=20
 /*
  * FIXME: Most likely all the data using these _DEVID defines should come
@@ -273,6 +275,15 @@ mmc_omap_start_command(struct mmc_omap_host *host, str=
uct mmc_command *cmd,
 		mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
 	host->cmd =3D cmd;
=20
+	if (OMAP_HSMMC_READ(host->base, PSTATE) & DATI) {
+		dev_dbg(mmc_dev(host->mmc), "mmc_omap_start_command: "
+			" resetting data state machine\n");
+		OMAP_HSMMC_WRITE(host->base, SYSCTL,
+			OMAP_HSMMC_READ(host->base, SYSCTL) | SRD);
+		while (OMAP_HSMMC_READ(host->base, SYSCTL) & SRD)
+			;
+	}
+
 	/*
 	 * Clear status bits and enable interrupts
 	 */
=2D-=20
1.5.4.4.21.gc4a6c


--Boundary-00=_pQ2SJ20jo0V0lpd--
