From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix missing variable declaration
Date: Thu, 24 Aug 2017 15:18:43 +0300
Message-ID: <02160c46-d0c1-dc49-2f4f-01d46d9f7723@ti.com>
References: <20170823132841.642239-1-arnd@arndb.de>
 <12875092.dy1RW0XmqV@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <12875092.dy1RW0XmqV@avalon>
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
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

77u/CgpUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4
MCBIZWxzaW5raS4gWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9E
b21pY2lsZTogSGVsc2lua2kKCk9uIDIzLzA4LzE3IDE2OjUzLCBMYXVyZW50IFBpbmNoYXJ0IHdy
b3RlOgo+IEhpIEFybmQsCj4gCj4gT24gV2VkbmVzZGF5LCAyMyBBdWd1c3QgMjAxNyAxNjoyODox
OSBFRVNUIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4+IFRoZSBmdW5jdGlvbiB0aGF0IHdhcyBhZGRl
ZCBkb2Vzbid0IGFjdHVhbGx5IGJ1aWxkOgo+Pgo+PiBhcmNoL2FybS9tYWNoLW9tYXAyL2Rpc3Bs
YXkuYzogSW4gZnVuY3Rpb24gJ29tYXBkc3NfaW5pdF9mYmRldic6Cj4+IGFyY2gvYXJtL21hY2gt
b21hcDIvZGlzcGxheS5jOjE4NDoyOiBlcnJvcjogJ3InIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBp
bgo+PiB0aGlzIGZ1bmN0aW9uKQo+Pgo+PiBUaGlzIGFkZHMgYSBkZWNsYXJhdGlvbiBmb3IgJ3In
IHRvIGZpeCBpdC4KPj4KPj4gRml4ZXM6IDVjZTc4MzAyNWM4MiAoIkFSTTogT01BUDIrOiBEb24n
dCByZWdpc3RlciBvbWFwZHNzIGRldmljZSBmb3IKPj4gb21hcGRybSIpCj4+IFNpZ25lZC1vZmYt
Ynk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+Cj4gCj4gTG9va3MgbGlrZSBJIGhhdmVu
J3QgdGVzdGVkIHRoZSBwYXRjaCB3aXRoIENPTkZJR19GQl9PTUFQMiBlbmFibGVkIGFmdGVyIHRo
ZSAKPiBsYXN0IHJlYmFzZS4gSSdtIHZlcnkgc29ycnkgYWJvdXQgdGhhdCA6LSgKPiAKPiBSZXZp
ZXdlZC1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQu
Y29tPgo+IAo+IFRvbWksIEkgYXNzdW1lIHlvdSB3aWxsIHBpY2sgdGhpcyB1cCBhbmQgc2VudCBp
dCB0byBEYXZlIGZvciB2NC4xNC1yYzEuCgpZZXAsIEknbGwgcGljayBpdCB1cC4gSSBjb3VsZCBz
d2VhciBJIHRlc3RlZCBvbWFwZmIgYnVpbGQsIGJ1dC4uLgpPYnZpb3VzbHkgbm90LgoKIFRvbWkK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
