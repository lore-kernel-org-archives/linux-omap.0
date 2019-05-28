From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv6 0/4] omapdrm: DSI command mode panel support
Date: Tue, 28 May 2019 13:32:40 +0300
Message-ID: <c2eaee25-a0d3-2632-fdea-3a81ac7085af@ti.com>
References: <20190523200756.25314-1-sebastian.reichel@collabora.com>
 <60c45d23-de2f-d94a-c3d7-146a2bee538f@ti.com>
 <20190527112122.GJ5447@atomide.com>
 <e507c415-38de-86fe-9265-4b0aed0d7224@ti.com>
 <20190528093952.GM5447@atomide.com>
 <14c6c702-844b-756d-2d97-44e8f5a169df@ti.com>
 <20190528101847.GN5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190528101847.GN5447@atomide.com>
Content-Language: en-US
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
Cc: kernel@collabora.com, "H. Nikolaus Schaller" <hns@goldelico.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Pavel Machek <pavel@ucw.cz>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gMjgvMDUvMjAxOSAxMzoxOCwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKCj4+IFRoaXMgY2hhbmdl
IGxldHMgbWUgYm9vdC4gSSBkb24ndCBrbm93IHRoYXQncyB0aGUgY29ycmVjdCBwbGFjZSwgdGhv
dWdoOgo+Pgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYW01NzI4LmR0c2kgYi9h
cmNoL2FybS9ib290L2R0cy9hbTU3MjguZHRzaQo+PiBpbmRleCA4MmU1NDI3ZWY2YTkuLmM3Nzhm
OWE4NmIzYSAxMDA2NDQKPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYW01NzI4LmR0c2kKPj4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYW01NzI4LmR0c2kKPj4gQEAgLTMxLDMgKzMxLDcgQEAK
Pj4gJmF0bF90bSB7Cj4+ICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsKPj4gfTsKPj4gKwo+
PiArJnRpbWVyMTIgewo+PiArICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4+ICt9Owo+IAo+
IE9LIHdlIHNob3VsZCBkaXNhYmxlIGl0IGF0IHRoZSB0YXJnZXQtbW9kdWxlIGxldmVsIHRob3Vn
aC4gSW50ZXJlc3RpbmcKPiB0aGF0IHJlYWRpbmcgdGhlIHJldmlzaW9uIHJlZ2lzdGVyIHdvcmtz
IHdpdGggdGhlIGFib3ZlLCBvciBtYXliZSB5b3UKPiBzdGlsbCBnZXQgc29tZSB3YXJuaW5nPwoK
SSBkb24ndCBzZWUgYW55dGhpbmcgb2RkIGluIHRoZSBib290IGxvZyB3aXRoIHRoZSBhYm92ZSBj
aGFuZ2UuIEF0IGxlYXN0IApubyBrZXJuZWwgV0FSTnMsIG5vciBhbnl0aGluZyB3aXRoIGdyZXBw
aW5nICJ0aW1lciIsICJlcnIiLCBvciAid2FybiIuCgpJIGp1c3QgdmVyaWZpZWQgd2l0aCBjbGVh
biA1LjItcmMyLCB0aGF0IGl0IGRvZXNuJ3QgYm9vdCwgYW5kIHdpdGggdGhlIAphYm92ZSBjaGFu
Z2UsIGJvb3RzLgoKPj4gTXkgYm9hcmQgaXMgeDE1IHJldiBBMywgYXR0YWNoZWQgdG8gQU01IEVW
TS4gSSd2ZSBhbHNvIGF0dGFjaGVkIG15IGtlcm5lbAo+PiBjb25maWcuCj4gCj4gU3RyYW5nZSB0
aGF0IHRoaXMgaXMgbm90IGFmZmVjdGluZyBvdGhlciB4MTU/IEkgdGhpbmsgdGltZXIxMiB3b3Vs
ZAo+IGJlIGJsb2NrZWQgb24gSFMgZGV2aWNlcyB0aG91Z2g/CgpJIGRvbid0IGtub3cuLi4gSSBj
YW4ndCBiZWxpZXZlIG15IHgxNSB3b3VsZCBiZSB1bmlxdWUgPSkuIENhbiBpdCBiZSAKc29tZXRo
aW5nIGluIHRoZSBrZXJuZWwgY29uZmlnPyB1LWJvb3Q/CgpQZXRlciBzaG91bGQgaGF2ZSB0aGUg
c2FtZSBBMy4gUGV0ZXIsIGNhbiB5b3UgdHJ5IHdpdGggbXkgY29uZmlnPwoKICBUb21pCgotLSAK
VGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVs
c2lua2kuClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNp
bGU6IEhlbHNpbmtpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bA==
