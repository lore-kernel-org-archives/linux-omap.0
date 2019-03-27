From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2] omapdrm: hdmi4_cec: Fix CEC clock handling for PM
Date: Wed, 27 Mar 2019 11:05:24 +0200
Message-ID: <bdeecc24-9672-2442-6c2d-7be5e765b6f3@ti.com>
References: <20190326151438.32414-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190326151438.32414-1-tony@atomide.com>
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
Cc: dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>, Jyri Sarha <jsarha@ti.com>, Hans Verkuil <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gMjYvMDMvMjAxOSAxNzoxNCwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPiBJZiBDT05GSUdfT01B
UDRfRFNTX0hETUlfQ0VDIGlzIGVuYWJsZWQgaW4gLmNvbmZpZywgZGVlcGVyIFNvQyBpZGxlCj4g
c3RhdGVzIGFyZSBibG9ja2VkIGJlY2F1c2UgdGhlIENFQyBjbG9jayBnZXRzIGFsd2F5cyBlbmFi
bGVkIG9uIGluaXQuCj4gCj4gTGV0J3MgZml4IHRoZSBpc3N1ZSBieSBtb3ZpbmcgdGhlIENFQyBj
bG9jayBoYW5kbGluZyB0byBoYXBwZW4gbGF0ZXIgaW4KPiBoZG1pX2NlY19hZGFwX2VuYWJsZSgp
IGFzIHN1Z2dlc3RlZCBieSBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD4uCj4gVGhp
cyB3YXkgdGhlIENFQyBjbG9jayBnZXRzIG9ubHkgZW5hYmxlZCB3aGVuIG5lZWRlZC4gVGhpcyBj
YW4gYmUgdGVzdGVkCj4gYnkgZG9pbmcgY2VjLWN0bCAtLXBsYXliYWNrIHRvIGVuYWJsZSB0aGUg
Q0VDLCBhbmQgZG9pbmcgY2VjLWN0bCAtLWNsZWFyCj4gdG8gZGlzYWJsZSBpdC4KPiAKPiBMZXQn
cyBhbHNvIGZpeCB0aGUgdHlwbyBmb3IgImRpdmlkZXIiIGluIHRoZSBjb21tZW50cyB3aGlsZSBh
dCBpdC4KPiAKPiBGaXhlczogOGQ3ZjkzNGRmOGQ4ICgib21hcGRybTogaGRtaTRfY2VjOiBhZGQg
T01BUDQgSERNSSBDRUMgc3VwcG9ydCIpCj4gU3VnZ2VzdGVkLWJ5OiBIYW5zIFZlcmt1aWwgPGh2
ZXJrdWlsQHhzNGFsbC5ubD4KPiBDYzogSGFucyBWZXJrdWlsIDxodmVya3VpbEB4czRhbGwubmw+
Cj4gQ2M6IEp5cmkgU2FyaGEgPGpzYXJoYUB0aS5jb20+Cj4gQ2M6IExhdXJlbnQgUGluY2hhcnQg
PGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBUb255
IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPgo+IC0tLQoKVGhhbmtzISBJJ2xsIHBpY2sgdGhp
cyB1cC4KCiBUb21pCgotLSAKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFu
a2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQu
IEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbA==
