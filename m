From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] memory: omap-gpmc: expand the description of the debug
 facility
Date: Tue,  6 Oct 2015 22:07:50 +0200
Message-ID: <1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

TW9zdCByZWdpc3RlciB2YWx1ZXMgZm9yIHRoZSBjaGlwIHNlbGVjdCBzZXR1cCBkZXBlbmQgb24g
dGhlIGZyZXF1ZW5jeQpvZiB0aGUgZmNrIGNsb2NrLgpTbyBhZGQgYSBoaW50IHRoYXQgdGhlIHZh
bHVlcyBzZXR1cCBieSB0aGUgYm9vdGxvYWRlciBtaWdodCBkaWZmZXIgZnJvbQp0aGUgcmlnaHQg
c2V0dXAgZm9yIExpbnV4IGlmIHRoZSBib290bG9hZGVyIHVzZXMgYSBkaWZmZXJlbnQgZnJlcXVl
bmN5LgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0Bw
ZW5ndXRyb25peC5kZT4KLS0tCiBkcml2ZXJzL21lbW9yeS9LY29uZmlnIHwgMyArKysKIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS9L
Y29uZmlnIGIvZHJpdmVycy9tZW1vcnkvS2NvbmZpZwppbmRleCBjNmE2NDRiMjJhZjQuLjE0MTRk
ZDUzYmU1NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZW1vcnkvS2NvbmZpZworKysgYi9kcml2ZXJz
L21lbW9yeS9LY29uZmlnCkBAIC02NCw2ICs2NCw5IEBAIGNvbmZpZyBPTUFQX0dQTUNfREVCVUcK
IAkgIEVuYWJsZXMgdmVyYm9zZSBkZWJ1Z2dpbmcgbW9zdGx5IHRvIGRlY29kZSB0aGUgYm9vdGxv
YWRlciBwcm92aWRlZAogCSAgdGltaW5ncy4gRW5hYmxlIHRoaXMgZHVyaW5nIGRldmVsb3BtZW50
IHRvIGNvbmZpZ3VyZSBkZXZpY2VzCiAJICBjb25uZWN0ZWQgdG8gdGhlIEdQTUMgYnVzLgorCSAg
Tm90ZSB0aGF0IHlvdSBjYW5ub3QganVzdCB0d2VhayB5b3VyIGRldmljZSB0cmVlIHVudGlsIHRo
ZSByZWdpc3RlcnMKKwkgIHNldHVwIGJ5IGxpbnV4IG1hdGNoIHdoYXQgdGhlIGJvb3Rsb2FkZXIg
ZGlkIGJlY2F1c2UgdGhhdCBvbmUgbWlnaHQKKwkgIHVzZSBhIGRpZmZlcmVudCBmY2sgZnJlcXVl
bmN5IGluZmx1ZW5jaW5nIG1vc3QgcmVnaXN0ZXIgc2V0dGluZ3MuCiAKIGNvbmZpZyBNVkVCVV9E
RVZCVVMKIAlib29sICJNYXJ2ZWxsIEVCVSBEZXZpY2UgQnVzIENvbnRyb2xsZXIiCi0tIAoyLjYu
MAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
