From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: expand the description of the
 debug facility
Date: Wed, 7 Oct 2015 16:55:01 +0300
Message-ID: <56152435.6050500@ti.com>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <5614CDAE.6070604@ti.com> <20151007075338.GH3982@pengutronix.de>
 <20151007102822.GT23801@atomide.com> <20151007110231.GL3982@pengutronix.de>
 <5614FD01.6090009@ti.com> <20151007134010.GW23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151007134010.GW23801@atomide.com>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

T24gMDcvMTAvMTUgMTY6NDAsIFRvbnkgTGluZGdyZW4gd3JvdGU6Cj4gKiBSb2dlciBRdWFkcm9z
IDxyb2dlcnFAdGkuY29tPiBbMTUxMDA3IDA0OjEyXToKPj4gT24gMDcvMTAvMTUgMTQ6MDIsIFV3
ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOgo+Pj4gSGVsbG8gVG9ueSwKPj4+Cj4+PiBPbiBXZWQsIE9j
dCAwNywgMjAxNSBhdCAwMzo0MToxOUFNIC0wNzAwLCBUb255IExpbmRncmVuIHdyb3RlOgo+Pj4+
ICogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gWzE1
MTAwNyAwMDo1N106Cj4+Pj4+IE9uIFdlZCwgT2N0IDA3LCAyMDE1IGF0IDEwOjQ1OjUwQU0gKzAz
MDAsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6Cj4+Pj4+Pgo+Pj4+Pj4gSG93IGFib3V0IHRoaXMgaW5z
dGVhZD8KPj4+Pj4+Cj4+Pj4+PiBOT1RFOiBBcGFydCBmcm9tIG1hdGNoaW5nIHRoZSByZWdpc3Rl
ciBzZXR1cCB3aXRoIHRoZSBib290bG9hZGVyIHlvdSBhbHNvIG5lZWQgdG8KPj4+Pj4+IG1hdGNo
IHRoZSBHUE1DIEZDTEsgZnJlcXVlbmN5IHVzZWQgYnkgdGhlIGJvb3Rsb2FkZXIgZWxzZSB0aGUg
R1BNQyB0aW1pbmdzCj4+Pj4+PiB3b24ndCBiZSBpZGVudGljYWwgd2l0aCB0aGUgYm9vdGxvYWRl
ciB0aW1pbmdzLgo+Pj4+PiBZZWFoLCBzb3VuZHMgYmV0dGVyLCB0aGFua3MuCj4+Pj4+Cj4+Pj4+
PiBBbHNvIHlvdSBtaWdodCBuZWVkIHRvIGJ1aWxkIHRoaXMgcGF0Y2ggb24gdG9wIG9mCj4+Pj4+
PiBodHRwOi8vYXJ0aWNsZS5nbWFuZS5vcmcvZ21hbmUubGludXgua2VybmVsLzIwNTQ3OTYKPj4+
Pj4gSSB0YWxrZWQgdG8gVG9ueSBhYm91dCB0aGlzIHBhdGNoIHllc3RlcmRheSBvbiBpcmMsIGJ1
dCBJIGRpZG4ndCBmaW5kIGl0Cj4+Pj4+IGluIHRoZSBhcmNoaXZlcyB5ZXQgd2hlbiBJIHNlbnQg
bXkgbWFpbC4KPj4+Pgo+Pj4+IFllcyBzb3JyeSBoZXJlJ3MgYSByZXBvc3Qgd2l0aCB5b3VyIGFu
ZCBSb2dlcidzIGNoYW5nZXMgZm9sZGVkIGluIGFuZAo+Pj4+IGVkaXRlZCBhIGJpdC4gUHJvYmFi
bHkgYmVzdCB0byBrZWVwIHRoZW0gdG9nZXRoZXIgd2l0aCB0aGlzIHBhdGNoLgo+Pj4+Cj4+Pj4g
RG9lcyB0aGUgZm9sbG93aW5nIGxvb2sgT0sgdG8geW91IGd1eXM/Cj4+PiBZZXMsCj4+PiBBY2tl
ZC1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
Pj4KPj4gTG9va3MgZ29vZCB0byBtZSB0b28uCj4gCj4gQXJlIHlvdSBPSyBpZiBJIHVzZSB5b3Vy
IEFja2VkLWJ5IGZyb20gdGhlIHByZXZpb3VzIHZlcnNpb24gb24KPiB0aGlzIHVwZGF0ZWQgdmVy
c2lvbj8KClllcyBwbGVhc2UuCgpjaGVlcnMsCi1yb2dlcgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
