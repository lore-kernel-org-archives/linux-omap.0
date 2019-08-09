From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 11/22] clocksource: ti-dmtimer: avoid using mach/hardware.h
Date: Fri, 9 Aug 2019 09:01:50 +0200
Message-ID: <ba446856-0fa1-d06d-9e74-18ed9d630376@linaro.org>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-12-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190808212234.2213262-12-arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Thomas Gleixner <tglx@linutronix.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

T24gMDgvMDgvMjAxOSAyMzoyMiwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBBcyBhIHByZXBhcmF0
aW9uIGZvciBmdXR1cmUgb21hcDEgbXVsdGlwbGF0Zm9ybSBzdXBwb3J0LCBzdG9wCj4gdXNpbmcg
bWFjaC9oYXJkd2FyZS5oIGFuZCBpbnN0ZWFkIGluY2x1ZGUgdGhlIG9tYXAxLWlvLmgKPiBmb3Ig
bG93LWxldmVsIHJlZ2lzdGVyIGFjY2VzcyB0byBNT0RfQ09ORl9DVFJMXzEuCj4gCj4gU2lnbmVk
LW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPiAtLS0KCkRvIHlvdSB3YW50
IG1lIHRvIGFwcGx5IGl0IHRocm91Z2ggbWUgdHJlZT8KCgotLSAKIDxodHRwOi8vd3d3LmxpbmFy
by5vcmcvPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MK
CkZvbGxvdyBMaW5hcm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBG
YWNlYm9vayB8CjxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0
dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+IEJsb2cKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
