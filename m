From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH -next] ARM: dts: omap5: replace gpio-key,wakeup with
 wakeup-source property
Date: Thu, 17 Nov 2016 15:32:12 +0000
Message-ID: <8d06724a-98af-05ab-f5a8-07c552722fca@arm.com>
References: <1479138250-17780-1-git-send-email-sudeep.holla@arm.com>
 <20161117152717.GS4082@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161117152717.GS4082@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-omap@vger.kernel.org

CgpPbiAxNy8xMS8xNiAxNToyNywgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPiAqIFN1ZGVlcCBIb2xs
YSA8c3VkZWVwLmhvbGxhQGFybS5jb20+IFsxNjExMTQgMDc6NDRdOgo+PiBUaG91Z2ggdGhlIGtl
eWJvYXJkIGRyaXZlciBmb3IgR1BJTyBidXR0b25zKGdwaW8ta2V5cykgd2lsbCBjb250aW51ZSB0
bwo+PiBjaGVjayBmb3Ivc3VwcG9ydCB0aGUgbGVnYWN5ICJncGlvLWtleSx3YWtldXAiIGJvb2xl
YW4gcHJvcGVydHkgdG8KPj4gZW5hYmxlIGdwaW8gYnV0dG9ucyBhcyB3YWtldXAgc291cmNlLCAi
d2FrZXVwLXNvdXJjZSIgaXMgdGhlIG5ldwo+PiBzdGFuZGFyZCBiaW5kaW5nLgo+Pgo+PiBUaGlz
IHBhdGNoIHJlcGxhY2VzIHRoZSBsZWdhY3kgImdwaW8ta2V5LHdha2V1cCIgd2l0aCB0aGUgdW5p
ZmllZAo+PiAid2FrZXVwLXNvdXJjZSIgcHJvcGVydHkgaW4gb3JkZXIgdG8gYXZvaWQgYW55IGZ1
cnRoZXIgY29weS1wYXN0ZQo+PiBkdXBsaWNhdGlvbi4KPj4KPj4gQ2M6ICJCZW5vw650IENvdXNz
b24iIDxiY291c3NvbkBiYXlsaWJyZS5jb20+Cj4+IENjOiBUb255IExpbmRncmVuIDx0b255QGF0
b21pZGUuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBh
cm0uY29tPgo+PiAtLS0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL29tYXA1LXVldm0uZHRzIHwgMiAr
LQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+
IEhpLAo+Pgo+PiBJbnNwaXRlIG9mIGdldHRpbmcgcmlkIG9mIG1vc3Qgb2YgdGhlIGxlZ2FjeSBw
cm9wZXJ0eSBhbG1vc3QgYSB5ZWFyIGFnbywKPj4gYWRkaXRpb24gb2YgbmV3IHBsYXRmb3JtcyBo
YXZlIGJyb3VnaHQgdGhpcyBiYWNrIGFuZCBvdmVyIHRpbWUgaXQncwo+PiBub3cgZm91bmQgYWdh
aW4gaW4gZmV3IHBsYWNlcy4gSnVzdCBnZXQgcmlkIG9mIHRoZW0gKmFnYWluKgo+Cj4gVGhhbmtz
IGZvciB0aGUgYW5udWFsIGNoZWNrIHVwIDopCj4KPiBBY2tlZC1ieTogVG9ueSBMaW5kZ3JlbiA8
dG9ueUBhdG9taWRlLmNvbT4KPgo+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugd2FudCBtZSB0
byBwaWNrIHRoaXMgdXAgaW5zdGVhZC4KClllcyB0aGF0IHdvdWxkIGJlIGJldHRlci4gQWxzbyBp
dCdzIHByZXNlbnQgb25seSBpbiB5b3VyIC1uZXh0LApsb29rcyBsaWtlIHNvbWV0aGluZyBuZXds
eSBhZGRlZCB2aWEgY29tbWl0IDJkNDZjMGM2MDcyNSAoIkFSTToKZHRzOiBvbWFwNSB1ZXZtOiBh
ZGQgVVNSMSBidXR0b24iKQoKLS0gClJlZ2FyZHMsClN1ZGVlcAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
