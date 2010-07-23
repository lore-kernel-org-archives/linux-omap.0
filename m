From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 04/11] ARM: omap: move omap_init_fb to .init.text
Date: Fri, 23 Jul 2010 21:58:27 +0200
Message-ID: <1279915120-4373-4-git-send-email-u.kleine-koenig@pengutronix.de>
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

b21hcF9pbml0X2ZiKCkgaXMgb25seSBjYWxsZWQgYXMgYXJjaF9pbml0Y2FsbCBhbmQgc28gY2Fu
IGxpdmUgaW4KLmluaXQudGV4dC4KClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1
LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Ci0tLQogYXJjaC9hcm0vcGxhdC1vbWFwL2Zi
LmMgfCAgICA0ICsrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9mYi5jIGIvYXJjaC9hcm0v
cGxhdC1vbWFwL2ZiLmMKaW5kZXggZDNlZWE0Zi4uZThhMzkwZCAxMDA2NDQKLS0tIGEvYXJjaC9h
cm0vcGxhdC1vbWFwL2ZiLmMKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2ZiLmMKQEAgLTMwNyw3
ICszMDcsNyBAQCB2b2lkIG9tYXBmYl9zZXRfY3RybF9wbGF0Zm9ybV9kYXRhKHZvaWQgKmRhdGEp
CiAJb21hcGZiX2NvbmZpZy5jdHJsX3BsYXRmb3JtX2RhdGEgPSBkYXRhOwogfQogCi1zdGF0aWMg
aW5saW5lIGludCBvbWFwX2luaXRfZmIodm9pZCkKK3N0YXRpYyBpbnQgX19pbml0IG9tYXBfaW5p
dF9mYih2b2lkKQogewogCWNvbnN0IHN0cnVjdCBvbWFwX2xjZF9jb25maWcgKmNvbmY7CiAKQEAg
LTM1Miw3ICszNTIsNyBAQCB2b2lkIG9tYXBmYl9zZXRfcGxhdGZvcm1fZGF0YShzdHJ1Y3Qgb21h
cGZiX3BsYXRmb3JtX2RhdGEgKmRhdGEpCiAJb21hcGZiX2NvbmZpZyA9ICpkYXRhOwogfQogCi1z
dGF0aWMgaW5saW5lIGludCBvbWFwX2luaXRfZmIodm9pZCkKK3N0YXRpYyBpbnQgX19pbml0IG9t
YXBfaW5pdF9mYih2b2lkKQogewogCXJldHVybiBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXIoJm9t
YXBfZmJfZGV2aWNlKTsKIH0KLS0gCjEuNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
