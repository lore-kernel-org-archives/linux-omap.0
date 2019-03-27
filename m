From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 0/3] simplify idle gpio handling for omaps
Date: Wed, 27 Mar 2019 14:29:52 +0100
Message-ID: <CAMpxmJXHMXmG7Og8acjyT_=WgQW9obPU0q=o5qnnka64ee055Q@mail.gmail.com>
References: <20190325224318.15076-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190325224318.15076-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-gpio <linux-gpio@vger.kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

cG9uLiwgMjUgbWFyIDIwMTkgbyAyMzo0MyBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29t
PiBuYXBpc2HFgihhKToKPgo+IEhpIGFsbCwKPgo+IEJhc2VkIG9uIHNvbWUgY29tbWVudHMgZnJv
bSBHcnlnb3JpaSBJIG5vdGljZWQgdGhhdCBwYXJ0cyBvZiBvbGQgMjR4eAo+IGVycmF0YSAxLjEw
MSBoYW5kbGluZyBoYXMgYmVjb21lIHBhcnQgb2YgdGhlIEdQSU8gaWRsZSBoYW5kbGluZyBvdmVy
Cj4gdGhlIHllYXJzLiBIZXJlIGFyZSBmZXcgcGF0Y2hlcyB0byBjbGFyaWZ5IGFuZCBzaW1wbGlm
eSB0aGUgaGFuZGxpbmcKPiBhIGJpdC4KPgo+IFJlZ2FyZHMsCj4KPiBUb255Cj4KPgo+IFRvbnkg
TGluZGdyZW4gKDMpOgo+ICAgZ3BpbzogZ3Bpby1vbWFwOiBsaW1pdCBlcnJhdGEgMS4xMDEgaGFu
ZGxpbmcgdG8gd2t1cCBkb21haW4gZ3Bpb3Mgb25seQo+ICAgZ3BpbzogZ3Bpby1vbWFwOiBhbHdh
eXMgc2NhbiBmb3IgdHJpZ2dlcmVkIG5vbi13YWtldXAgY2FwYWJsZQo+ICAgICBpbnRlcnJ1cHRz
Cj4gICBncGlvOiBncGlvLW9tYXA6IGFkZCBjaGVjayBmb3Igb2ZmIHdha2UgY2FwYWJsZSBncGlv
cwo+Cj4gIGRyaXZlcnMvZ3Bpby9ncGlvLW9tYXAuYyB8IDYxICsrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyks
IDI4IGRlbGV0aW9ucygtKQo+Cj4gLS0KPiAyLjIxLjAKCkFsbCB0aHJlZSBhcHBsaWVkLgoKQmFy
dAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
