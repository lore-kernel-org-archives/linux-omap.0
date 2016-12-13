From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH/RFC 1/7] drm: omapdrm: Add OMAP revision to omapdss platform
 data
Date: Wed, 14 Dec 2016 01:38:20 +0200
Message-ID: <1481672306-22564-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1481672306-22564-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1481672306-22564-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

VGhlIHJldmlzaW9uIGlzIHBhc3NlZCBmcm9tIHBsYXRmb3JtIGNvZGUgdG8gdGhlIG9tYXBkcm0g
ZHJpdmVyIHRocm91Z2gKdGhlIG9tYXBkcm0gcGxhdGZvcm0gZGV2aWNlJ3MgcGxhdGZvcm0gZGF0
YS4gVGhpcyBpcyB0aGUgbGFzdCByZWFzb24gdG8KY3JlYXRlIGEgdmlydHVhbCBvbWFwZHJtIHBs
YXRmb3JtIGRldmljZSB0aGF0IHdlIGhhdmUgb3RoZXJ3aXNlIG5vIG5lZWQKZm9yLiBCeSBwYXNz
aW5nIHRoZSByZXZpc2lvbiB0aHJvdWdoIHRoZSBvbWFwZHNzIHBsYXRmb3JtIGRhdGEgd2Ugd2ls
bApiZSBhYmxlIHRvIHJlbW90ZSB0aGUgb21hcGRybSBkZXZpY2UuCgpTaWduZWQtb2ZmLWJ5OiBM
YXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+Ci0tLQog
aW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL29tYXBkc3MuaCB8IDEgKwogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9k
YXRhL29tYXBkc3MuaCBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9vbWFwZHNzLmgKaW5k
ZXggNjc5MTc3OTI5MDQ1Li5lNzFiYjFkMWI3YmEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgv
cGxhdGZvcm1fZGF0YS9vbWFwZHNzLmgKKysrIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRh
L29tYXBkc3MuaApAQCAtMzIsNiArMzIsNyBAQCBzdHJ1Y3Qgb21hcF9kc3NfYm9hcmRfaW5mbyB7
CiAJdm9pZCAoKmRzaV9kaXNhYmxlX3BhZHMpKGludCBkc2lfaWQsIHVuc2lnbmVkIGludCBsYW5l
X21hc2spOwogCWludCAoKnNldF9taW5fYnVzX3RwdXQpKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5z
aWduZWQgbG9uZyByKTsKIAllbnVtIG9tYXBkc3NfdmVyc2lvbiB2ZXJzaW9uOworCXUzMiBvbWFw
cmV2OwogfTsKIAogI2VuZGlmIC8qIF9fT01BUERTU19QREFUQV9IICovCi0tIApSZWdhcmRzLAoK
TGF1cmVudCBQaW5jaGFydAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
