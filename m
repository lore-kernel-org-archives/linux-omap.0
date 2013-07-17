From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RESEND PATCH V1 4/9] arm: dts: flag omap4430 with needs-cooling for
 cpu node
Date: Wed, 17 Jul 2013 11:17:23 -0400
Message-ID: <1374074248-31690-5-git-send-email-eduardo.valentin@ti.com>
References: <1374074248-31690-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374074248-31690-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree-discuss@lists.ozlabs.org
Cc: wni@nvidia.com, Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: linux-omap@vger.kernel.org

T01BUDQ0MzAgZGV2aWNlcyBjYW4gcmVhY2ggaGlnaCB0ZW1wZXJhdHVyZXMgYW5kIHRodXMKbmVl
ZHMgdG8gaGF2ZSBjcHVmcmVxLWNvb2xpbmcgb24gc3lzdGVtcyBydW5uaW5nIG9uIGl0LgoKVGhp
cyBwYXRjaCBhZGRzIHRoZSBmbGFnIHNvIHRoYXQgY3B1ZnJlcS1jcHUwIGRyaXZlcgpsb2FkcyB0
aGUgY29vbGluZyBkZXZpY2UgdG8gdXNlIGNwdWZyZXEgb24gT01BUDQ0MzAuCgpDYzogIkJlbm/D
rnQgQ291c3NvbiIgPGItY291c3NvbkB0aS5jb20+CkNjOiBUb255IExpbmRncmVuIDx0b255QGF0
b21pZGUuY29tPgpDYzogUnVzc2VsbCBLaW5nIDxsaW51eEBhcm0ubGludXgub3JnLnVrPgpDYzog
bGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGRldmljZXRyZWUtZGlzY3Vzc0BsaXN0cy5v
emxhYnMub3JnCkNjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogRWR1YXJkbyBWYWxlbnRp
biA8ZWR1YXJkby52YWxlbnRpbkB0aS5jb20+Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMvb21hcDQ0
M3guZHRzaSB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvb21hcDQ0M3guZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL29t
YXA0NDN4LmR0c2kKaW5kZXggYmNmNDU1ZS4uNGE0ZGNjMyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvb21hcDQ0M3guZHRzaQorKysgYi9hcmNoL2FybS9ib290L2R0cy9vbWFwNDQzeC5k
dHNpCkBAIC0yMiw2ICsyMiw3IEBACiAJCQkJMTAwODAwMCAxMzc1MDAwCiAJCQk+OwogCQkJY2xv
Y2stbGF0ZW5jeSA9IDwzMDAwMDA+OyAvKiBGcm9tIGxlZ2FjeSBkcml2ZXIgKi8KKwkJCW5lZWRz
LWNvb2xpbmc7IC8qIG1ha2Ugc3VyZSB3ZSBoYXZlIGNwdWZyZXEtY29vbGluZyAqLwogCQl9Owog
CX07CiAKLS0gCjEuOC4yLjEuMzQyLmdmYTcyODVkCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
