From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcbsp: Fix latency value
 calculation for pm_qos
Date: Mon, 19 Nov 2018 16:14:13 +0200
Message-ID: <c26c055f-5f7a-46b5-a409-6b60f0657f56@ti.com>
References: <20181114110623.30932-1-peter.ujfalusi@ti.com>
 <20181114110623.30932-2-peter.ujfalusi@ti.com>
 <d1e6e9df-3893-7c2d-acbb-05b59011a364@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d1e6e9df-3893-7c2d-acbb-05b59011a364@bitmer.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, tony@atomide.com
Cc: kernel@pyra-handheld.com, hns@goldelico.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, matt@ranostay.consulting
List-Id: linux-omap@vger.kernel.org

CgpPbiAyMDE4LTExLTE4IDE5OjA0LCBKYXJra28gTmlrdWxhIHdyb3RlOgo+IE9uIDExLzE0LzE4
IDE6MDYgUE0sIFBldGVyIFVqZmFsdXNpIHdyb3RlOgo+PiBUaGUgbGF0ZW5jeSBudW1iZXIgaXMg
aW4gdXNlYyBmb3IgdGhlIHBtX3Fvcy4gQ29ycmVjdCB0aGUgY2FsY3VsYXRpb24gdG8KPj4gZ2l2
ZSB1cyB0aGUgdGltZSBpbiB1c2VjCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFVqZmFsdXNp
IDxwZXRlci51amZhbHVzaUB0aS5jb20+Cj4+IC0tLQo+PiAgc291bmQvc29jL29tYXAvb21hcC1t
Y2JzcC5jIHwgNiArKystLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvb21hcC9vbWFwLW1jYnNw
LmMgYi9zb3VuZC9zb2Mvb21hcC9vbWFwLW1jYnNwLmMKPj4gaW5kZXggZTBlZjQ3NzRjNzEwLi5h
Mzk1NTk4ZjFmMjAgMTAwNjQ0Cj4+IC0tLSBhL3NvdW5kL3NvYy9vbWFwL29tYXAtbWNic3AuYwo+
PiArKysgYi9zb3VuZC9zb2Mvb21hcC9vbWFwLW1jYnNwLmMKPj4gQEAgLTk5OSw5ICs5OTksOSBA
QCBzdGF0aWMgaW50IG9tYXBfbWNic3BfZGFpX2h3X3BhcmFtcyhzdHJ1Y3Qgc25kX3BjbV9zdWJz
dHJlYW0gKnN1YnN0cmVhbSwKPj4gIAkJCXBrdF9zaXplID0gY2hhbm5lbHM7Cj4+ICAJCX0KPj4g
IAo+PiAtCQlsYXRlbmN5ID0gKCgoKGJ1ZmZlcl9zaXplIC0gcGt0X3NpemUpIC8gY2hhbm5lbHMp
ICogMTAwMCkKPj4gLQkJCQkgLyAocGFyYW1zLT5yYXRlX251bSAvIHBhcmFtcy0+cmF0ZV9kZW4p
KTsKPj4gLQo+PiArCQlsYXRlbmN5ID0gKGJ1ZmZlcl9zaXplIC0gcGt0X3NpemUpIC8gY2hhbm5l
bHM7Cj4+ICsJCWxhdGVuY3kgPSBsYXRlbmN5ICogVVNFQ19QRVJfU0VDIC8KPj4gKwkJCSAgKHBh
cmFtcy0+cmF0ZV9udW0gLyBwYXJhbXMtPnJhdGVfZGVuKTsKPiAKPiBEaWQgSSB1bmRlcnN0YW5k
IGNvcnJlY3RseSB0aGlzIGRvZXNuJ3QgZml4IGFueSBhdWRpbyBpc3N1ZSBidXQgYWxsb3dzCj4g
Q1BVIHNsZWVwIGxvbmdlciBvciByZWFjaCBkZWVwZXIgc2xlZXA/CgpQTSBjb3JlIHdpbGwgYmxv
Y2sgYW55IHBvd2VyIHN0YXRlIGZyb20gd2hlcmUgdGhlIHdha2UtdXAgd291bGQgdGFrZQpsb25n
ZXIgdGhhbiB0aGUgbGF0ZW5jeSB2YWx1ZS4KClRoZSBsYXRlbmN5IGlzIGluIHVzZWMsIHRoaXMg
cGF0Y2gganVzdCBmaXhpbmcgdGhlIGNhbGN1bGF0aW9uIHRvIGdldAp0aGUgdGltZSBpbiB1c2Vj
LgoKLSBQw6l0ZXIKClRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUg
MjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3Rp
cGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
