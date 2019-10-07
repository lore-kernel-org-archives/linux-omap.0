From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 4/5] drm/panel: tpo-td028ttec1: Fix SPI alias
Date: Mon,  7 Oct 2019 20:08:00 +0300
Message-ID: <20191007170801.27647-5-laurent.pinchart@ideasonboard.com>
References: <20191007170801.27647-1-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191007170801.27647-1-laurent.pinchart@ideasonboard.com>
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
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, thierry.reding@gmail.com, letux-kernel@openphoenux.org, sam@ravnborg.org
List-Id: linux-omap@vger.kernel.org

VGhlIHBhbmVsLXRwby10ZDAyOHR0ZWMxIGRyaXZlciBpbmNvcnJlY3RseSBpbmNsdWRlcyB0aGUg
T0YgdmVuZG9yCnByZWZpeCBpbiBpdHMgU1BJIGFsaWFzLiBGaXggaXQuCgpGaXhlczogNDE1Yjhk
ZDA4NzExICgiZHJtL3BhbmVsOiBBZGQgZHJpdmVyIGZvciB0aGUgVG9wcG9seSBURDAyOFRURUMx
IHBhbmVsIikKUmVwb3J0ZWQtYnk6IEguIE5pa29sYXVzIFNjaGFsbGVyIDxobnNAZ29sZGVsaWNv
LmNvbT4KU2lnbmVkLW9mZi1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBp
ZGVhc29uYm9hcmQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC10cG8tdGQw
Mjh0dGVjMS5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtdHBvLXRk
MDI4dHRlYzEuYyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC10cG8tdGQwMjh0dGVjMS5j
CmluZGV4IGQ3YjJlMzQ2MjZlZi4uZjJiYWZmODI3ZjUwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vcGFuZWwvcGFuZWwtdHBvLXRkMDI4dHRlYzEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
cGFuZWwvcGFuZWwtdHBvLXRkMDI4dHRlYzEuYwpAQCAtMzc1LDggKzM3NSw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHRkMDI4dHRlYzFfb2ZfbWF0Y2hbXSA9IHsKIE1PRFVM
RV9ERVZJQ0VfVEFCTEUob2YsIHRkMDI4dHRlYzFfb2ZfbWF0Y2gpOwogCiBzdGF0aWMgY29uc3Qg
c3RydWN0IHNwaV9kZXZpY2VfaWQgdGQwMjh0dGVjMV9pZHNbXSA9IHsKLQl7ICJ0cG8sdGQwMjh0
dGVjMSIsIDB9LAotCXsgInRvcHBvbHksdGQwMjh0dGVjMSIsIDAgfSwKKwl7ICJ0ZDAyOHR0ZWMx
IiwgMCB9LAogCXsgLyogc2VudGluZWwgKi8gfQogfTsKIAotLSAKUmVnYXJkcywKCkxhdXJlbnQg
UGluY2hhcnQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
