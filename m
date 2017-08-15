From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 05/11] ASoC: omap: make snd_soc_platform_driver const
Date: Tue, 15 Aug 2017 13:47:50 +0300
Message-ID: <9084e936-c239-0c37-7a54-0d4c9d3bbae6@ti.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-6-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1502710730-18912-6-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, bardliao@realtek.com, chiou@realtek.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, yang.jie@linux.intel.com, jarkko.nikula@bitmer.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, plai@codeaurora.org, bgoswami@codeaurora.org, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

77u/CgpUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4
MCBIZWxzaW5raS4gWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9E
b21pY2lsZTogSGVsc2lua2kKCk9uIDIwMTctMDgtMTQgMTQ6MzgsIEJodW1pa2EgR295YWwgd3Jv
dGU6Cj4gTWFrZSB0aGlzIGNvbnN0IGFzIGl0IGlzIG9ubHkgcGFzc2VkIGFzIHRoZSAybmQgYXJn
dW1lbnQgdG8gdGhlCj4gZnVuY3Rpb24gZGV2bV9zbmRfc29jX3JlZ2lzdGVyX3BsYXRmb3JtLCB3
aGljaCBpcyBvZiB0eXBlIGNvbnN0Lgo+IERvbmUgdXNpbmcgQ29jY2luZWxsZS4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBCaHVtaWthIEdveWFsIDxiaHVtaXJrc0BnbWFpbC5jb20+CgpBY2tlZC1ieTog
UGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4KCj4gLS0tCj4gIHNvdW5kL3Nv
Yy9vbWFwL29tYXAtcGNtLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvb21hcC9vbWFwLXBj
bS5jIGIvc291bmQvc29jL29tYXAvb21hcC1wY20uYwo+IGluZGV4IDk0ZTlmZjcuLjEyODM0NzMg
MTAwNjQ0Cj4gLS0tIGEvc291bmQvc29jL29tYXAvb21hcC1wY20uYwo+ICsrKyBiL3NvdW5kL3Nv
Yy9vbWFwL29tYXAtcGNtLmMKPiBAQCAtMjQzLDcgKzI0Myw3IEBAIHN0YXRpYyBpbnQgb21hcF9w
Y21fbmV3KHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpydGQpCj4gIAlyZXR1cm4gcmV0Owo+
ICB9Cj4gIAo+IC1zdGF0aWMgc3RydWN0IHNuZF9zb2NfcGxhdGZvcm1fZHJpdmVyIG9tYXBfc29j
X3BsYXRmb3JtID0gewo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9zb2NfcGxhdGZvcm1fZHJp
dmVyIG9tYXBfc29jX3BsYXRmb3JtID0gewo+ICAJLm9wcwkJPSAmb21hcF9wY21fb3BzLAo+ICAJ
LnBjbV9uZXcJPSBvbWFwX3BjbV9uZXcsCj4gIAkucGNtX2ZyZWUJPSBvbWFwX3BjbV9mcmVlX2Rt
YV9idWZmZXJzLAo+IAoKLSBQw6l0ZXIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
