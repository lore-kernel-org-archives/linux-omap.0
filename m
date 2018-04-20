From: Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCHv3 3/8] drm/omap: add support for manually updated displays
Date: Fri, 20 Apr 2018 11:19:35 +0100
Message-ID: <CAPj87rPeBim9NyBmMuDKKEwx2apLhdnZyEB9_sfbVQpUHA95+Q@mail.gmail.com>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
 <20180330171822.25896-4-sebastian.reichel@collabora.co.uk>
 <a078d8c3-9e65-cc7b-737a-cbd5cf141f95@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <a078d8c3-9e65-cc7b-737a-cbd5cf141f95@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, kernel@collabora.com, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

SGkgVG9taSwKCk9uIDIwIEFwcmlsIDIwMTggYXQgMDg6MDksIFRvbWkgVmFsa2VpbmVuIDx0b21p
LnZhbGtlaW5lbkB0aS5jb20+IHdyb3RlOgo+IEl0J3MgYWN0dWFsbHkgbm90IHF1aXRlIGNsZWFy
IHRvIG1lIGhvdyBtYW51YWwgdXBkYXRlIGRpc3BsYXlzIHdvcmsgd2l0aAo+IERSTS4uLgo+Cj4g
QXMgZmFyIGFzIEkgc2VlLCB3ZSBoYXZlIGVzc2VudGlhbGx5IHR3byBjYXNlczogMSkgc2luZ2xl
IGJ1ZmZlcmluZywKPiB3aGVyZSB0aGUgdXNlcnNwYWNlIG11c3Qgc2V0IGFuIGFyZWEgaW4gdGhl
IGZiIGRpcnR5LCB3aGljaCB0aGVuCj4gdHJpZ2dlcnMgdGhlIHVwZGF0ZSwgMikgbXVsdGkgYnVm
ZmVyaW5nLCB3aGljaCBkb2Vzbid0IG5lZWQgZmIgZGlydHksCj4gYnV0IGp1c3QgYSBwYWdlIGZs
aXAgd2hpY2ggdHJpZ2dlcnMgdGhlIHVwZGF0ZS4KPgo+IEluIHRoZSAyKSBjYXNlICh3aGljaCBJ
IHRoaW5rIGlzIHRoZSBvcHRpbWFsIGNhc2Ugd2hpY2ggYWxsIHRoZSBtb2Rlcm4KPiBhcHBzIHNo
b3VsZCB1c2UpLCB0aGVyZSdzIG5vIG5lZWQgZm9yIGRlbGF5ZWQgd29yayBvciBhbnkgd29yaywg
YW5kIHRoZQo+IGNvZGUgZmxvdyBzaG91bGQgYmUgdmVyeSBzaW1pbGFyIHRvIHRoZSBhdXRvLXVw
ZGF0ZSBtb2RlbC4KCkNvcnJlY3QuIFRoZXJlJ3MgYmVlbiB0YWxrIChhbmQgSSB0aGluayBwYXRj
aGVzPykgb2YgYWRkaW5nIGEKcGVyLXBsYW5lIGRpcnR5IHByb3BlcnR5LCBzbyB1c2Vyc3BhY2Ug
Y2FuIGFzIGFuIG9wdGltaXNhdGlvbiBpbmZvcm0KdGhlIGtlcm5lbCBvZiB0aGUgYXJlYSBjaGFu
Z2VkIGJldHdlZW4gZnJhbWVzLiBCdXQgc2hvcnQgb2YgdGhhdCwgYQpwYWdlZmxpcCBuZWVkcyB0
byB0cmlnZ2VyIGEgZnVsbC1wbGFuZSB1cGRhdGUsIHdpdGggbm8gZGlydHlmYgpyZXF1aXJlZC4K
CkNoZWVycywKRGFuaWVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAo=
