From: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 00/62] Add definition for GPIO direction
Date: Tue, 5 Nov 2019 15:06:42 +0000
Message-ID: <be58a14237f8195f00a459e8b06876fe37d1b836.camel@fi.rohmeurope.com>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
 <20191105122042.GO32742@smile.fi.intel.com>
 <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
 <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
 <938a5ec7b41ae9ce7b0de83764d6b774cfdaa781.camel@fi.rohmeurope.com>
 <20191105133604.d2xcasxw7pwzwvh7@pengutronix.de>
 <a967c764d135ab0f96f6b1df62ac91426c935b44.camel@fi.rohmeurope.com>
 <20191105145946.2ye6ujvqzn2d6fqd@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20191105145946.2ye6ujvqzn2d6fqd@pengutronix.de>
Content-Language: de-DE
Content-ID: <6D5D437184F57F40A974F8CC692726E2@de.rohmeurope.com>
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
Cc: "semi.malinen@ge.com" <semi.malinen@ge.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "david.daney@cavium.com" <david.daney@cavium.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "ptyser@xes-inc.com" <ptyser@xes-inc.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "marek.behun@nic.cz" <marek.behun@nic.cz>, "festevam@gmail.com" <festevam@gmail.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, michal.sime
List-Id: linux-omap@vger.kernel.org

DQpPbiBUdWUsIDIwMTktMTEtMDUgYXQgMTU6NTkgKzAxMDAsIFV3ZSBLbGVpbmUtS8O2bmlnIHdy
b3RlOg0KPiBIZWxsbyBNYXR0aSwNCj4gDQo+IE9uIFR1ZSwgTm92IDA1LCAyMDE5IGF0IDAyOjAw
OjAyUE0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDE5LTEx
LTA1IGF0IDE0OjM2ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gPiBUaGFua3Mg
VXdlISBUaGF0IHdhcyBraW5kISBJJ20gb24gRmVkb3JhIGJ1dCBJIGd1ZXNzIEkgY2FuIGZpbmQg
dGhlDQo+ID4gbXVsdGlhcmNoIGJpbnV0aWxzIDopIEknbGwgdHJ5IHRoYXQgdG9tb3Jyb3cgd2hl
biBJJ20gYmFjayBhdCB0aGUNCj4gPiBvZmZpY2UuIExldCdzIHNlZSB3aGF0IGtpbmQgb2YgcmVz
dWx0cyBJIGNhbiBnZXQgZnJvbSBpdC4NCj4gPiANCj4gPiBVbmZvcnR1bmF0ZWx5IGJ1bmNoIG9m
IHRoZSBHUElPcyBkZXBlbmQgb24geDg2IC0gc28gSSBuZWVkIHRvIHNlZQ0KPiA+IHdoYXQNCj4g
PiBJIGNhbiBjb21waWxlIGluIHdpdGggZGVjZW50IGVmZm9ydC4gRm9yIG15IGNvbXBpbGUgdGVz
dCBJIGp1c3QNCj4gPiBoYWNrZWQNCj4gPiB0aGUgTWFrZWZpbGUgdG8gZm9yY2UgYWxsIGluIGFu
ZCBhZGRlZCBzb21lIGR1bW15IG1hY3JvcyB0byBmaXggZmV3DQo+ID4gbWlzc2luZyBmdW5jdGlv
bnMgOnwgQnV0IEkgZ3Vlc3MgSSBjYW4gZ2V0IHNvbWUgcmVzdWx0cy4NCj4gDQo+IEVuYWJsZSBD
T05GSUdfQ09NUElMRV9URVNUIGFuZCB0aGVuIHlvdSBzaG91bGQgYmUgYWJsZSB0byBjb21waWxl
DQo+IG1vc3QNCj4gZHJpdmVycyBhbHNvIG9uIHRoZSB3cm9uZyBhcmNoaXRlY3R1cmUuDQoNClJp
Z2h0LiBUaGF0IHdhcyB0aGUgZmlyc3QgdGhpbmcgSSB0cmllZCBvdXQuIFVuZm9ydHVuYXRlbHkg
YnVuY2ggb2YgdGhlDQpncGlvLWRyaXZlcnMgd29uJ3QgY2FyZSBhYm91dCBDT05GSUdfQ09NUElM
RV9URVNULiBUaGFua3MgYW55d2F5cyA6KQ0KDQpCciwNCglNYXR0aQ0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
