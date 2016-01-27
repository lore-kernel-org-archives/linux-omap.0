From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3: Include missing bandgap data for
 ti-soc-thermal driver
Date: Wed, 27 Jan 2016 10:24:48 -0800
Message-ID: <20160127182447.GR19432@atomide.com>
References: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
 <20160121094718.GV7192@pali> <20160121171500.GI19432@atomide.com>
 <20160127100447.GI25796@pali> <20160127160945.GI19432@atomide.com>
 <20160127181950.GB17794@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160127181950.GB17794@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

KiBTZWJhc3RpYW4gUmVpY2hlbCA8c3JlQGtlcm5lbC5vcmc+IFsxNjAxMjcgMTA6MjBdOgo+IEhp
LAo+IAo+IE9uIFdlZCwgSmFuIDI3LCAyMDE2IGF0IDA4OjA5OjQ2QU0gLTA4MDAsIFRvbnkgTGlu
ZGdyZW4gd3JvdGU6Cj4gPiAqIFBhbGkgUm9ow6FyIDxwYWxpLnJvaGFyQGdtYWlsLmNvbT4gWzE2
MDEyNyAwMjowNV06Cj4gPiA+IE9uIFRodXJzZGF5IDIxIEphbnVhcnkgMjAxNiAwOToxNTowMSBU
b255IExpbmRncmVuIHdyb3RlOgo+ID4gPiA+ICogUGFsaSBSb2jDoXIgPHBhbGkucm9oYXJAZ21h
aWwuY29tPiBbMTYwMTIxIDAxOjQ4XToKPiA+ID4gPiA+IE9uIFNhdHVyZGF5IDI2IERlY2VtYmVy
IDIwMTUgMDA6MzI6MjUgUGFsaSBSb2jDoXIgd3JvdGU6Cj4gPiA+ID4gPiA+IERyaXZlciBmb3Ig
b21hcDMgd2l0aCBkb2N1bWVudGF0aW9uIGlzIHRoZXJlIHNpbmNlIHY0LjQtcmMxLgo+ID4gPiA+
IC4uLgo+ID4gPiA+IAo+ID4gPiA+ID4gUElORyEgV2hvIGNhbiB0YWtlIHRoaXMgcGF0Y2g/Cj4g
PiA+ID4gCj4gPiA+ID4gU291bmRzIGxpa2UgL21lLCBidXQgYWZ0ZXIgLXJjMSB3aGVuIGFueSBw
b3NzaWJsZSByZWdyZXNzaW9ucwo+ID4gPiA+IGFyZSBvdXQgb2YgdGhlIHdheSA6KQo+ID4gPiAK
PiA+ID4gR3JlYXQhIEp1c3QgdG8gbm90ZSB0aGF0IDQuNS1yYzEgaXMgb3V0Lgo+ID4gPiAKPiA+
ID4gSSBqdXN0IGRvIG5vdCB3YW50IHRvIHNlZSB0aGlzIHBhdGNoIGxvc3QuLi4KPiA+IAo+ID4g
U28gaXMgdGhpcyBjcml0aWNhbCB0byBoYXZlIGFzIGEgZml4IHNpbmNlIGl0J3MgdGhlcm1hbCBy
ZWxhdGVkPwo+IAo+IEFjY29yZGluZyB0byBzb21lYm9keSBmcm9tIFRJLCB3aG8gcHJldmlvdXNs
eSB0b29rIHBhcnQgaW4gdGhlIHBhdGNoCj4gZGlzY3Vzc2lvbiwgdGhlIHRoZXJtYWwgc2Vuc29y
cyBvZiBvbWFwMyBhcmUgdG8gaW1wcmVjaXNlIHRvIGJlIHVzZWQKPiBmb3IgdGhlcm1hbCBkZWNp
c2lvbnMuIFRoZSBkcml2ZXIgImp1c3QiIGluZm9ybXMgdXNlcnNwYWNlIGFib3V0IHRoZQo+IHRl
bXBlcmF0dXJlcy4KCk9LIGFwcGx5aW5nIGludG8gb21hcC1mb3ItdjQuNi9kdCB0aGVuIHRoYW5r
cy4KClRvbnkKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
