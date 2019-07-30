From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: ti: Mark expected switch
	fall-throughs
Date: Tue, 30 Jul 2019 13:55:28 +0300
Message-ID: <20190730105528.GA27548@bitmer.com>
References: <20190729221534.GA18696@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20190729221534.GA18696@embeddedor>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

T24gTW9uLCBKdWwgMjksIDIwMTkgYXQgMDU6MTU6MzRQTSAtMDUwMCwgR3VzdGF2byBBLiBSLiBT
aWx2YSB3cm90ZToKPiBNYXJrIHN3aXRjaCBjYXNlcyB3aGVyZSB3ZSBhcmUgZXhwZWN0aW5nIHRv
IGZhbGwgdGhyb3VnaC4KPiAKPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBmb2xsb3dpbmcgd2Fybmlu
ZyAoQnVpbGRpbmc6IGFybSk6Cj4gCj4gc291bmQvc29jL3RpL244MTAuYzogSW4gZnVuY3Rpb24g
4oCYbjgxMF9leHRfY29udHJvbOKAmToKPiBzb3VuZC9zb2MvdGkvbjgxMC5jOjQ4OjEwOiB3YXJu
aW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJv
dWdoPV0KPiAgICBsaW5lMWwgPSAxOwo+ICAgIH5+fn5+fn5efn4KPiBzb3VuZC9zb2MvdGkvbjgx
MC5jOjQ5OjI6IG5vdGU6IGhlcmUKPiAgIGNhc2UgTjgxMF9KQUNLX0hQOgo+ICAgXn5+fgo+IAo+
IHNvdW5kL3NvYy90aS9yeDUxLmM6IEluIGZ1bmN0aW9uIOKAmHJ4NTFfZXh0X2NvbnRyb2zigJk6
Cj4gc291bmQvc29jL3RpL3J4NTEuYzo1Nzo2OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkg
ZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0KPiAgICBocyA9IDE7Cj4gICAg
fn5+Xn5+Cj4gc291bmQvc29jL3RpL3J4NTEuYzo1ODoyOiBub3RlOiBoZXJlCj4gICBjYXNlIFJY
NTFfSkFDS19IUDoKPiAgIF5+fn4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNp
bHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPgo+IC0tLQo+ICBzb3VuZC9zb2MvdGkvbjgxMC5j
IHwgMSArCj4gIHNvdW5kL3NvYy90aS9yeDUxLmMgfCAxICsKPiAgMiBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykKPiAKQWNrZWQtYnk6IEphcmtrbyBOaWt1bGEgPGphcmtrby5uaWt1bGFA
Yml0bWVyLmNvbT4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
