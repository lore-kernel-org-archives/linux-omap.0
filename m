From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: make pointer dmic_codec_dev
	static
Date: Tue, 12 Jun 2018 10:46:56 +0300
Message-ID: <d0355575-feb2-a1fe-242a-57acf52bad1e@ti.com>
References: <20180606093504.30255-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180606093504.30255-1-colin.king@canonical.com>
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
To: Colin King <colin.king@canonical.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

SGksCgpPbiAyMDE4LTA2LTA2IDEyOjM1LCBDb2xpbiBLaW5nIHdyb3RlOgo+IEZyb206IENvbGlu
IElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4gCj4gVGhlIHBvaW50ZXIgZG1p
Y19jb2RlY19kZXYgaXMgbG9jYWwgdG8gdGhlIHNvdXJjZSBhbmQgZG9lcyBub3QgbmVlZAo+IHRv
IGJlIGluIGdsb2JhbCBzY29wZSwgc28gbWFrZSBpdCBzdGF0aWMuCj4gCj4gQ2xlYW5zIHVwIHNw
YXJzZSB3YXJuaW5nOgo+IHdhcm5pbmc6IHN5bWJvbCAnZG1pY19jb2RlY19kZXYnIHdhcyBub3Qg
ZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/CgpjYW4geW91IGNoYW5nZSB0aGUgc3ViamVj
dCB0bzoKQVNvQzogb21hcC1hYmUtdHdsNjA0MDogbWFrZSBwb2ludGVyIGRtaWNfY29kZWNfZGV2
IHN0YXRpYwoKV2l0aCB0aGF0IGNoYW5nZToKQWNrZWQtYnk6IFBldGVyIFVqZmFsdXNpIDxwZXRl
ci51amZhbHVzaUB0aS5jb20+Cgo+IAo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxj
b2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4gLS0tCj4gIHNvdW5kL3NvYy9vbWFwL29tYXAtYWJl
LXR3bDYwNDAuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9vbWFwL29tYXAtYWJlLXR3bDYw
NDAuYyBiL3NvdW5kL3NvYy9vbWFwL29tYXAtYWJlLXR3bDYwNDAuYwo+IGluZGV4IDE1Y2NiZjQ3
OWM5Ni4uZDVhZTllYjhjNzU2IDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9vbWFwL29tYXAtYWJl
LXR3bDYwNDAuYwo+ICsrKyBiL3NvdW5kL3NvYy9vbWFwL29tYXAtYWJlLXR3bDYwNDAuYwo+IEBA
IC00MCw3ICs0MCw3IEBAIHN0cnVjdCBhYmVfdHdsNjA0MCB7Cj4gIAlpbnQJbWNsa19mcmVxOwkv
KiBNQ0xLIGZyZXF1ZW5jeSBzcGVlZCBmb3IgdHdsNjA0MCAqLwo+ICB9Owo+ICAKPiAtc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqZG1pY19jb2RlY19kZXY7Cj4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpkbWljX2NvZGVjX2RldjsKPiAgCj4gIHN0YXRpYyBpbnQgb21hcF9hYmVfaHdf
cGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAo+ICAJc3RydWN0IHNu
ZF9wY21faHdfcGFyYW1zICpwYXJhbXMpCj4gCgotIFDDqXRlcgoKVGV4YXMgSW5zdHJ1bWVudHMg
RmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1
c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
