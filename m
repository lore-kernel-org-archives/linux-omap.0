From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC/PATCH] drm/omap: Move DISPC runtime PM handling to omapdrm
Date: Mon, 05 Nov 2018 23:46:35 +0200
Message-ID: <15576120.XDCU3u3Cql@avalon>
References: <20181105151028.4091-1-laurent.pinchart@ideasonboard.com>
 <20181105192314.5565-1-laurent.pinchart@ideasonboard.com>
 <20181105201446.GF56754@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181105201446.GF56754@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

SGkgVG9ueSwKCk9uIE1vbmRheSwgNSBOb3ZlbWJlciAyMDE4IDIyOjE0OjQ2IEVFVCBUb255IExp
bmRncmVuIHdyb3RlOgo+ICogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVh
c29uYm9hcmQuY29tPiBbMTgxMTA1IDE5OjIzXToKPiA+IFRoaXMgcGF0Y2ggYXBwbGllcyBvbiB0
b3Agb2YgdGhlICJbUEFUQ0ggdjIgMC80XSBvbWFwZHJtOiBGaXggcnVudGltZSBQTQo+ID4gaXNz
dWVzIGF0IG1vZHVsZSBsb2FkIGFuZCB1bmxvYWQgdGltZSIgc2VyaWVzLiBJdCBkZW1vbnN0cmF0
ZXMgd2hhdCBJCj4gPiB0aGluayBpcyB0aGUgcHJvcGVyIGxvbmcgdGVybSBmaXggZm9yIHRoZSBp
c3N1ZSBhZGRyZXNzZWQgYnkgcGF0Y2ggNC80Lgo+ID4gRHVlIHRvIGl0cyBuYXR1cmUsIEkgZG9u
J3QgdGhpbmsgdGhpcyBwYXRjaCBzaG91bGQgYmUgYXBwbGllZCBmb3IgdjQuMjAKPiA+IGFzIGl0
IHF1YWxpZmllcyBmb3IgdmVyeSBjYXJlZnVsIHRlc3RpbmcsIGhlbmNlIG15IHByb3Bvc2FsIHRv
IGZpeCB0aGUKPiA+IHJ1bnRpbWUgUE0gcHJvYmxlbSB3aXRoIDQvNCBhbmQgdG8gcXVldWUgdGhp
cyBwYXRjaCBmb3IgdjQuMjEuCj4gCj4gVG8gbWUgdGhpcyBzZWVtcyBsaWtlIGEgbGVzcyByaXNr
eSBmaXggY29tcGFyZWQgdG8gY29uZGl0aW9uYWwKPiBydW50aW1lIFBNIGNhbGxzIGluIHBhdGNo
IDQuIENvbmRpdGlvbmFsIGNhbGxzIHdpdGggdXNlY291bnRzIHNlZW0KPiB0byBhbHdheXMgYnJl
YWsgb25lIHdheSBvciBhbm90aGVyLi4gU28gd291bGQgYmUgbmljZSB0byBnbyB3aXRoCj4gdGhp
cyBvbmUgaWYgcG9zc2libGUuCgpJZiBUb21pIGlzIGZpbmUgd2l0aCB0aGlzLCBhbmQgYWZ0ZXIg
Y2FyZWZ1bCB0ZXN0aW5nLCBJIGhhdmUgbm8gaXNzdWUgd2l0aCAKbWVyZ2luZyB0aGlzIHBhdGNo
IHNxdWFzaGVkIHdpdGggNC80IGZvciA0LjIwLXJjLgoKLS0gClJlZ2FyZHMsCgpMYXVyZW50IFBp
bmNoYXJ0CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
