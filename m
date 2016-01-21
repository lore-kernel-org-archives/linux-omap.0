From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: n900: Include adp1653 device
Date: Thu, 21 Jan 2016 10:12:41 +0100
Message-ID: <20160121091241.GS7192@pali>
References: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

T24gU2F0dXJkYXkgMjYgRGVjZW1iZXIgMjAxNSAwMDo0MDoxMiBQYWxpIFJvaMOhciB3cm90ZToK
PiBUaGlzIHBhdGNoIGFkZHMgYWRwMTY1MyBkZXZpY2UgaW50byBuOTAwIERUIHN0cnVjdHVyZS4g
RFQgc3VwcG9ydCBpbgo+IGFkcDE2NTMgZHJpdmVyIGlzIHRoZXJlIHNpbmNlIHY0LjItcmMxIHZl
cnNpb24uCj4gCj4gU2lnbmVkLW9mZi1ieTogUGFsaSBSb2jDoXIgPHBhbGkucm9oYXJAZ21haWwu
Y29tPgo+IC0tLQo+ICBhcmNoL2FybS9ib290L2R0cy9vbWFwMy1uOTAwLmR0cyB8ICAgMTUgKysr
KysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspCj4gCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXAzLW45MDAuZHRzIGIvYXJjaC9hcm0vYm9v
dC9kdHMvb21hcDMtbjkwMC5kdHMKPiBpbmRleCA1ZjVlMGYzLi5iYTkzNjQyIDEwMDY0NAo+IC0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXAzLW45MDAuZHRzCj4gKysrIGIvYXJjaC9hcm0vYm9v
dC9kdHMvb21hcDMtbjkwMC5kdHMKPiBAQCAtNTIyLDYgKzUyMiwyMSBAQAo+ICAJCWFtc3Rhb3Ms
Y292ZXItY29tcC1nYWluID0gPDE2PjsKPiAgCX07Cj4gIAo+ICsJYWRwMTY1MzogbGVkLWNvbnRy
b2xsZXJAMzAgewo+ICsJCWNvbXBhdGlibGUgPSAiYWRpLGFkcDE2NTMiOwo+ICsJCXJlZyA9IDww
eDMwPjsKPiArCQllbmFibGUtZ3Bpb3MgPSA8JmdwaW8zIDI0IEdQSU9fQUNUSVZFX0hJR0g+OyAv
KiA4OCAqLwo+ICsKPiArCQlmbGFzaCB7Cj4gKwkJCWZsYXNoLXRpbWVvdXQtdXMgPSA8NTAwMDAw
PjsKPiArCQkJZmxhc2gtbWF4LW1pY3JvYW1wID0gPDMyMDAwMD47Cj4gKwkJCWxlZC1tYXgtbWlj
cm9hbXAgPSA8NTAwMDA+Owo+ICsJCX07Cj4gKwkJaW5kaWNhdG9yIHsKPiArCQkJbGVkLW1heC1t
aWNyb2FtcCA9IDwxNzUwMD47Cj4gKwkJfTsKPiArCX07Cj4gKwo+ICAJbHA1NTIzOiBscDU1MjNA
MzIgewo+ICAJCWNvbXBhdGlibGUgPSAibmF0aW9uYWwsbHA1NTIzIjsKPiAgCQlyZWcgPSA8MHgz
Mj47CgpQSU5HLCB3aG8gY2FuIHRha2UgdGhpcyBwYXRjaD8KCkkgc3RpbGwgZG8gbm90IHNlZSBp
dCBpbiBsaW51cyB0cmVlIG5vciBpbiBvdGhlcnMgbGlrZSBhcm0tc29jLi4uCgotLSAKUGFsaSBS
b2jDoXIKcGFsaS5yb2hhckBnbWFpbC5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
