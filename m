From: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 00/62] Add definition for GPIO direction
Date: Tue, 5 Nov 2019 13:30:20 +0000
Message-ID: <938a5ec7b41ae9ce7b0de83764d6b774cfdaa781.camel@fi.rohmeurope.com>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
 <20191105122042.GO32742@smile.fi.intel.com>
 <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
 <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
Content-Language: de-DE
Content-ID: <0E04C63BA3FE0D4784860575696D5A4B@de.rohmeurope.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
Cc: "semi.malinen@ge.com" <semi.malinen@ge.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "david.daney@cavium.com" <david.daney@cavium.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "ptyser@xes-inc.com" <ptyser@xes-inc.com>, "t.scherer@eckelmann.de" <t.scherer@eckelmann.de>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "marek.behun@nic.cz" <marek.behu>
List-Id: linux-omap@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTA1IGF0IDE0OjEwICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gSGVsbG8sDQo+IA0KPiBPbiBUdWUsIE5vdiAwNSwgMjAxOSBhdCAxMjo1NDo1NVBNICsw
MDAwLCBWYWl0dGluZW4sIE1hdHRpIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOS0xMS0wNSBhdCAx
NDoyMCArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4gSSB3b3VsZCBhbHNvIGxp
a2UgdG8gc2VlIGJsb2F0LW8tbWV0ZXIgc3RhdGlzdGljcyBiZWZvcmUgYW5kDQo+ID4gPiBhZnRl
cg0KPiA+ID4geW91ciBwYXRjaC4NCj4gPiA+IE15IGd1dHMgdGVsbCBtZSB0aGF0IHRoZSByZXN1
bHQgd2lsbCBiZSBub3QgaW4gdGhlIGZhdm91ciBvZg0KPiA+ID4geW91cnMNCj4gPiA+IHNvbHV0
aW9uLg0KPiA+IA0KPiA+IENhbiB5b3UgcGxlYXNlIHRlbGwgbWUgd2hhdCB0eXBlIG9mIHN0YXRz
IHlvdSBob3BlIHRvIHNlZT8gSSBjYW4NCj4gPiB0cnkNCj4gPiBnZW5lcmF0aW5nIHdoYXQgeW91
IGFyZSBhZnRlci4gVGhlIGNvdmVyIGxldHRlciBjb250YWluZWQgdHlwaWNhbA0KPiA+ICsvLQ0K
PiA+IGNoYW5nZSBzdGF0cyBmcm9tIGdpdCBhbmQgc3VtbWFyeToNCj4gPiANCj4gPiA2MiBmaWxl
cyBjaGFuZ2VkLCAyMjggaW5zZXJ0aW9ucygrKSwgMTA0IGRlbGV0aW9ucygtKQ0KPiANCj4gSSBn
dWVzcyBoZSB3YW50cyB0byBzZWUNCj4gDQo+IAlzY3JpcHRzL2Jsb2F0LW8tbWV0ZXIgdm1saW51
ei5vbGQgdm1saW51eg0KPiANCj4gLiBJIHdvdWxkIGV4cGVjdCBhIDAgdGhlcmUuIEkgZGlkbid0
IGxvb2sgaW4gZGV0YWlsLCBidXQgaW4gZ2VuZXJhbCBJDQo+IGxpa2UgdGhlIGlkZWEgdG8gZ2l2
ZSAwIGFuZCAxIGEgc3ltYm9saWMgbmFtZS4NCg0KVGhhbmtzIFV3ZS4gVGhpcyBmYXIgSSBoYXZl
IG9ubHkgY3Jvc3MtY29tcGlsZWQgdGhlIHNlcmllcyBmb3IgYXJtDQp3aGljaCBJIHVzZSBmb3Ig
ZGV2ZWxvcGluZyB0aGUgUk9ITSBQTUlDcy4gc2NyaXB0cy9ibG9hdC1vLW1ldGVyIC8NCnRvb2xz
IGl0IHVzZXMgZG9lcyBub3Qgc2VlbSB0byByZWNvZ25pemUgdGhlIGltYWdlIGZvcm1hdCAobm90
IGEgYmlnDQpzdXJwcml6ZSBhcyBteSBob3N0IGlzIHg4Nl82NCkuDQoNCkJyLA0KCU1hdHRpIFZh
aXR0aW5lbg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
