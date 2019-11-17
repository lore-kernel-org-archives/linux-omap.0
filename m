From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [RFCv1 28/42] drm/dsi: add MIPI_DSI_MODE_ULPS_IDLE
Date: Sun, 17 Nov 2019 03:40:14 +0100
Message-ID: <20191117024028.2233-29-sebastian.reichel@collabora.com>
References: <20191117024028.2233-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191117024028.2233-1-sebastian.reichel@collabora.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel@collabora.com, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

RFNJIGNvbW1hbmQgbW9kZSBwYW5lbHMgYXJlIHNlbGYtcmVmcmVzaGluZyBkaXNwbGF5cywgdGhh
dApjYW4gYmUgdXBkYXRlZCB2ZXJ5IHJhcmVseSBmb3Igc3RhdGljIGltYWdlcy4gRm9yIHRoaXMg
a2luZApvZiBzY2VuYXJpbyBzb21lIHBhbmVscyBzdXBwb3J0LCB0aGF0IHRoZSBEU0kgYnVzIHN3
aXRjaGVzCmludG8gVUxQUyBtb2RlIHVudGlsIHRoZSBwYW5lbCBuZWVkcyB0byBiZSByZWZyZXNo
ZWQuCgpUaGlzIGlzIHByb2JsZW1hdGljIG9uIHNvbWUgcGFuZWxzLCBzbyBpbnRyb2R1Y2UgYSBm
bGFnIHRvCnNpZ25hbCB0aGUgRFNJIGhvc3QgaW1wbGVtZW50YXRpb24gdGhhdCB0aGUgcGFuZWwg
YWxsb3dzCmdvaW5nIGludG8gVUxQUyBtb2RlLgoKU2lnbmVkLW9mZi1ieTogU2ViYXN0aWFuIFJl
aWNoZWwgPHNlYmFzdGlhbi5yZWljaGVsQGNvbGxhYm9yYS5jb20+Ci0tLQogaW5jbHVkZS9kcm0v
ZHJtX21pcGlfZHNpLmggfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX21pcGlfZHNpLmggYi9pbmNsdWRlL2RybS9kcm1f
bWlwaV9kc2kuaAppbmRleCAxM2NmMmFlNTlmNmMuLjVmMmUzZTZmYjAxMyAxMDA2NDQKLS0tIGEv
aW5jbHVkZS9kcm0vZHJtX21pcGlfZHNpLmgKKysrIGIvaW5jbHVkZS9kcm0vZHJtX21pcGlfZHNp
LmgKQEAgLTEzMSw2ICsxMzEsOCBAQCBzdHJ1Y3QgbWlwaV9kc2lfaG9zdCAqb2ZfZmluZF9taXBp
X2RzaV9ob3N0X2J5X25vZGUoc3RydWN0IGRldmljZV9ub2RlICpub2RlKTsKICNkZWZpbmUgTUlQ
SV9EU0lfQ0xPQ0tfTk9OX0NPTlRJTlVPVVMJQklUKDEwKQogLyogdHJhbnNtaXQgZGF0YSBpbiBs
b3cgcG93ZXIgKi8KICNkZWZpbmUgTUlQSV9EU0lfTU9ERV9MUE0JCUJJVCgxMSkKKy8qIGFsbG93
IGdvaW5nIGludG8gVUxQUyBtb2RlIHdoaWxlIGNvbW1hbmQgbW9kZSBwYW5lbCBpcyBub3QgdXBk
YXRlZCAqLworI2RlZmluZSBNSVBJX0RTSV9NT0RFX1VMUFNfSURMRQkJQklUKDEyKQogCiBlbnVt
IG1pcGlfZHNpX3BpeGVsX2Zvcm1hdCB7CiAJTUlQSV9EU0lfRk1UX1JHQjg4OCwKLS0gCjIuMjQu
MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
