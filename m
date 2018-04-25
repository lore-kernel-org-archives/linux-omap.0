From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/7] ASoC: omap: Deprecate omap-pcm for
 sdma-pcm
Date: Wed, 25 Apr 2018 19:03:19 +0300
Message-ID: <f2033207-f750-42fb-649f-095591f90026@ti.com>
References: <20180425061837.14145-1-peter.ujfalusi@ti.com>
 <20180425101044.GA17531@bitmer.com> <20180425135012.GW5671@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180425135012.GW5671@atomide.com>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: aaro.koskinen@iki.fi, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gMDQvMjUvMjAxOCAwNDo1MCBQTSwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPiAqIEphcmtrbyBO
aWt1bGEgPGphcmtrby5uaWt1bGFAYml0bWVyLmNvbT4gWzE4MDQyNSAwMzo1Nl06Cj4+IFdoYXQg
SSBub3RpY2VkIHNvbWUgdGltZSBhZ28gb24gTjgxMCBidXQgbm90IHRpbWUgdG8gZml4IGl0IHRo
YXQgT01BUCBtdXgKPj4gY2hhbmdlIGRyb3BwZWQgbXV4aW5nIGF1ZGlvIE1jQlNQIHBpbnMuIFRo
b3NlIHBpbnMgYXJlIG11eGVkIGJ5IHJlc2V0IG9yCj4+IGJvb3Rsb2FkZXIgdG8gYW5vdGhlciBm
dW5jdGlvbi4KPj4KPj4gUHJvYmFibHkgYSBmZXcgbGluZXMgdG8gYXJjaC9hcm0vYm9vdC9kdHMv
b21hcDI0MjAtbjgxMC5kdHMgZXRjLgo+IAo+IEhtbSBkbyB5b3UgaGF2ZSBhIGxpbmsgb3IgY29t
bWl0IGlkIHRvIGEgcGF0Y2ggdGhhdCBkb2VzIHRoZSBtdXhpbmcKPiB0byBzZWUgd2hpY2ggcGlu
cyBuZWVkIHRvIGJlIG11eGVkPwoKRldJVyBJIGhhdmUgdGhpcyBhdCB0aGUgbW9tZW50OgpodHRw
czovL3Bhc3RlYmluLmNvbS9XTlQ5d25ENQoKSSBzZWUgdGhhdCB0aGUgY2FyZCBpcyB0aGVyZSwg
YnV0IEknbSBmaWdodGluZyBidWlsZHJvb3QgdG8gaGF2ZSBuZnMKZmlsZXN5c3RlbSB3aXRoIGFw
bGF5IDpvCgpUaGVyZSBhcmUgZmV3IHRoaW5ncyBnb2luZyB0byBiZSBuZWVkZWQgdG8gZ2V0IHRo
aW5ncyBpbiBhIHNoYXBlLCBsaWtlCmNvbnZlcnRpbmcgdGhlIHNvdW5kL3NvYy9vbWFwL244MTAu
YyB0byBwbGF0Zm9ybSBkcml2ZXIgdG8gYmUgcHJvYmVkIHZpYSBEVC4KUHJvcGVyIGJpbmRpbmdz
IGZvciB0aGUgY2FyZCwKc3VwcG9ydCBmb3IgbWNsayBoYW5kbGluZyBpbiBhaWMzeCBjb2RlYyBk
cml2ZXIgKG44MTAgaXMgaGFja2luaWcgdGhhdCBpbiB0aGUKbWFjaGluZSBkcml2ZXIpCgpJbiB0
aGVvcnkgYXVkaW8gX3Nob3VsZF8gd29yayB3aXRoIHRoZSBEVCBjaGFuZ2VzIGFuZCB0aGUgZml4
dXAgaW4gdGhlIG44MTAuYy4uLgoKU2hvdWxkLi4uCgotLSAKUMOpdGVyCgpUZXhhcyBJbnN0cnVt
ZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5u
dXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
