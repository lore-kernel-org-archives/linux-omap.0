From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 09/16] arm: dts: add omap4430 thermal data
Date: Sun, 15 Sep 2013 18:02:36 -0400
Message-ID: <1379282563-14650-10-git-send-email-eduardo.valentin@ti.com>
References: <1379282563-14650-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1379282563-14650-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com
Cc: devicetree@vger.kernel.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, grant.likely@linaro.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
cmNoL2FybS9ib290L2R0cy9vbWFwNDQzeC5kdHNpCmluZGV4IGJjZjQ1NWUuLjY5ODdkZjkgMTAw
NjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXA0NDN4LmR0c2kKKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvb21hcDQ0M3guZHRzaQpAQCAtMTIsNyArMTIsNyBAQAogCiAvIHsKIAljcHVzIHsK
LQkJY3B1QDAgeworCQljcHUwOiBjcHVAMCB7CiAJCQkvKiBPTUFQNDQzeCB2YXJpYW50cyBPUFA1
MC1PUFBOVCAqLwogCQkJb3BlcmF0aW5nLXBvaW50cyA9IDwKIAkJCQkvKiBrSHogICAgdVYgKi8K
QEAgLTI1LDkgKzI1LDE1IEBACiAJCX07CiAJfTsKIAotCWJhbmRnYXAgeworCXRoZXJtYWwtem9u
ZXN7CisJCSNpbmNsdWRlICJvbWFwNC1jcHUtdGhlcm1hbC5kdHNpIgorCX07CisKKwliYW5kZ2Fw
OiBiYW5kZ2FwIHsKIAkJcmVnID0gPDB4NGEwMDIyNjAgMHg0CiAJCSAgICAgICAweDRhMDAyMzJD
IDB4ND47CiAJCWNvbXBhdGlibGUgPSAidGksb21hcDQ0MzAtYmFuZGdhcCI7CisKKwkJI3NlbnNv
ci1jZWxscyA9IDwxPjsKIAl9OwogfTsKLS0gCjEuOC4yLjEuMzQyLmdmYTcyODVkCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
