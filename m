From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH -next] ASoC: omap: add sdma-pcm.c
	MODULE_LICENSE
Date: Mon, 14 May 2018 09:45:52 +0300
Message-ID: <05c6b697-c2ca-85f2-afd6-d234bc9c1560@ti.com>
References: <2bf2991a-da55-00a4-bc39-a0ee61bad4d0@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <2bf2991a-da55-00a4-bc39-a0ee61bad4d0@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

SGksCgpPbiAyMDE4LTA1LTEzIDA0OjQxLCBSYW5keSBEdW5sYXAgd3JvdGU6Cj4gRnJvbTogUmFu
ZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+Cj4gCj4gQVNvQzogb21hcDogYWRkIHNk
bWEtcGNtLmMgTU9EVUxFX0xJQ0VOU0UKPiAKPiBGaXhlcyB0aGlzIGJ1aWxkIHdhcm5pbmc6Cj4g
Cj4gV0FSTklORzogbW9kcG9zdDogbWlzc2luZyBNT0RVTEVfTElDRU5TRSgpIGluIHNvdW5kL3Nv
Yy9vbWFwL3NuZC1zb2Mtc2RtYS5vCgpJIGhhdmUgYWxyZWFkeSBzdWJtaXR0ZWQgYSBmaXg6Cmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvcGlwZXJtYWlsL2Fsc2EtZGV2ZWwvMjAxOC1N
YXkvMTM1OTQwLmh0bWwKCj4gCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFw
QGluZnJhZGVhZC5vcmc+Cj4gQ2M6IFBldGVyIFVqZmFsdXNpIDxwZXRlci51amZhbHVzaUB0aS5j
b20+Cj4gQ2M6IEphcmtrbyBOaWt1bGEgPGphcmtrby5uaWt1bGFAYml0bWVyLmNvbT4KPiBDYzog
TGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT4KPiBDYzogTWFyayBCcm93biA8YnJv
b25pZUBrZXJuZWwub3JnPgo+IC0tLQo+ICBzb3VuZC9zb2Mvb21hcC9zZG1hLXBjbS5jIHwgICAg
MyArKysKPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+IAo+IC0tLSBsaW51eC1u
ZXh0LTIwMTgwNTEwLm9yaWcvc291bmQvc29jL29tYXAvc2RtYS1wY20uYwo+ICsrKyBsaW51eC1u
ZXh0LTIwMTgwNTEwL3NvdW5kL3NvYy9vbWFwL3NkbWEtcGNtLmMKPiBAQCAtOSw2ICs5LDcgQEAK
PiAgI2luY2x1ZGUgPHNvdW5kL3BjbV9wYXJhbXMuaD4KPiAgI2luY2x1ZGUgPHNvdW5kL3NvYy5o
Pgo+ICAjaW5jbHVkZSA8c291bmQvZG1hZW5naW5lX3BjbS5oPgo+ICsjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9vbWFwLWRtYS5oPgo+ICAKPiAgI2luY2x1ZGUg
InNkbWEtcGNtLmgiCj4gQEAgLTY2LDMgKzY3LDUgQEAgaW50IHNkbWFfcGNtX3BsYXRmb3JtX3Jl
Z2lzdGVyKHN0cnVjdCBkZQo+ICAJcmV0dXJuIGRldm1fc25kX2RtYWVuZ2luZV9wY21fcmVnaXN0
ZXIoZGV2LCBjb25maWcsIGZsYWdzKTsKPiAgfQo+ICBFWFBPUlRfU1lNQk9MX0dQTChzZG1hX3Bj
bV9wbGF0Zm9ybV9yZWdpc3Rlcik7Cj4gKwo+ICtNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7Cj4g
CgotIFDDqXRlcgoKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAy
MiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlw
YWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
