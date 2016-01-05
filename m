From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Tue, 5 Jan 2016 09:49:47 +0100
Message-ID: <20160105084947.GG22661@pali>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
 <568AC0F9.2010304@gmail.com> <20160105041356.GE12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160105041356.GE12777@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

T24gTW9uZGF5IDA0IEphbnVhcnkgMjAxNiAyMDoxMzo1NiBUb255IExpbmRncmVuIHdyb3RlOgo+
ICogSXZheWxvIERpbWl0cm92IDxpdm8uZy5kaW1pdHJvdi43NUBnbWFpbC5jb20+IFsxNjAxMDQg
MTA6NTldOgo+ID4gSGksCj4gPiAKPiA+IE9uICA0LjAxLjIwMTYgMTk6NDAsIFRvbnkgTGluZGdy
ZW4gd3JvdGU6Cj4gPiA+Pk9uIE1vbmRheSAwNCBKYW51YXJ5IDIwMTYgMTg6MDI6MDYgVG9ueSBM
aW5kZ3JlbiB3cm90ZToKPiA+ID4+Pj4gPkNhcmUgdG8gYm9vdCB3aXRoIENPTkZJR19PTUFQX0dQ
TUNfREVCVUc9eSBhbmQgcG9zdCB0aGUgZ3BtYyByZWxhdGVkCj4gPiA+Pj4+ID5kbWVzZyBvdXRw
dXQ/Cj4gPiAKPiA+IEhlcmUgaXQgaXMsIGluY2x1ZGluZyB0aGUgcHJlLWdwbWMgbG9nLCBrZWVw
IGluIG1pbmQgdGhpcyBpcyB3aXRoIHJlc3RvcmVkCj4gPiBIV01PRF9JTklUX05PX1JFU0VUIGZs
YWcgc28gcm9vdGZzIGlzIGZ1bmN0aW9uYWwgYW5kIEkgY2FuIGdldCBkbWVzZyBvdXRwdXQKPiA+
IGZyb20gdGhlIHN5c2xvZy4gRG9uJ3Qga25vdyBpZiBpdCBpcyBoZWxwZnVsIDopLiBBbHNvLCB0
aGlzIGRldmljZSBoYXMKPiA+IE51bW9ueXggb25lbmFuZCAoSFcgcmV2LiAyMjA0KSwgdW5saWtl
IG1vc3Qgb2YgdGhlIG90aGVycyB3aGljaCBoYXZlIFNhbXN1bmcKPiA+IG9uZW5hbmQgKEhXIHJl
di4gMjEwMSBldGMpLCBubyBpZGVhIGlmIGl0IGlzIHJlbGV2YW50Lgo+IAo+IFRoYW5rcy4gSSBn
b3QgdGhlIHByb2JsZW0gcmVwcm9kdWNlZCBoZXJlIHRvby4KPiAKPiBbICAgIDEuOTE1NTU3XSBn
cG1jIGNzMCBhZnRlciBncG1jX2NzX3NldF90aW1pbmdzOgo+IFsgICAgMS45MjA0MTBdIGNzMCBH
UE1DX0NTX0NPTkZJRzE6IDB4ZmIwMDEyMDEKPiAKPiBMb29rcyBsaWtlIGluIHRoZSBmYWlsaW5n
IGNhc2UgdGhlIGNsb2NrIHJhdGVzIGFyZSBub3QgcHJvcGVybHkKPiBjYWxjdWxhdGVkIGluIEdQ
TUMgYW5kIEdQTUNGQ0xLRElWSURFUiBpcyBzZXQgd3JvbmcgaW4KPiBHUE1DX0NTX0NPTkZJRzEu
IE5lZWQgdG8gbG9vayBhdCBpdCBtb3JlIHRvIGZpZ3VyZSBvdXQgd2hhdCdzIHRoZQo+IGJlc3Qg
d2F5IHRvIGZpeCB0aGlzLgo+IAo+IFJlZ2FyZHMsCj4gCj4gVG9ueQoKSG0uLi4gTWF5YmUgdGhp
cyBwcm9ibGVtIGlzIGluIFUtQm9vdCB0b28/CgotLSAKUGFsaSBSb2jDoXIKcGFsaS5yb2hhckBn
bWFpbC5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
