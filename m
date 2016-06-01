From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 15/27] ARM: OMAP: rx51-video: Do not set TV connector_type
Date: Wed, 1 Jun 2016 11:35:37 +0300
Message-ID: <20160601083549.10549-16-peter.ujfalusi@ti.com>
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

SW4gbGVnYWN5IG1vZGUgb25seSBjb21wb3NpdGUgdHlwZSBpcyBzdXBwb3J0ZWQgYnkgb21hcGRz
cyBzbyB0aGVyZSBpcyBubwpuZWVkIHRvIHNwZWNpZnkgdGhlIGNvbm5lY3Rvcl90eXBlLgoKU2ln
bmVkLW9mZi1ieTogUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4KLS0tCiBh
cmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLXJ4NTEtdmlkZW8uYyB8IDEgLQogMSBmaWxlIGNoYW5n
ZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJk
LXJ4NTEtdmlkZW8uYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtcng1MS12aWRlby5jCmlu
ZGV4IDljZmViYzVjNzQ1NS4uYjc2Zjg0MjQ1YWQ5IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNo
LW9tYXAyL2JvYXJkLXJ4NTEtdmlkZW8uYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJk
LXJ4NTEtdmlkZW8uYwpAQCAtMzIsNyArMzIsNiBAQAogc3RhdGljIHN0cnVjdCBjb25uZWN0b3Jf
YXR2X3BsYXRmb3JtX2RhdGEgcng1MV90dl9wZGF0YSA9IHsKIAkubmFtZSA9ICJ0diIsCiAJLnNv
dXJjZSA9ICJ2ZW5jLjAiLAotCS5jb25uZWN0b3JfdHlwZSA9IE9NQVBfRFNTX1ZFTkNfVFlQRV9D
T01QT1NJVEUsCiAJLmludmVydF9wb2xhcml0eSA9IGZhbHNlLAogfTsKIAotLSAKMi44LjMKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
