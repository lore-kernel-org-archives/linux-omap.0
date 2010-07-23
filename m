From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 06/11] ARM: omap: move omapfb_reserve_sdram() to .init.text
Date: Fri, 23 Jul 2010 21:58:29 +0200
Message-ID: <1279915120-4373-6-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

b21hcGZiX3Jlc2VydmVfc2RyYW0oKSBpcyBvbmx5IGNhbGxlZCBieSBvbWFwMV9tYXBfY29tbW9u
X2lvKCkgYW5kCl9vbWFwMl9tYXBfY29tbW9uX2lvKCkgdGhhdCBib3RoIGxpdmUgaW4gLmluaXQu
dGV4dC4gIFNvIHRoaXMgaXMgc2F2ZQpmb3Igb21hcGZiX3Jlc2VydmVfc2RyYW0oKSwgdG9vLgoK
U2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRy
b25peC5kZT4KLS0tCiBhcmNoL2FybS9wbGF0LW9tYXAvZmIuYyB8ICAgIDQgKystLQogMSBmaWxl
cyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vcGxhdC1vbWFwL2ZiLmMgYi9hcmNoL2FybS9wbGF0LW9tYXAvZmIuYwppbmRleCBl
OGEzOTBkLi40ZGYyMTBmIDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW9tYXAvZmIuYworKysg
Yi9hcmNoL2FybS9wbGF0LW9tYXAvZmIuYwpAQCAtMzU5LDcgKzM1OSw3IEBAIHN0YXRpYyBpbnQg
X19pbml0IG9tYXBfaW5pdF9mYih2b2lkKQogCiBhcmNoX2luaXRjYWxsKG9tYXBfaW5pdF9mYik7
CiAKLXZvaWQgb21hcGZiX3Jlc2VydmVfc2RyYW0odm9pZCkge30KK3ZvaWQgX19pbml0IG9tYXBm
Yl9yZXNlcnZlX3NkcmFtKHZvaWQpIHt9CiB1bnNpZ25lZCBsb25nIG9tYXBmYl9yZXNlcnZlX3Ny
YW0odW5zaWduZWQgbG9uZyBzcmFtX3BzdGFydCwKIAkJCQkgIHVuc2lnbmVkIGxvbmcgc3JhbV92
c3RhcnQsCiAJCQkJICB1bnNpZ25lZCBsb25nIHNyYW1fc2l6ZSwKQEAgLTM3NSw3ICszNzUsNyBA
QCB2b2lkIG9tYXBmYl9zZXRfcGxhdGZvcm1fZGF0YShzdHJ1Y3Qgb21hcGZiX3BsYXRmb3JtX2Rh
dGEgKmRhdGEpCiB7CiB9CiAKLXZvaWQgb21hcGZiX3Jlc2VydmVfc2RyYW0odm9pZCkge30KK3Zv
aWQgX19pbml0IG9tYXBmYl9yZXNlcnZlX3NkcmFtKHZvaWQpIHt9CiB1bnNpZ25lZCBsb25nIG9t
YXBmYl9yZXNlcnZlX3NyYW0odW5zaWduZWQgbG9uZyBzcmFtX3BzdGFydCwKIAkJCQkgIHVuc2ln
bmVkIGxvbmcgc3JhbV92c3RhcnQsCiAJCQkJICB1bnNpZ25lZCBsb25nIHNyYW1fc2l6ZSwKLS0g
CjEuNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
