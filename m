From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 7/7] ARM: dts: am335x-boneblack: Use new binding for HDMI
Date: Wed, 27 May 2015 12:23:01 +0300
Message-ID: <24904e4f2d314d73608e33a11d1426145d1a3402.1432718049.git.jsarha@ti.com>
References: <cover.1432718049.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1432718049.git.jsarha@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: rmk+kernel@arm.linux.org.uk, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

VXNlIG5ldyBiaW5kaW5nIGZvciB0aGUgZXh0ZXJuYWwgdGRhMTk5ODggSERNSSBlbmNvZGVyLgoK
U2lnbmVkLW9mZi1ieTogSnlyaSBTYXJoYSA8anNhcmhhQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9i
b290L2R0cy9hbTMzNXgtYm9uZWJsYWNrLmR0cyB8IDIwICsrKysrKysrKysrKysrKy0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9hbTMzNXgtYm9uZWJsYWNrLmR0cyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2FtMzM1eC1ib25lYmxhY2suZHRzCmluZGV4IDVjNDJkMjUuLmVhZGJiYTMgMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1ib25lYmxhY2suZHRzCisrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2FtMzM1eC1ib25lYmxhY2suZHRzCkBAIC02OCwxNiArNjgsMjYgQEAKIAog
JmxjZGMgewogCXN0YXR1cyA9ICJva2F5IjsKKwlwb3J0IHsKKwkJbGNkY18wOiBlbmRwb2ludEAw
IHsKKwkJCXJlbW90ZS1lbmRwb2ludCA9IDwmaGRtaV8wPjsKKwkJfTsKKwl9OwogfTsKIAotLyB7
Ci0JaGRtaSB7Ci0JCWNvbXBhdGlibGUgPSAidGksdGlsY2RjLHNsYXZlIjsKLQkJaTJjID0gPCZp
MmMwPjsKKyZpMmMwIHsKKwl0ZGExOTk4OCB7CisJCWNvbXBhdGlibGUgPSAibnhwLHRkYTk5OHgi
OworCQlyZWcgPSA8MHg3MD47CiAJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJvZmYiOwog
CQlwaW5jdHJsLTAgPSA8Jm54cF9oZG1pX2JvbmVsdF9waW5zPjsKIAkJcGluY3RybC0xID0gPCZu
eHBfaGRtaV9ib25lbHRfb2ZmX3BpbnM+OwotCQlzdGF0dXMgPSAib2theSI7CisKKwkJcG9ydCB7
CisJCQloZG1pXzA6IGVuZHBvaW50QDAgeworCQkJCXJlbW90ZS1lbmRwb2ludCA9IDwmbGNkY18w
PjsKKwkJCX07CisJCX07CiAJfTsKIH07CiAKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
