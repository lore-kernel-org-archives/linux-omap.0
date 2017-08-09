From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 01/35] ARM: OMAP2+: Register SoC device attributes
 from machine .init()
Date: Wed, 9 Aug 2017 14:49:25 -0700
Message-ID: <20170809214925.GH3934@atomide.com>
References: <20170804224419.30758-1-laurent.pinchart@ideasonboard.com>
 <20170804224419.30758-2-laurent.pinchart@ideasonboard.com>
 <201708091256.v79Culwe004765@dlelxv90.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <201708091256.v79Culwe004765@dlelxv90.itg.ti.com>
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
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

KiBUb21pIFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPiBbMTcwODA5IDA1OjU3XToK
PiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWdlbmVyaWMuYyBiL2Fy
Y2gvYXJtL21hY2gtb21hcDIvYm9hcmQtZ2VuZXJpYy5jCj4gPiBpbmRleCBkYzllMzRlNjcwYTIu
LjUzMDM0MDJlZDVjMiAxMDA2NDQKPiA+IC0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQt
Z2VuZXJpYy5jCj4gPiArKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWdlbmVyaWMuYwo+
ID4gQEAgLTMzLDYgKzMzLDcgQEAgc3RhdGljIHZvaWQgX19pbml0IG9tYXBfZ2VuZXJpY19pbml0
KHZvaWQpCj4gPiAgCXBkYXRhX3F1aXJrc19pbml0KG9tYXBfZHRfbWF0Y2hfdGFibGUpOwo+ID4g
IAo+ID4gIAlvbWFwZHNzX2luaXRfb2YoKTsKPiA+ICsJb21hcF9zb2NfZGV2aWNlX2luaXQoKTsK
PiA+ICB9Cj4gPiAgCj4gPiAgI2lmZGVmIENPTkZJR19TT0NfT01BUDI0MjAKPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2lvLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2lvLmMK
PiA+IGluZGV4IDFkNzM5ZDFhMGE2NS4uOTUyZTM2YjRjNGQzIDEwMDY0NAo+ID4gLS0tIGEvYXJj
aC9hcm0vbWFjaC1vbWFwMi9pby5jCj4gPiArKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2lvLmMK
PiA+IEBAIC00MjgsNyArNDI4LDYgQEAgc3RhdGljIHZvaWQgX19pbml0IG9tYXBfaHdtb2RfaW5p
dF9wb3N0c2V0dXAodm9pZCkKPiA+ICBzdGF0aWMgdm9pZCBfX2luaXQgX19tYXliZV91bnVzZWQg
b21hcF9jb21tb25fbGF0ZV9pbml0KHZvaWQpCj4gPiAgewo+ID4gIAlvbWFwMl9jb21tb25fcG1f
bGF0ZV9pbml0KCk7Cj4gPiAtCW9tYXBfc29jX2RldmljZV9pbml0KCk7Cj4gPiAgfQo+ID4gIAo+
ID4gICNpZmRlZiBDT05GSUdfU09DX09NQVAyNDIwCj4gPiAKPiAKPiBUb255LCBob3cgZG9lcyB0
aGlzIGxvb2s/IENhbiBJIHB1c2ggaXQgdmlhIHRoZSBkcm0gdHJlZSwgYWxvbmcgd2l0aCB0aGUK
PiBzZXJpZXM/CgpZZXMgc2VlbXMgc2FmZSB0byBtZSwgcGxlYXNlIGZlZWwgZnJlZSB0byBtZXJn
ZSBpdCB3aXRoIHlvdXIKc2VyaWVzOgoKQWNrZWQtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRv
bWlkZS5jb20+CgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
