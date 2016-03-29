From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v8 1/6] ALSA: pcm: add IEC958 channel status helper for
 hw_params
Date: Tue, 29 Mar 2016 18:23:12 +0100
Message-ID: <20160329172312.GR5783@n2100.arm.linux.org.uk>
References: <cover.1458214526.git.jsarha@ti.com>
 <164484552294777b0b9b88d7982bd6bfb0da9a9f.1458214526.git.jsarha@ti.com>
 <s5hzithhdfz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5hzithhdfz.wl-tiwai@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gVHVlLCBNYXIgMjksIDIwMTYgYXQgMTA6NTQ6MDhBTSArMDIwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IE9uIFRodSwgMTcgTWFyIDIwMTYgMTM6MjI6MjkgKzAxMDAsCj4gSnlyaSBTYXJoYSB3
cm90ZToKPiA+IAo+ID4gQWRkIElFQzk1OCBjaGFubmVsIHN0YXR1cyBoZWxwZXIgdGhhdCBnZXRz
IHRoZSBhdWRpbyBwcm9wZXJ0aWVzIGZyb20KPiA+IHNuZF9wY21faHdfcGFyYW1zIGluc3RlYWQg
b2Ygc25kX3BjbV9ydW50aW1lLiBUaGlzIGlzIG5lZWRlZCB0bwo+ID4gcHJvZHVjZSB0aGUgY2hh
bm5lbCBzdGF0dXMgYml0cyBhbHJlYWR5IGluIGF1ZGlvIHN0cmVhbSBjb25maWd1cmF0aW9uCj4g
PiBwaGFzZS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogSnlyaSBTYXJoYSA8anNhcmhhQHRpLmNv
bT4KPiAKPiBUaGlzIHBhdGNoIGxvb2tzIGFsbW9zdCBnb29kIHRvIG1lLCBidXQuLi4KPiAKPiA+
IEBAIC03MSw2ICs1OSw3IEBAIGludCBzbmRfcGNtX2NyZWF0ZV9pZWM5NThfY29uc3VtZXIoc3Ry
dWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSwgdTggKmNzLAo+ID4gIAkJCSAgICAgSUVDOTU4
X0FFUzRfQ09OX01BWF9XT1JETEVOXzI0Owo+ID4gIAkJCWJyZWFrOwo+ID4gIAkJY2FzZSAyNDoK
PiA+ICsJCWNhc2UgMzI6IC8qIEFzc3VtZSAyNC1iaXQgd2lkdGggZm9yIDMyLWJpdCBzYW1wbGVz
LiAqLwo+ID4gIAkJCXdzID0gSUVDOTU4X0FFUzRfQ09OX1dPUkRMRU5fMjRfMjAgfAo+ID4gIAkJ
CSAgICAgSUVDOTU4X0FFUzRfQ09OX01BWF9XT1JETEVOXzI0Owo+ID4gIAkJCWJyZWFrOwo+IAo+
IC4uLiB0aGlzIGNoYW5nZSBpcyBzaWxlbnRseSBzbGlwcGVkIGluLiAgSXQgc2hvdWxkIGJlIG1l
bnRpb25lZCBpbiB0aGUKPiBjaGFuZ2Vsb2csIG9yIHNwbGl0IHRvIGFub3RoZXIgcGF0Y2gsIGFz
IHRoaXMgaXMgYmFzaWNhbGx5IGFuCj4gb3J0aG9nb25hbCBjaGFuZ2UuCgpEb2VzIGl0IGV2ZW4g
bWFrZSBzZW5zZSAtIEFFUyBkb2Vzbid0IGhhdmUgc3VwcG9ydCBmb3IgMzItYml0IHNhbXBsZXMs
Cml0IGNhbiBvbmx5IGV2ZXIgdHJ1bmNhdGUgdGhlbSBkb3duIHRvIDI0LWJpdC4KCi0tIApSTUsn
cyBQYXRjaCBzeXN0ZW06IGh0dHA6Ly93d3cuYXJtLmxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0
Y2hlcy8KRlRUQyBicm9hZGJhbmQgZm9yIDAuOG1pbGUgbGluZTogY3VycmVudGx5IGF0IDkuNk1i
cHMgZG93biA0MDBrYnBzIHVwCmFjY29yZGluZyB0byBzcGVlZHRlc3QubmV0LgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
