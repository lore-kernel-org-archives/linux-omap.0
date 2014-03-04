From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/5] drivers: bus: omap_l3: Convert to use
 devm_request_and_ioremap()
Date: Tue, 4 Mar 2014 11:42:46 +0200
Message-ID: <5315A016.3090504@ti.com>
References: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
 <1393923710-10377-3-git-send-email-peter.ujfalusi@ti.com>
 <1393924359.866301359@f148.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393924359.866301359@f148.i.mail.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

T24gMDMvMDQvMjAxNCAxMToxMiBBTSwgQWxleGFuZGVyIFNoaXlhbiB3cm90ZToKPiDQktGC0L7R
gNC90LjQuiwgIDQg0LzQsNGA0YLQsCAyMDE0LCAxMTowMSArMDI6MDAg0L7RgiBQZXRlciBVamZh
bHVzaSA8cGV0ZXIudWpmYWx1c2lAdGkuY29tPjoKPj4gV2UgY2FuIHRoZW4gcmVtb3ZlIHRoZSBp
b3VubWFwKCkgY2FsbHMgZnJvbSBwcm9iZSBhbmQgcmVtb3ZlLgo+PiBTaW5jZSB0aGUgZHJpdmVy
IHJlcXVlc3RzIHRoZSByZXNvdXJjZXMgdmlhIGluZGV4IHdlIGNhbiBkbyB0aGUgbWVtIHJlc291
cmNlCj4+IHJlcXVlc3Qgd2l0aGluIGEgZm9yIGxvb3AuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFBl
dGVyIFVqZmFsdXNpIDxwZXRlci51amZhbHVzaUB0aS5jb20+Cj4+IFJldmlld2VkLWJ5OiBTYW50
b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJAdGk+Cj4+IC0tLQo+IAo+PiArCS8qIEdl
dCBtZW0gcmVzb3VyY2VzICovCj4+ICsJZm9yIChpID0gMDsgaSA8IDM7IGkrKykgewo+PiArCQlz
dHJ1Y3QgcmVzb3VyY2UJKnJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LAo+PiArCQkJ
CQkJCSAgICAgSU9SRVNPVVJDRV9NRU0sIGkpOwo+PiArCQlpZiAoIXJlcykgewo+PiArCQkJZGV2
X2VycigmcGRldi0+ZGV2LCAiY291bGRuJ3QgZmluZCByZXNvdXJjZSAlZFxuIiwgaSk7Cj4+ICsJ
CQlyZXR1cm4gLUVOT0RFVjsKPj4gKwkJfQo+IAo+IE5vIG5lZWQgdG8gY2hlY2sgInJlcyIuIGRl
dm1fcmVxdWVzdF9hbmRfaW9yZW1hcCgpIGRvIGFsbCBmb3IgdXMuCgpUcnVlLgoKLS0gClDDqXRl
cgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
