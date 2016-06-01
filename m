From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 16/27] omapdss: omap-panel-data.h: Remove connector_type
 from atv pdata
Date: Wed, 1 Jun 2016 11:35:38 +0300
Message-ID: <20160601083549.10549-17-peter.ujfalusi@ti.com>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160601083549.10549-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, jsarha@ti.com, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com
List-Id: linux-omap@vger.kernel.org

VGhlIGRyaXZlciBvbmx5IHN1cHBvcnRzIGNvbXBvc2l0ZSBjb25uZWN0aW9uIHdoZW4gYm9vdGVk
IGluIGxlZ2FjeSBtb2RlCnNvIHRoZSBvbWFwX2Rzc192ZW5jX3R5cGUgY2FuIGJlIGRyb3BwZWQg
ZnJvbSB0aGUgcGRhdGEuCkF0IHRoZSBzYW1lIHRpbWUgdGhlIHZpZGVvL29tYXBkc3MuaCBpbmNs
dWRlIGNhbiBiZSByZW1vdmVkIGFzIGl0IGlzIG5vCmxvbmdlciBuZWVkZWQuCgpTaWduZWQtb2Zm
LWJ5OiBQZXRlciBVamZhbHVzaSA8cGV0ZXIudWpmYWx1c2lAdGkuY29tPgotLS0KIGluY2x1ZGUv
dmlkZW8vb21hcC1wYW5lbC1kYXRhLmggfCAzIC0tLQogMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS92aWRlby9vbWFwLXBhbmVsLWRhdGEuaCBiL2lu
Y2x1ZGUvdmlkZW8vb21hcC1wYW5lbC1kYXRhLmgKaW5kZXggN2I0ZmFkZjgyY2Q1Li5lNzAwM2Vl
NmUwNjMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdmlkZW8vb21hcC1wYW5lbC1kYXRhLmgKKysrIGIv
aW5jbHVkZS92aWRlby9vbWFwLXBhbmVsLWRhdGEuaApAQCAtMjcsMjEgKzI3LDE4IEBACiAjaWZu
ZGVmIF9fT01BUF9QQU5FTF9EQVRBX0gKICNkZWZpbmUgX19PTUFQX1BBTkVMX0RBVEFfSAogCi0j
aW5jbHVkZSA8dmlkZW8vb21hcGRzcy5oPgogI2luY2x1ZGUgPHZpZGVvL2Rpc3BsYXlfdGltaW5n
Lmg+CiAKIC8qKgogICogY29ubmVjdG9yX2F0diBwbGF0Zm9ybSBkYXRhCiAgKiBAbmFtZTogbmFt
ZSBmb3IgdGhpcyBkaXNwbGF5IGVudGl0eQogICogQHNvdXJjZTogbmFtZSBvZiB0aGUgZGlzcGxh
eSBlbnRpdHkgdXNlZCBhcyBhIHZpZGVvIHNvdXJjZQotICogQGNvbm5lY3Rvcl90eXBlOiBjb21w
b3NpdGUvc3ZpZGVvCiAgKiBAaW52ZXJ0X3BvbGFyaXR5OiBpbnZlcnQgc2lnbmFsIHBvbGFyaXR5
CiAgKi8KIHN0cnVjdCBjb25uZWN0b3JfYXR2X3BsYXRmb3JtX2RhdGEgewogCWNvbnN0IGNoYXIg
Km5hbWU7CiAJY29uc3QgY2hhciAqc291cmNlOwogCi0JZW51bSBvbWFwX2Rzc192ZW5jX3R5cGUg
Y29ubmVjdG9yX3R5cGU7CiAJYm9vbCBpbnZlcnRfcG9sYXJpdHk7CiB9OwogCi0tIAoyLjguMwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
