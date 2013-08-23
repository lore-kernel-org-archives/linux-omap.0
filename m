From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC PATCH 07/14] arm: dts: add omap4430 thermal data
Date: Fri, 23 Aug 2013 19:15:48 -0400
Message-ID: <1377299755-5134-8-git-send-email-eduardo.valentin@ti.com>
References: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, grant.likely@linaro.org, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com
Cc: devicetree@vger.kernel.org, durgadoss.r@intel.com, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Eduardo Valentin <eduardo.valentin@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

VGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSBkdHNpIGVudHJ5IG9uIG9tYXA0NDMwIHRvIGNvbnRhaW4K
dGhlIHRoZXJtYWwgZGF0YS4gVGhpcyBkYXRhIHdpbGwgZW5hYmxlIHRoZSBwYXNzaXZlCmNvb2xp
bmcgd2l0aCBDUFVmcmVxIGNvb2xpbmcgZGV2aWNlIGF0IDEwMEMgYW5kIHRoZQpzeXN0ZW0gd2ls
bCBkbyBhIHRoZXJtYWwgc2h1dGRvd24gYXQgMTI1Qy4KCkNjOiAiQmVub8OudCBDb3Vzc29uIiA8
Yi1jb3Vzc29uQHRpLmNvbT4KQ2M6IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+CkNj
OiBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybS5saW51eC5vcmcudWs+CkNjOiBsaW51eC1vbWFwQHZn
ZXIua2VybmVsLm9yZwpDYzogZGV2aWNldHJlZS1kaXNjdXNzQGxpc3RzLm96bGFicy5vcmcKQ2M6
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpDYzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBFZHVhcmRvIFZhbGVudGluIDxlZHVhcmRvLnZh
bGVudGluQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9vbWFwNDQzeC5kdHNpIHwgNSAr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL29tYXA0NDN4LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9vbWFwNDQzeC5k
dHNpCmluZGV4IGJjZjQ1NWUuLjkxYTNhNWQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L29tYXA0NDN4LmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvb21hcDQ0M3guZHRzaQpAQCAt
MjUsOSArMjUsMTQgQEAKIAkJfTsKIAl9OwogCisJdGhlcm1hbF96b25lc3sKKwkJI2luY2x1ZGUg
Im9tYXA0LWNwdS10aGVybWFsLmR0c2kiCisJfTsKKwogCWJhbmRnYXAgewogCQlyZWcgPSA8MHg0
YTAwMjI2MCAweDQKIAkJICAgICAgIDB4NGEwMDIzMkMgMHg0PjsKIAkJY29tcGF0aWJsZSA9ICJ0
aSxvbWFwNDQzMC1iYW5kZ2FwIjsKKwkJbW9uaXRvcmVkLXpvbmVzID0gPCZjcHVfdGhlcm1hbCAw
PjsKIAl9OwogfTsKLS0gCjEuOC4yLjEuMzQyLmdmYTcyODVkCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
