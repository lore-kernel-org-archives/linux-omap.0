From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 7/7] drm/omap: hdmi4: fix use of uninitialized var
Date: Fri, 11 Oct 2019 09:10:08 -0700
Message-ID: <20191011161008.GY5610@atomide.com>
References: <20190930103840.18970-1-tomi.valkeinen@ti.com>
 <20190930103840.18970-8-tomi.valkeinen@ti.com>
 <20191008141335.GB5610@atomide.com>
 <ffb498fb-5041-d3e9-2702-879f3d389adf@ti.com>
 <20191008142153.GD5610@atomide.com>
 <59381248-5ded-7ea9-40a6-cbfb58a3c5b1@ti.com>
 <20191010132407.GS5610@atomide.com>
 <d7cb0f2a-1645-29ff-aaf2-2ec5188dbc24@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <d7cb0f2a-1645-29ff-aaf2-2ec5188dbc24@ti.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

KiBUb21pIFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPiBbMTkxMDExIDEwOjI1XToK
PiBPbiAxMC8xMC8yMDE5IDE2OjI0LCBUb255IExpbmRncmVuIHdyb3RlOgo+IAo+ID4gSG1tIHNv
IHdoYXQgcmVnaXN0ZXIgZG9lcyB0aGlzIGNsb2NrIGFjdHVhbGx5IGNoYW5nZT8KPiA+IAo+ID4g
SSdtIHNlZWluZyBhbiBpbmNyZWFzZSBvZiBmZXcgdGVucyBvZiBleHRyYSBtVywgd2hpY2ggbWVh
bnMgYXQKPiA+IGxlYXN0IG9uZSBkYXkgb2Ygc3RhbmRieSB0aW1lIGxlc3MgZm9yIG1lIDopIEl0
IGRvZXMgbm90IGhhcHBlbgo+ID4gYWx3YXlzLCBtYXliZSBoYWxmIG9mIHRoZSB0aW1lLgo+IAo+
IEkgaGF2ZSBubyBpZGVhIHdoeSB0aGlzIHdvdWxkIGFmZmVjdCBwb3dlciBjb25zdW1wdGlvbi4g
QXMgZmFyIGFzIEkgY2FuCj4gdW5kZXJzdGFuZCwgdGhlIGJpdHMgd3JpdHRlbiBoZXJlIGFyZSBh
IGNsayBkaXZpZGVyIE1DTEsuIEkgZG9uJ3Qgc2VlIHdoeQo+IHRoYXQgd291bGQgYWZmZWN0LgoK
WWVhaCB5b3UncmUgcmlnaHQsIGFuZCBJIGp1c3QgZ290IGx1Y2t5IGluaXRpYWxseS4KCkkgaGF2
ZSBzZWVuIHRoZSBwb3dlciBjb25zdW1wdGlvbiBzdGF5IGhpZ2hlciBhbHJlYWR5IHdpdGgKdGhl
IHBhdGNoIGFwcGxpZWQuIFRoZSBjbG9ja3Mgc2VlbSBqdXN0IGZpbmUuCgo+IE1heWJlIEp5cmkg
b3IgUGV0ZXIgaGFzIGFuIGlkZWEsIEkgaGF2ZSBuZXZlciBsb29rZWQgYXQgdGhlIEhETUkgYXVk
aW8gc2lkZS4KCkknbGwgdHJ5IGR1bXBpbmcgb3V0IHRoZSBoZG1pIHJlZ2lzdGVycyBiZWZvcmUg
YW5kIGFmdGVyCndoZW4gSSBnZXQgYSBjaGFuY2UuCgpSZWdhcmRzLAoKVG9ueQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
