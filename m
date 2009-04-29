From: Mika Korhonen <mika.j.korhonen@gmail.com>
Subject: [PATCH] OMAP OneNAND: add missing __devexit_p wrappers
Date: Wed, 29 Apr 2009 14:59:11 +0300
Message-ID: <7948530904290459q36d9c3fcq2db0dedcf88549d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c358cc576640468b04e84
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:35486 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbZD2L7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 07:59:13 -0400
Received: by fxm2 with SMTP id 2so1125702fxm.37
        for <linux-omap@vger.kernel.org>; Wed, 29 Apr 2009 04:59:12 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--0015174c358cc576640468b04e84
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The patch follows as attachment as gmail damages whitespaces and
git-send-mail is right now out of question.

Mika

--0015174c358cc576640468b04e84
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-OMAP-OneNAND-add-missing-__devexit_p-wrappers.patch"
Content-Disposition: attachment;
	filename="0001-OMAP-OneNAND-add-missing-__devexit_p-wrappers.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fu3yz9580

RnJvbSBiNzJiNTM3ZmYyMjlhOGQ2MjU0MDU2OWJjNTQzYzQxOTcwMmVjYjA1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWthIEtvcmhvbmVuIDxtaWthLmoua29yaG9uZW5AZ21haWwu
Y29tPgpEYXRlOiBXZWQsIDI5IEFwciAyMDA5IDE0OjEwOjM0ICswMzAwClN1YmplY3Q6IFtQQVRD
SF0gT01BUCBPbmVOQU5EOiBhZGQgbWlzc2luZyBfX2RldmV4aXRfcCB3cmFwcGVycwoKRml4ZXMg
YnVpbGQgaW4gY29uZmlndXJhdGlvbnMgd2hlcmUgZGV2ZXhpdCBmdW5jdGlvbnMgZ2V0IGRpc2Nh
cmRlZAoKU2lnbmVkLW9mZi1ieTogTWlrYSBLb3Job25lbiA8bWlrYS5qLmtvcmhvbmVuQGdtYWls
LmNvbT4KLS0tCiBkcml2ZXJzL210ZC9vbmVuYW5kL29tYXAyLmMgfCAgICA0ICsrLS0KIDEgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbXRkL29uZW5hbmQvb21hcDIuYyBiL2RyaXZlcnMvbXRkL29uZW5hbmQvb21hcDIu
YwppbmRleCBmMmU5ZGUxLi40ODgyOTM1IDEwMDY0NAotLS0gYS9kcml2ZXJzL210ZC9vbmVuYW5k
L29tYXAyLmMKKysrIGIvZHJpdmVycy9tdGQvb25lbmFuZC9vbWFwMi5jCkBAIC03NzgsOCArNzc4
LDggQEAgc3RhdGljIGludCBfX2RldmV4aXQgb21hcDJfb25lbmFuZF9yZW1vdmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikKIAogc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgb21h
cDJfb25lbmFuZF9kcml2ZXIgPSB7CiAJLnByb2JlCQk9IG9tYXAyX29uZW5hbmRfcHJvYmUsCi0J
LnJlbW92ZQkJPSBvbWFwMl9vbmVuYW5kX3JlbW92ZSwKLQkuc2h1dGRvd24JPSBvbWFwMl9vbmVu
YW5kX3NodXRkb3duLAorCS5yZW1vdmUJCT0gX19kZXZleGl0X3Aob21hcDJfb25lbmFuZF9yZW1v
dmUpLAorCS5zaHV0ZG93bgk9IF9fZGV2ZXhpdF9wKG9tYXAyX29uZW5hbmRfc2h1dGRvd24pLAog
CS5kcml2ZXIJCT0gewogCQkubmFtZQk9IERSSVZFUl9OQU1FLAogCQkub3duZXIgID0gVEhJU19N
T0RVTEUsCi0tIAoxLjUuNi41Cgo=
--0015174c358cc576640468b04e84--
