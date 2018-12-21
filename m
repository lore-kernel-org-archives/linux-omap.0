From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH -next] ARM: dts: am437x: replace linux,
 wakeup with wakeup-source property
Date: Fri, 21 Dec 2018 18:12:20 +0000
Message-ID: <20181221181220.6877-1-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-omap@vger.kernel.org

TW9zdCBvZiB0aGUgbGVnYWN5ICJsaW51eCx3YWtldXAiIGJvb2xlYW4gcHJvcGVydHkgaXMgYWxy
ZWFkeSByZXBsYWNlZAp3aXRoICJ3YWtldXAtc291cmNlIi4gSG93ZXZlciBmZXcgb2NjdXJyZW5j
ZXMgb2Ygb2xkIHByb3BlcnR5IGhhcyBwb3BwZWQKdXAgYWdhaW4sIHByb2JhYmx5IGZyb20gdGhl
IHJlbW5hbnRzIGluIGRvd25zdHJlYW0gdHJlZXMuCgpSZXBsYWNlIHRoZSBsZWdhY3kgcHJvcGVy
dGllcyB3aXRoIHRoZSB1bmlmaWVkICJ3YWtldXAtc291cmNlIiBwcm9wZXJ0eQppbnRyb2R1Y2Vk
IGluIHRoZSBjb21taXQgYWVkYTUwMDNkMGI5ICgiSW5wdXQ6IG1hdHJpeF9rZXlwYWQgLSBjaGFu
Z2UKbmFtZSBvZiB3YWtldXAgcHJvcGVydHkgdG8gIndha2V1cC1zb3VyY2UiIikKCkNjOiAiQmVu
b8OudCBDb3Vzc29uIiA8YmNvdXNzb25AYmF5bGlicmUuY29tPgpDYzogVG9ueSBMaW5kZ3JlbiA8
dG9ueUBhdG9taWRlLmNvbT4KQ2M6IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwub3JnClNpZ25lZC1v
ZmYtYnk6IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+Ci0tLQogYXJjaC9hcm0v
Ym9vdC9kdHMvYW00Mzd4LWdwLWV2bS5kdHMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9h
bTQzN3gtZ3AtZXZtLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FtNDM3eC1ncC1ldm0uZHRzCmlu
ZGV4IGY0YTIwY2FkZTgwOC4uNGM2ZWUzN2VhNTczIDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290
L2R0cy9hbTQzN3gtZ3AtZXZtLmR0cworKysgYi9hcmNoL2FybS9ib290L2R0cy9hbTQzN3gtZ3At
ZXZtLmR0cwpAQCAtNzEsNyArNzEsNyBAQAogCQlwaW5jdHJsLTAgPSA8Jm1hdHJpeF9rZXlwYWRf
ZGVmYXVsdD47CiAJCXBpbmN0cmwtMSA9IDwmbWF0cml4X2tleXBhZF9zbGVlcD47CgotCQlsaW51
eCx3YWtldXA7CisJCXdha2V1cC1zb3VyY2U7CgogCQlyb3ctZ3Bpb3MgPSA8JmdwaW8wIDMgR1BJ
T19BQ1RJVkVfSElHSCAvKiBCYW5rMCwgcGluMyAqLwogCQkJCSZncGlvNCAzIEdQSU9fQUNUSVZF
X0hJR0ggLyogQmFuazQsIHBpbjMgKi8KLS0KMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
