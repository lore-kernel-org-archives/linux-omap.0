From: Peter Chen <peter.chen@nxp.com>
Subject: RE: [PATCH] omapdrm: dss: drop unneeded of_node_put() on ref passed
 to of_get_next_parent()
Date: Mon, 29 Aug 2016 00:49:29 +0000
Message-ID: <HE1PR04MB145072749A2A9A771A9B9ED28BE10@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <20160826122321.4787-1-andrey_utkin@fastmail.com>
 <CAALWOA8hrtrGZKpLZCdASPWK001p41YOmvFObF=FYSi2zCSROw@mail.gmail.com>
 <CAALWOA-HbcmCLLdZV2U4EevKK+ujjQhq8MNfSk6K3y=EskjQpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAALWOA-HbcmCLLdZV2U4EevKK+ujjQhq8MNfSk6K3y=EskjQpg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Sean Paul <seanpaul@chromium.org>, Andrey Utkin <andrey_utkin@fastmail.com>
Cc: David Airlie <airlied@linux.ie>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Dave Airlie <airlied@gmail.com>, Rob Clark <robdclark@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Andrew Bradford <bradfa@gmail.com>, "kernel@pyra-handheld.com" <kernel@pyra-handheld.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, lkml <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

IA0KPlNlbnQ6IFNhdHVyZGF5LCBBdWd1c3QgMjcsIDIwMTYgODowNyBQTQ0KPlRvOiBUb21pIFZh
bGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPjsgVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9t
aWRlLmNvbT47DQo+U2VhbiBQYXVsIDxzZWFucGF1bEBjaHJvbWl1bS5vcmc+OyBQZXRlciBDaGVu
IDxwZXRlci5jaGVuQG54cC5jb20+Ow0KPkFuZHJleSBVdGtpbiA8YW5kcmV5X3V0a2luQGZhc3Rt
YWlsLmNvbT4NCj5DYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPjsgUGV0ZXIgVWpm
YWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT47IERhdmUNCj5BaXJsaWUgPGFpcmxpZWRAZ21h
aWwuY29tPjsgUm9iIENsYXJrIDxyb2JkY2xhcmtAZ21haWwuY29tPjsgRHIuIEguIE5pa29sYXVz
DQo+U2NoYWxsZXIgPGhuc0Bnb2xkZWxpY28uY29tPjsgQW5kcmV3IEJyYWRmb3JkIDxicmFkZmFA
Z21haWwuY29tPjsNCj5rZXJuZWxAcHlyYS1oYW5kaGVsZC5jb207IERpc2N1c3Npb25zIGFib3V0
IHRoZSBMZXR1eCBLZXJuZWwgPGxldHV4LQ0KPmtlcm5lbEBvcGVucGhvZW51eC5vcmc+OyBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBsa21sIDxsaW51eC0NCj5rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgbGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW1BB
VENIXSBvbWFwZHJtOiBkc3M6IGRyb3AgdW5uZWVkZWQgb2Zfbm9kZV9wdXQoKSBvbiByZWYgcGFz
c2VkIHRvDQo+b2ZfZ2V0X25leHRfcGFyZW50KCkNCj4NCj4+IFsgICAgOC44NDI4MDZdIE9GOiBF
UlJPUjogQmFkIG9mX25vZGVfcHV0KCkgb24gL2VuY29kZXIvcG9ydHMvcG9ydEAxL2VuZHBvaW50
DQo+PiBbICAgIDguODQzMDE0XSBbPGJmODg5NDMzPl0gKG9tYXBkc3Nfb2ZfZmluZF9zb3VyY2Vf
Zm9yX2ZpcnN0X2VwIFtvbWFwZHNzXSkNCj4NCj5JIGNhbiBjb25maXJtIHRoYXQgcmV2ZXJ0aW5n
IDJhYjlmNTg3OTE2MiBmaXhlcyB0aGlzIHJlZ3Jlc3Npb24sIHRlc3RlZCBvbiBvbWFwNS0NCj51
ZXZtLg0KPg0KDQpJdCB3YXMgbXkgY2FyZWxlc3MgZm9yIGludHJvZHVjaW5nIHJlZ3Jlc3Npb24u
IFRoZSByZXZlcnQgcGF0Y2ggaGFzIGFscmVhZHkgYmVlbg0KYXQgbGludXgtbmV4dC4gU29ycnkg
Zm9yIGluY29udmVuaWVuY2UuDQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9r
ZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0Lz9pZD01YTc4ZmY3YmY3ZTI1MTkx
MTQ0YjU1MDk2MTAwMWJiZjZjNzM0ZGE0DQoNCg0KUGV0ZXINCg==
