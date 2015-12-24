From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 1/2] ARM: ATAGS: move save_atags() to include/asm
 arch/arm/include/asm/setup.h
Date: Thu, 24 Dec 2015 21:02:41 +0200
Message-ID: <567C4151.2090003@gmail.com>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
 <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1450975076-7411-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201512241848.17946@pali> <20151224185319.GT2793@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151224185319.GT2793@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: nicolas.pitre@linaro.org, linux@arm.linux.org.uk, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

CgpPbiAyNC4xMi4yMDE1IDIwOjUzLCBUb255IExpbmRncmVuIHdyb3RlOgo+ICogUGFsaSBSb2jD
oXIgPHBhbGkucm9oYXJAZ21haWwuY29tPiBbMTUxMjI0IDA5OjQ4XToKPj4gT24gVGh1cnNkYXkg
MjQgRGVjZW1iZXIgMjAxNSAxNzozNzo1NSBJdmF5bG8gRGltaXRyb3Ygd3JvdGU6Cj4+PiBTbyBp
dCBjYW4gYmUgdXNlZCBieSBjb2RlIG91dHNpZGUgYXJjaC9hcm0va2VybmVsLy4gRml4IHNhdmVf
YXRhZ3MoKQo+Pj4gZGVjbGFyYXRpb24gdG8gbWF0Y2ggaXRzIGRlZmluaXRpb24gd2hpbGUgYXQg
aXQuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSXZheWxvIERpbWl0cm92IDxpdm8uZy5kaW1pdHJv
di43NUBnbWFpbC5jb20+Cj4+Cj4+IFRlc3RlZC1ieTogUGFsaSBSb2jDoXIgPHBhbGkucm9oYXJA
Z21haWwuY29tPgo+Cj4gTmljZSwgcGxlYXNlIHVwbG9hZCBib3RoIHRvIFJ1c3NlbGwncyBwYXRj
aCBzeXN0ZW0gYWZ0ZXIgbm8KPiBtb3JlIGNvbW1lbnRzOgo+Cj4gQWNrZWQtYnk6IFRvbnkgTGlu
ZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+Cj4KCkhpIFRvbnksCgpDb3VsZCB5b3UgZWxhYm9yYXRl
IG9uIHRoYXQgcGF0Y2ggc3lzdGVtPyBXaGVyZSBpdCBpcyBhbmQgZG8gSSBuZWVkIHNvbWUgCnNw
ZWNpYWwgYWNjb3VudC9hY2Nlc3M/CgpSZWdhcmRzLApJdm8KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
