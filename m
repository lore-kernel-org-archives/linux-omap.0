From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH -next] ARM: dts: omap5: replace gpio-key,wakeup with
 wakeup-source property
Date: Thu, 17 Nov 2016 07:47:01 -0800
Message-ID: <20161117154700.GT4082@atomide.com>
References: <1479138250-17780-1-git-send-email-sudeep.holla@arm.com>
 <20161117152717.GS4082@atomide.com>
 <8d06724a-98af-05ab-f5a8-07c552722fca@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <8d06724a-98af-05ab-f5a8-07c552722fca@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

KiBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPiBbMTYxMTE3IDA3OjMyXToKPiAK
PiAKPiBPbiAxNy8xMS8xNiAxNToyNywgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPiA+ICogU3VkZWVw
IEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4gWzE2MTExNCAwNzo0NF06Cj4gPiA+IFRob3Vn
aCB0aGUga2V5Ym9hcmQgZHJpdmVyIGZvciBHUElPIGJ1dHRvbnMoZ3Bpby1rZXlzKSB3aWxsIGNv
bnRpbnVlIHRvCj4gPiA+IGNoZWNrIGZvci9zdXBwb3J0IHRoZSBsZWdhY3kgImdwaW8ta2V5LHdh
a2V1cCIgYm9vbGVhbiBwcm9wZXJ0eSB0bwo+ID4gPiBlbmFibGUgZ3BpbyBidXR0b25zIGFzIHdh
a2V1cCBzb3VyY2UsICJ3YWtldXAtc291cmNlIiBpcyB0aGUgbmV3Cj4gPiA+IHN0YW5kYXJkIGJp
bmRpbmcuCj4gPiA+IAo+ID4gPiBUaGlzIHBhdGNoIHJlcGxhY2VzIHRoZSBsZWdhY3kgImdwaW8t
a2V5LHdha2V1cCIgd2l0aCB0aGUgdW5pZmllZAo+ID4gPiAid2FrZXVwLXNvdXJjZSIgcHJvcGVy
dHkgaW4gb3JkZXIgdG8gYXZvaWQgYW55IGZ1cnRoZXIgY29weS1wYXN0ZQo+ID4gPiBkdXBsaWNh
dGlvbi4KPiA+ID4gCj4gPiA+IENjOiAiQmVub8OudCBDb3Vzc29uIiA8YmNvdXNzb25AYmF5bGli
cmUuY29tPgo+ID4gPiBDYzogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4KPiA+ID4g
U2lnbmVkLW9mZi1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4KPiA+ID4g
LS0tCj4gPiA+ICBhcmNoL2FybS9ib290L2R0cy9vbWFwNS11ZXZtLmR0cyB8IDIgKy0KPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4gPiAKPiA+
ID4gSGksCj4gPiA+IAo+ID4gPiBJbnNwaXRlIG9mIGdldHRpbmcgcmlkIG9mIG1vc3Qgb2YgdGhl
IGxlZ2FjeSBwcm9wZXJ0eSBhbG1vc3QgYSB5ZWFyIGFnbywKPiA+ID4gYWRkaXRpb24gb2YgbmV3
IHBsYXRmb3JtcyBoYXZlIGJyb3VnaHQgdGhpcyBiYWNrIGFuZCBvdmVyIHRpbWUgaXQncwo+ID4g
PiBub3cgZm91bmQgYWdhaW4gaW4gZmV3IHBsYWNlcy4gSnVzdCBnZXQgcmlkIG9mIHRoZW0gKmFn
YWluKgo+ID4gCj4gPiBUaGFua3MgZm9yIHRoZSBhbm51YWwgY2hlY2sgdXAgOikKPiA+IAo+ID4g
QWNrZWQtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+Cj4gPiAKPiA+IFBsZWFz
ZSBsZXQgbWUga25vdyBpZiB5b3Ugd2FudCBtZSB0byBwaWNrIHRoaXMgdXAgaW5zdGVhZC4KPiAK
PiBZZXMgdGhhdCB3b3VsZCBiZSBiZXR0ZXIuIEFsc28gaXQncyBwcmVzZW50IG9ubHkgaW4geW91
ciAtbmV4dCwKPiBsb29rcyBsaWtlIHNvbWV0aGluZyBuZXdseSBhZGRlZCB2aWEgY29tbWl0IDJk
NDZjMGM2MDcyNSAoIkFSTToKPiBkdHM6IG9tYXA1IHVldm06IGFkZCBVU1IxIGJ1dHRvbiIpCgpP
SyBhcHBsaWVkIGludG8gb21hcC1mb3ItdjQuMTAvZHQ6b21hcC1mb3ItdjQuMTAvZHQgdGhhbmtz
LgoKVG9ueQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
