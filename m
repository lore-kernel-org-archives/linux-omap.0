From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/8] ASoC: omap-mcbsp: Cleanup and split
 core/sidetone support
Date: Mon, 12 Nov 2018 15:35:52 +0200
Message-ID: <0de12aae-39b8-abf2-24a2-237d9570ee09@ti.com>
References: <20181108073000.21114-1-peter.ujfalusi@ti.com>
 <c2e86562-49f0-9600-3df7-87de40caec06@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <c2e86562-49f0-9600-3df7-87de40caec06@bitmer.com>
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
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

CgpPbiAyMDE4LTExLTEwIDE3OjU5LCBKYXJra28gTmlrdWxhIHdyb3RlOgo+IE9uIDExLzgvMTgg
OToyOSBBTSwgUGV0ZXIgVWpmYWx1c2kgd3JvdGU6Cj4+IEhpLAo+Pgo+PiBDaGFuZ2VzIHNpbmNl
IHYyOgo+PiAtIFNwbGl0IHRoZSBkbWFfZGF0YSBhZGRyIGFuZCBtYXhidXJzdCBjbGVhbnVwIHBh
dGNoZXMKPj4gLSBBZGRlZCBKYXJra28ncyBBY2tlZC1ieSB0b3QgaGUgc2VyaWVzLgo+Pgo+IEhl
cmUncyBteSBwcm9taXNlZCB0ZXN0aW5nIHRvby4gSSB1c2VkIGEgc2V0dXAgYmVsb3cgdG8gdGVz
dCBzaWRldG9uZQo+IGZ1bmN0aW9uYWxpdHkuIEFzc3VtaW5nIGJvdGggcGxheWJhY2sgYW5kIHJl
Y29yZGluZyBwYXRoIGFyZSBhbHJlYWR5IHNldC4KPiAKPiBhbWl4ZXIgLUQgaHc6MCBzZXQgJ01j
QlNQMiBTaWRldG9uZScgb24KPiBhbWl4ZXIgLUQgaHc6MCBzZXQgJ01jQlNQMiBTaWRldG9uZSBD
aGFubmVsIDAnIDEwMCUKPiBhbWl4ZXIgLUQgaHc6MCBzZXQgJ01jQlNQMiBTaWRldG9uZSBDaGFu
bmVsIDEnIDEwMCUKPiBlY2hvIDMyNzY3ID4vc3lzL2RldmljZXMvcGxhdGZvcm0vNjgwMDAwMDAu
b2NwLzQ5MDIyMDAwLm1jYnNwL3N0X3RhcHMKPiBlY2hvIHRocmVzaG9sZAo+PiAvc3lzL2Rldmlj
ZXMvcGxhdGZvcm0vNjgwMDAwMDAub2NwLzQ5MDIyMDAwLm1jYnNwL2RtYV9vcF9tb2RlCj4gYXJl
Y29yZCAtZiBkYXQgPi9kZXYvbnVsbCB8YXBsYXkgLWYgZGF0IC9kZXYvemVybwo+IAo+IF5eCj4g
YXJlY29yZCBkdW1wcyBpbnRvIC9kZXYvbnVsbCBhbmQgYXBsYXkgcGxheXMgZnJvbSAvZGV2L3pl
cm8gc28gb25seSBwYXRoCj4gZnJvbSBpbnB1dCB0byBvdXRwdXQgaXMgdGhlIHNpZGV0b25lIHBh
dGguCj4gCj4gVGVzdGVkLWJ5OiBKYXJra28gTmlrdWxhIDxqYXJra28ubmlrdWxhQGJpdG1lci5j
b20+CgpUaGFua3MgSmFya2tvIQoKLSBQw6l0ZXIKClRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQg
T3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1bm51cy9CdXNpbmVzcyBJ
RDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
