From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFCv1 33/42] drm/omap: dsi: use atomic helper for dirtyfb
Date: Tue, 19 Nov 2019 07:06:43 -0800
Message-ID: <20191119150643.GI35479@atomide.com>
References: <20191117024028.2233-1-sebastian.reichel@collabora.com>
 <20191117024028.2233-34-sebastian.reichel@collabora.com>
 <20191118230535.GG35479@atomide.com>
 <e91c7fc9-18e0-cc22-4617-127fe9be2c1b@ti.com>
 <20191119143243.GH35479@atomide.com>
 <edff7dfa-8b95-48ac-59e0-14553f3c8d39@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <edff7dfa-8b95-48ac-59e0-14553f3c8d39@ti.com>
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
Cc: kernel@collabora.com, "H. Nikolaus Schaller" <hns@goldelico.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

KiBUb21pIFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPiBbMTkxMTE5IDE0OjU0XToK
PiBPbiAxOS8xMS8yMDE5IDE2OjMyLCBUb255IExpbmRncmVuIHdyb3RlOgo+IAo+ID4gPiBXZSBo
YXZlbid0IGhhZCBvbWFwX2dlbV9vcF9maW5pc2goKSBpbiB0aGUga2VybmVsIGZvciBzb21lIHll
YXJzIG5vdy4uLgo+ID4gPiAKPiA+ID4gU2hvdWxkbid0IGEgbm9ybWFsIHBhZ2UgZmxpcCwgb3Ig
aWYgZG9pbmcgc2luZ2xlLWJ1ZmZlcmluZywgdXNpbmcgdGhlCj4gPiA+IGRpcnR5ZmIgaW9jdGws
IGRvIHRoZSBqb2I/Cj4gPiAKPiA+IEl0IGRvZXMgbm90IHNlZW0gdG8gaGFwcGVuIHdpdGggdGhl
IG9sZCBwdnItb21hcDQgcmVsYXRlZCBwYXRjaGVzCj4gPiBhbmQgd2hhdGV2ZXIgZ2xlcyByZWxh
dGVkIHRlc3RzIGF0IGxlYXN0LiBJZiB5b3UgaGF2ZSBzb21lIGlkZWEKPiA+IHdoZXJlIGl0IHNo
b3VsZCBnZXQgY2FsbGVkIEkgY2FuIHRha2UgYSBsb29rIGF0IHNvbWUgcG9pbnQuCj4gCj4gVGhl
IHVzZXJzcGFjZSBhcHBzIG5lZWQgdG8gZG8gdGhpcy4gSWYgdGhleSdyZSB1c2luZyBzaW5nbGUt
YnVmZmVyaW5nLCB0aGVuCj4gdXNpbmcgdGhlIGRpcnR5ZmIgaW9jdGwgc2hvdWxkIGRvIHRoZSB0
cmljaywgYWZ0ZXIgdGhlIFNHWCBoYXMgZmluaXNoZWQKPiBkcmF3aW5nLgoKU291bmRzIGxpa2Ug
dGhhdCdzIG5vdCBoYXBwZW5pbmcuCgpCdXQgd2h5IHdvdWxkIHRoZSB1c2Vyc3BhY2UgYXBwIG5l
ZWQgdG8ga25vdyB0aGlzIG1pZ2h0IGJlIG5lZWRlZCBmb3IKYSBEU0kgY29tbWFuZCBtb2RlIGRp
c3BsYXkgYW5kIHRoYXQgaXQncyBub3QgbmVlZGVkIGZvciBIRE1JPwoKPiBJdCdzIHByb2JhYmx5
IHNvbWV3aGF0IGRpZmZpY3VsdCBpZiBFR0wgaXMgY29udHJvbGxpbmcgdGhlIGRpc3BsYXksIGFz
LAo+IGFmYWlrLCBTR1ggRUdMIGlzIGNsb3NlZCBzb3VyY2UsIGFuZCB0aGF0J3MgcHJvYmFibHkg
d2hlcmUgaXQgc2hvdWxkIGJlCj4gZG9uZS4KPiAKPiBCdXQgYWRkaW5nIGJhY2sgdGhlIGhhY2t5
IG9tYXAgZ2VtIHN5bmMgc3R1ZmYsIGFuZCB0aGVuIHNvbWVob3cgZ3Vlc3NpbmcKPiBmcm9tIHRo
ZSBzeW5jIGZpbmlzaCB0aGF0IHNvbWUgZGlzcGxheSBuZWVkcyB0byBiZSB1cGRhdGVkLi4uIEl0
IGp1c3QgZG9lcwo+IG5vdCBzb3VuZCByaWdodCB0byBtZS4KClJpZ2h0IGl0J3MgdWdseS4gU3Rp
bGwgc291bmRzIGxpa2Ugd2UgbmVlZCBzb21ldGhpbmcgaW4gdGhlIGtlcm5lbAp0aGF0IGtub3dz
ICJ0aGlzIGlzIGEgRFNJIGNvbW1hbmQgbW9kZSBMQ0QgYW5kIG5lZWRzIHRvIGJlIHVwZGF0ZWQi
LgoKUmVnYXJkcywKClRvbnkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVs
