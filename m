From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 08/11] ARM: omap: move get_fbmem_region() to .init.text
Date: Fri, 23 Jul 2010 21:58:31 +0200
Message-ID: <1279915120-4373-8-git-send-email-u.kleine-koenig@pengutronix.de>
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

Z2V0X2ZibWVtX3JlZ2lvbigpIGlzIG9ubHkgY2FsbGVkIGJ5IG9tYXBmYl9yZXNlcnZlX3NkcmFt
KCkgYW5kCm9tYXBmYl9yZXNlcnZlX3NyYW0oKSB0aGF0IGJvdGggbGl2ZSBpbiAuaW5pdC50ZXh0
LiAgU28gZ2V0X2ZibWVtX3JlZ2lvbgpjYW4gZ28gdGhlcmUsIHRvby4KClNpZ25lZC1vZmYtYnk6
IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Ci0tLQog
YXJjaC9hcm0vcGxhdC1vbWFwL2ZiLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9t
YXAvZmIuYyBiL2FyY2gvYXJtL3BsYXQtb21hcC9mYi5jCmluZGV4IDRjMGFlNGQuLmUwNWUzMjAg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQtb21hcC9mYi5jCisrKyBiL2FyY2gvYXJtL3BsYXQt
b21hcC9mYi5jCkBAIC05NCw3ICs5NCw3IEBAIHN0YXRpYyBpbnQgZmJtZW1fcmVnaW9uX3Jlc2Vy
dmVkKHVuc2lnbmVkIGxvbmcgc3RhcnQsIHNpemVfdCBzaXplKQogICogR2V0IHRoZSByZWdpb25f
aWR4YHRoIHJlZ2lvbiBmcm9tIGJvYXJkIGNvbmZpZy9BVEFHIGFuZCBjb252ZXJ0IGl0IHRvCiAg
KiBvdXIgaW50ZXJuYWwgZm9ybWF0LgogICovCi1zdGF0aWMgaW50IGdldF9mYm1lbV9yZWdpb24o
aW50IHJlZ2lvbl9pZHgsIHN0cnVjdCBvbWFwZmJfbWVtX3JlZ2lvbiAqcmcpCitzdGF0aWMgaW50
IF9faW5pdCBnZXRfZmJtZW1fcmVnaW9uKGludCByZWdpb25faWR4LCBzdHJ1Y3Qgb21hcGZiX21l
bV9yZWdpb24gKnJnKQogewogCWNvbnN0IHN0cnVjdCBvbWFwX2ZibWVtX2NvbmZpZwkqY29uZjsK
IAl1MzIJCQkJcGFkZHI7Ci0tIAoxLjcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
