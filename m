From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 7/7] drm/omap: hdmi4: fix use of uninitialized var
Date: Fri, 11 Oct 2019 13:25:18 +0300
Message-ID: <d7cb0f2a-1645-29ff-aaf2-2ec5188dbc24@ti.com>
References: <20190930103840.18970-1-tomi.valkeinen@ti.com>
 <20190930103840.18970-8-tomi.valkeinen@ti.com>
 <20191008141335.GB5610@atomide.com>
 <ffb498fb-5041-d3e9-2702-879f3d389adf@ti.com>
 <20191008142153.GD5610@atomide.com>
 <59381248-5ded-7ea9-40a6-cbfb58a3c5b1@ti.com>
 <20191010132407.GS5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191010132407.GS5610@atomide.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

T24gMTAvMTAvMjAxOSAxNjoyNCwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKCj4gSG1tIHNvIHdoYXQg
cmVnaXN0ZXIgZG9lcyB0aGlzIGNsb2NrIGFjdHVhbGx5IGNoYW5nZT8KPiAKPiBJJ20gc2VlaW5n
IGFuIGluY3JlYXNlIG9mIGZldyB0ZW5zIG9mIGV4dHJhIG1XLCB3aGljaCBtZWFucyBhdAo+IGxl
YXN0IG9uZSBkYXkgb2Ygc3RhbmRieSB0aW1lIGxlc3MgZm9yIG1lIDopIEl0IGRvZXMgbm90IGhh
cHBlbgo+IGFsd2F5cywgbWF5YmUgaGFsZiBvZiB0aGUgdGltZS4KCkkgaGF2ZSBubyBpZGVhIHdo
eSB0aGlzIHdvdWxkIGFmZmVjdCBwb3dlciBjb25zdW1wdGlvbi4gQXMgZmFyIGFzIEkgY2FuIAp1
bmRlcnN0YW5kLCB0aGUgYml0cyB3cml0dGVuIGhlcmUgYXJlIGEgY2xrIGRpdmlkZXIgTUNMSy4g
SSBkb24ndCBzZWUgCndoeSB0aGF0IHdvdWxkIGFmZmVjdC4KCk1heWJlIEp5cmkgb3IgUGV0ZXIg
aGFzIGFuIGlkZWEsIEkgaGF2ZSBuZXZlciBsb29rZWQgYXQgdGhlIEhETUkgYXVkaW8gc2lkZS4K
CiAgVG9taQoKLS0gClRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUg
MjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3Rp
cGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWw=
