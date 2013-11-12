From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv5 10/20] arm: dts: add omap4430 thermal data
Date: Tue, 12 Nov 2013 15:46:12 -0400
Message-ID: <1384285582-16933-11-git-send-email-eduardo.valentin@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com
Cc: devicetree@vger.kernel.org, wni@nvidia.com, durgadoss.r@intel.com, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, grant.likely@linaro.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

VGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSBkdHNpIGVudHJ5IG9uIG9tYXA0NDMwIHRvIGNvbnRhaW4K
dGhlIHRoZXJtYWwgZGF0YS4gVGhpcyBkYXRhIHdpbGwgZW5hYmxlIHRoZSBwYXNzaXZlCmNvb2xp
bmcgd2l0aCBDUFVmcmVxIGNvb2xpbmcgZGV2aWNlIGF0IDEwMEMgYW5kIHRoZQpzeXN0ZW0gd2ls
bCBkbyBhIHRoZXJtYWwgc2h1dGRvd24gYXQgMTI1Qy4KCkNjOiAiQmVub8OudCBDb3Vzc29uIiA8
YmNvdXNzb25AYmF5bGlicmUuY29tPgpDYzogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNv
bT4KQ2M6IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtLmxpbnV4Lm9yZy51az4KQ2M6IGxpbnV4LW9t
YXBAdmdlci5rZXJuZWwub3JnCkNjOiBkZXZpY2V0cmVlLWRpc2N1c3NAbGlzdHMub3psYWJzLm9y
ZwpDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCkNjOiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEVkdWFyZG8gVmFsZW50aW4gPGVkdWFy
ZG8udmFsZW50aW5AdGkuY29tPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL29tYXA0NDN4LmR0c2kg
fCAxMCArKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXA0NDN4LmR0c2kgYi9h
cmNoL2FybS9ib290L2R0cy9vbWFwNDQzeC5kdHNpCmluZGV4IGJjZjQ1NWUuLmU5Yzk3ZDYgMTAw
NjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXA0NDN4LmR0c2kKKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvb21hcDQ0M3guZHRzaQpAQCAtMTIsNyArMTIsNyBAQAogCiAvIHsKIAljcHVzIHsK
LQkJY3B1QDAgeworCQljcHUwOiBjcHVAMCB7CiAJCQkvKiBPTUFQNDQzeCB2YXJpYW50cyBPUFA1
MC1PUFBOVCAqLwogCQkJb3BlcmF0aW5nLXBvaW50cyA9IDwKIAkJCQkvKiBrSHogICAgdVYgKi8K
QEAgLTI1LDkgKzI1LDE1IEBACiAJCX07CiAJfTsKIAotCWJhbmRnYXAgeworCXRoZXJtYWwtem9u
ZXN7CisJCSNpbmNsdWRlICJvbWFwNC1jcHUtdGhlcm1hbC5kdHNpIgorCX07CisKKwliYW5kZ2Fw
OiBiYW5kZ2FwIHsKIAkJcmVnID0gPDB4NGEwMDIyNjAgMHg0CiAJCSAgICAgICAweDRhMDAyMzJD
IDB4ND47CiAJCWNvbXBhdGlibGUgPSAidGksb21hcDQ0MzAtYmFuZGdhcCI7CisKKwkJI3RoZXJt
YWwtc2Vuc29yLWNlbGxzID0gPDA+OwogCX07CiB9OwotLSAKMS44LjIuMS4zNDIuZ2ZhNzI4NWQK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
