From: Arun MURTHY <arun.murthy@stericsson.com>
Subject: RE: [PATCH 1/7] pwm: Add pwm core driver
Date: Fri, 1 Oct 2010 10:46:15 +0200
Message-ID: <F45880696056844FA6A73F415B568C69532DCF34AE@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
        <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
        <4CA1AD2B.8000905@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
        <4CA1BC16.3020702@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
        <4CA25841.4090702@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
        <AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
        <F45880696056844FA6A73F415B568C69532DCF32BC@EXDCVYMBSTM006.EQ1STM.local>
        <AANLkTikTo42Q5-yMEwyQH4mt=qLjaKrtJK3ydZNFyqai@mail.gmail.com>
        <F45880696056844FA6A73F415B568C69532DCF33BB@EXDCVYMBSTM006.EQ1STM.local>
 <AANLkTimPgPY9rX_MYZTv0PpRQgfWGoSeSE9WWy_ami-V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <AANLkTimPgPY9rX_MYZTv0PpRQgfWGoSeSE9WWy_ami-V@mail.gmail.com>
Content-Language: en-US
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Lars-Peter Clausen <lars@metafoo.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Bill Gatliff <bgat@billgatliff.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, Marek Vasut <marek.vasut@gmail.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>, Mattias WALLIN <mattias.wallin@stericsson.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, eric.y.miao@gmail.
List-Id: linux-omap@vger.kernel.org

PiBPbiBGcmksIE9jdCAxLCAyMDEwIGF0IDQ6MjUgUE0sIEFydW4gTVVSVEhZDQo+IDxhcnVuLm11
cnRoeUBzdGVyaWNzc29uLmNvbT4gd3JvdGU6DQo+ID4gWW91IGNhbiBoYXZlIGEgbG9vayBhdCB0
aGUgcHdtX2NvbmZpZ19ub3NsZWVwKCkscHdtX3NldF9wb2xhcml0eSgpLA0KPiA+IHB3bV9zeW5j
aHJvbml6ZSgpLHB3bV91bnN5bmNocm9uaXplKCksIHB3bV9zZXRfaGFuZGxlcigpIGV0Yy4NCj4g
PiBUaGVzZSBhcmUgbm90IGJlaW5nIHVzZWQgYnkgdGhlIGV4c3RpbmcgcHdtIGRyaXZlcnMgZXhj
ZXB0IEF0bWVsIHB3bS4NCj4gSG93IHdvdWxkIHlvdXIgJ3NpbXBsZScgZHJpdmVyIGhhbmRsZSBB
dG1lbCB0aGVuID8NCj4gV2hhdCBpZiBmdXR1cmUncyBTb0NzIHN0YXJ0IHByb3ZpZGluZyB0aG9z
ZSAnYWR2YW5jZScgZmVhdHVyZXMgbGlrZQ0KPiBBdG1lbCdzID8NCj4gDQpUaGUgcHdtIGNvcmUg
ZHJpdmVyIGlzIHRoZSBpbnRlcnNlY3Rpb24gb2YgYWxsIHB3bSBkcml2ZXJzIGFuZCBub3QgdW5p
b24NCm9mIGFsbCBwd20gZHJpdmVyLiBJIHJlZmVyIHRoaXMgYXMgc2ltcGxlIHB3bSBjb3JlIGRy
aXZlciAvIGZyYW1ld29yay4NCkF0bWVsIHB3bSBpcyBvZiBhIHNlcGFyYXRlIGNsYXNzaWZpY2F0
aW9uLg0KSXQgaW5jbHVkZXMgR1BJTyBhbHNvLiBUaG91Z2gsIEF0bWVsIGNhbiB1c2UgdGhlIHB3
bSBjb3JlIGRyaXZlciBmcmFtZXdvcmsNCmZvciBmdW5jdGlvbmFsaXRpZXMgbGlrZSBwd21fZW5h
YmxlLCBwd21fZGlzYWJsZSwgcHdtX2NvbmZpZywgZXRjIGFuZCByZW1haW5pbmcNCmZ1bmN0aW9u
YWxpdGllcyBzcGVjaWZpYyB0byBBdG1lbCB3aWxsIGJlIGhhbmRsZWQgaW4gQXRsbWVsIHB3bSBk
cml2ZXIgYW5kDQp3aWxsIG5vdCBiZSBleHBvc2VkIHRvIHRoZSBlbnRpcmUga2VybmVsLg0KSXRz
IHRoYXQgdGhlIHByZXNlbnQgZGF5IHB3bSBkZXZpY2UgdGhhdCBoYXMgYmVlbiBtYWRlIGVhc3kg
dGhvdWdoLCBieSBwcm92aWRpbmcNCnRoZSBzYW1lIGZ1bmN0aW9uYWxpdHkuDQoNCj4gPiBJIG1l
YW4gbm90IHRoZSBmdW5jdGlvbnMgYnV0IHRoZSBmdW5jdGlvbmFsaXR5Lg0KPiA+IFBXTSBpcyBh
IHNpbXBsZSBkZXZpY2UgYW5kIG1vc3Qgb2YgaXRzIGNsaWVudHMgYXJlIGNvbnRyb2xsaW5nDQo+
IGludGVuc2l0eQ0KPiA+IG9mIGJhY2tsaWdodCwgbGVkcywgdmlicmF0b3IgZXRjLg0KPiA+IEkg
ZG9uJ3QgdGhpbmsgdGhlc2UgY29tcGxleCBmdW5jdGlvbmFsaXR5IGFyZSByZXF1aXJlZC4NCj4g
b2ggZGVhciAhDQpIZXJlIEkgbWVhbiB3aHkgc2hvdWxkIGFsbCB0aG9zZSBmdW5jdGlvbiBiZSBl
eHBvc2VkIHRvIHRoZSBlbnRpcmUga2VybmVsLA0KYXMgbW9zdCBvZiB0aGUgcHdtIGRldmljZXMg
ZG8gbm90IHVzZSB0aGVtLg0KDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpBcnVuIFIgTXVydGh5DQot
LS0tLS0tLS0tLS0NCg==
