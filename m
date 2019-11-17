From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [RFCv1 38/42] drm/omap: panel-dsi-cm: do not power on/off twice
Date: Sun, 17 Nov 2019 03:40:24 +0100
Message-ID: <20191117024028.2233-39-sebastian.reichel@collabora.com>
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

TWFrZSBzdXJlLCB0aGF0IHdlIG9ubHkgcG93ZXIgb24vb2ZmIHRoZSBkZXZpY2Ugb25jZS4KClNp
Z25lZC1vZmYtYnk6IFNlYmFzdGlhbiBSZWljaGVsIDxzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJv
cmEuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL2Rpc3BsYXlzL3BhbmVsLWRzaS1j
bS5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vb21hcGRybS9kaXNwbGF5cy9wYW5lbC1kc2ktY20uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9vbWFwZHJtL2Rpc3BsYXlzL3BhbmVsLWRzaS1jbS5jCmluZGV4IDkwMTMy
ZDFkMWY1ZC4uN2Y2YjExMjk4NjJhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vb21hcGRy
bS9kaXNwbGF5cy9wYW5lbC1kc2ktY20uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vb21hcGRybS9k
aXNwbGF5cy9wYW5lbC1kc2ktY20uYwpAQCAtMjkwLDYgKzI5MCw5IEBAIHN0YXRpYyBpbnQgZHNp
Y21fcG93ZXJfb24oc3RydWN0IHBhbmVsX2Rydl9kYXRhICpkZGF0YSkKIAl1OCBpZDEsIGlkMiwg
aWQzOwogCWludCByOwogCisJaWYgKGRkYXRhLT5lbmFibGVkKQorCQlyZXR1cm4gMDsKKwogCXIg
PSByZWd1bGF0b3JfYnVsa19lbmFibGUoRENTX1JFR1VMQVRPUl9TVVBQTFlfTlVNLCBkZGF0YS0+
c3VwcGxpZXMpOwogCWlmIChyKSB7CiAJCWRldl9lcnIoJmRkYXRhLT5kc2ktPmRldiwgImZhaWxl
ZCB0byBlbmFibGUgc3VwcGxpZXM6ICVkXG4iLCByKTsKQEAgLTM1NCw2ICszNTcsOSBAQCBzdGF0
aWMgaW50IGRzaWNtX3Bvd2VyX29mZihzdHJ1Y3QgcGFuZWxfZHJ2X2RhdGEgKmRkYXRhKQogewog
CWludCByOwogCisJaWYgKCFkZGF0YS0+ZW5hYmxlZCkKKwkJcmV0dXJuIDA7CisKIAlkZGF0YS0+
ZW5hYmxlZCA9IDA7CiAKIAlyID0gbWlwaV9kc2lfZGNzX3NldF9kaXNwbGF5X29mZihkZGF0YS0+
ZHNpKTsKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVs
