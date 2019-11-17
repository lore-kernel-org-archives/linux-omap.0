From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [RFCv1 39/42] drm/omap: dsi: return proper error code from
 dsi_update_all()
Date: Sun, 17 Nov 2019 03:40:25 +0100
Message-ID: <20191117024028.2233-40-sebastian.reichel@collabora.com>
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

U2lnbmVkLW9mZi1ieTogU2ViYXN0aWFuIFJlaWNoZWwgPHNlYmFzdGlhbi5yZWljaGVsQGNvbGxh
Ym9yYS5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vZHNzL2RzaS5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vZHNzL2RzaS5jIGIvZHJpdmVycy9ncHUvZHJtL29t
YXBkcm0vZHNzL2RzaS5jCmluZGV4IDFiNTdmNTE2NjE4YS4uYmM5NmY3NGYxNzQwIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vb21hcGRybS9kc3MvZHNpLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL29tYXBkcm0vZHNzL2RzaS5jCkBAIC0zOTg3LDcgKzM5ODcsNyBAQCBzdGF0aWMgaW50IGRz
aV91cGRhdGVfYWxsKHN0cnVjdCBvbWFwX2Rzc19kZXZpY2UgKmRzc2RldikKIAkJCXJldHVybiBy
OwogCX0KIAotCXJldHVybiAwOworCXJldHVybiByOwogfQogCiAvKiBEaXNwbGF5IGZ1bmNzICov
Ci0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bA==
