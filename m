From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Subject: Re: [PATCH] ARM: remove duplicate 'const' annotations'
Date: Fri, 12 May 2017 06:42:21 +0200
Message-ID: <m3vap6hej6.fsf@t19.piap.pl>
References: <20170511115059.2997141-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170511115059.2997141-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Thu, 11 May 2017 13:50:16 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <paul@pwsan.com>, Florian Fainelli <f.fainelli@gmail.com>, Rajendra Nayak <rnayak@codeaurora.org>, Scott Branden <sbranden@broadcom.com>, Nicolas Pitre <nico@linaro.org>, Tony Lindgren <tony@atomide.com>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, arm@kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Viresh Kumar <vireshk@kernel.org>, Olof Johansson <olof@lixom.net>, bcm-kernel-feedback-list@broadcom.com, Wenyou Yang <wenyou.yang@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

QXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gd3JpdGVzOgoKPiBnY2MtNyB3YXJucyBhYm91
dCBzb21lIGRlY2xhcmF0aW9ucyB0aGF0IGFyZSBtb3JlICdjb25zdCcgdGhhbiBuZWNlc3Nhcnk6
Cgo+IC0tLSBhL2FyY2gvYXJtL21hY2gtY25zM3h4eC9jb3JlLmMKPiArKysgYi9hcmNoL2FybS9t
YWNoLWNuczN4eHgvY29yZS5jCj4gQEAgLTM0Niw3ICszNDYsNyBAQCBzdGF0aWMgc3RydWN0IHVz
Yl9vaGNpX3BkYXRhIGNuczN4eHhfdXNiX29oY2lfcGRhdGEgPSB7Cj4gIAkucG93ZXJfb2ZmCT0g
Y3NuM3h4eF91c2JfcG93ZXJfb2ZmLAo+ICB9Owo+ICAKPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZfYXV4ZGF0YSBjb25zdCBjbnMzeHh4X2F1eGRhdGFbXSBfX2luaXRjb25zdCA9IHsKPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZfYXV4ZGF0YSBjbnMzeHh4X2F1eGRhdGFbXSBfX2lu
aXRjb25zdCA9IHsKPiAgCXsgImludGVsLHVzYi1laGNpIiwgQ05TM1hYWF9VU0JfQkFTRSwgImVo
Y2ktcGxhdGZvcm0iLCAmY25zM3h4eF91c2JfZWhjaV9wZGF0YSB9LAo+ICAJeyAiaW50ZWwsdXNi
LW9oY2kiLCBDTlMzWFhYX1VTQl9PSENJX0JBU0UsICJvaGNpLXBsYXRmb3JtIiwgJmNuczN4eHhf
dXNiX29oY2lfcGRhdGEgfSwKPiAgCXsgImNhdml1bSxjbnMzNDIwLWFoY2kiLCBDTlMzWFhYX1NB
VEEyX0JBU0UsICJhaGNpIiwgTlVMTCB9LAoKQWNrZWQtYnk6IEtyenlzenRvZiBIYcWCYXNhIDxr
aGFsYXNhQHBpYXAucGw+Ci0tIApLcnp5c3p0b2YgSGFsYXNhCgpJbmR1c3RyaWFsIFJlc2VhcmNo
IEluc3RpdHV0ZSBmb3IgQXV0b21hdGlvbiBhbmQgTWVhc3VyZW1lbnRzIFBJQVAKQWwuIEplcm96
b2xpbXNraWUgMjAyLCAwMi00ODYgV2Fyc2F3LCBQb2xhbmQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
