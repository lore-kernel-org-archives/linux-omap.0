From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv2 1/2] ads7846: OMAP3: Removal of warnings backtrace in
	bootup
Date: Thu, 3 Feb 2011 12:32:38 +0100
Message-ID: <19786.37462.662253.3644@ipc1.ka-ro>
References: <1296726514-32146-1-git-send-email-sourav.poddar@ti.com>
	<4D4A7F13.8080502@compulab.co.il> <4D4A80D3.2060407@compulab.co.il>
	<AANLkTi=U1qo=udB=tMyuA2HcnCS4EmreaVDbw2vQ9dY8@mail.gmail.com>
	<4D4A8DA0.1010806@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4D4A8DA0.1010806@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: dmitry.torokhov@gmail.com, balbi@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, charu@ti.com, linux-input@vger.kernel.org, "Poddar,
	Sourav" <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com
List-Id: linux-omap@vger.kernel.org

SGksCgpJZ29yIEdyaW5iZXJnIHdyaXRlczoKPiAKPiAKPiBPbiAwMi8wMy8xMSAxMzowMCwgUG9k
ZGFyLCBTb3VyYXYgd3JvdGU6Cj4gCj4gPiBPbiBUaHUsIEZlYiAzLCAyMDExIGF0IDM6NDcgUE0s
IElnb3IgR3JpbmJlcmcgPGdyaW5iZXJnQGNvbXB1bGFiLmNvLmlsPiB3cm90ZToKPiA+PiBpZiAo
cGRhdGEtPmdldF9wZW5kb3duX3N0YXRlKSB7Cj4gPj4gICAgICAgIHRzLT5nZXRfcGVuZG93bl9z
dGF0ZSA9IHBkYXRhLT5nZXRfcGVuZG93bl9zdGF0ZTsKPiA+PiAgICAgICAgdHMtPmdwaW9fcGVu
ZG93biA9IC0xOwo+ID4+ICAgICAgICByZXR1cm4gMDsKPiA+PiB9Cj4gPiBZZXMgd2UgY2FuIGRv
IHNvIC5JIGluaXRpYWxpc2UgaXQgYXQgYSBwbGFjZSB3aGVyZSBvdGhlciB2YXJpYWJsZXMKPiA+
ICB3aGVyZSBpbml0aWFsaXNlZC4KPiA+Cj4gPj4+IEFsc28sIHdoeSBkb24ndCB3ZSB1c2UgLUVJ
TlZBTCBmb3IgdGhlIGludmFsaWQgZ3BpbyBudW1iZXIgaW5zdGVhZCBvZiAtMSBjb25zdGFudD8K
PiA+Pj4KPiA+ICBJIHVzZWQgLTEgYmVjYXVzZSBjb25kaXRpb25hbCBjaGVjayBkb25lIGluIHBy
b2JlIGFkczc4NDZfcHJvYmUgZnVuY3Rpb24KPiA+ICB1c2VkIHRoaXMgdmFsdWUuCj4gPgo+ID4g
ICBlcnJfZnJlZV9ncGlvOgo+ID4gICAgICAgICBpZiAodHMtPmdwaW9fcGVuZG93biAhPSAtMSkK
PiA+ICAgICAgICAgICAgICAgICBncGlvX2ZyZWUodHMtPmdwaW9fcGVuZG93bik7Cj4gPgo+IAo+
IFdlbGwgSSB1bmRlcnN0YW5kIHRoYXQgYW5kIHRoYXQncyB3aHkgaW4gbXkgcHJvcG9zYWwgSSB1
c2VkIC0xIGFsc28sIGJ1dAo+IEkgdGhvdWdodCB3ZSBjYW4gbWFrZSBpdCBldmVuIGJldHRlciBp
ZiB3ZSBzd2l0Y2ggdG8gLUVJTlZBTAo+ICh0aG91Z2ggd2FudGVkIHRvIGNoZWNrIGlmIHRoZXJl
IGFyZSBhbnkgcmVhc29uYWJsZSBvYmplY3Rpb25zKQo+IGFuZCB3aGlsZSB5b3UgYXJlIGF0IHRo
aXMsIG1heSBiZSB5b3UgYXJlIHdpbGxpbmcgYWxzbyB0byBzdWJtaXQgYSBwYXRjaCBmb3IgdGhp
cz8KPiAKU2luY2UgdHMtPmdwaW9fcGVuZG93biBpcyB1c2VkIGFzIGEgR1BJTyBudW1iZXIsIHRo
ZSBjaGVjayB3aXRoCmdwaW9faXNfdmFsaWQoKSwgYXMgc3VnZ2VzdGVkIGJ5IEZlbGlwZSBCYWxi
aSwgd291bGQgYmUgdGhlIG1vc3QKc2Vuc2libGUgdGhpbmcgdG8gZG8gaGVyZS4KCgpMb3RoYXIg
V2HDn21hbm4KLS0gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCgpLYS1SbyBlbGVjdHJvbmljcyBHbWJIIHwgUGFzY2Fsc3RyYcOfZSAy
MiB8IEQgLSA1MjA3NiBBYWNoZW4KUGhvbmU6ICs0OSAyNDA4IDE0MDItMCB8IEZheDogKzQ5IDI0
MDggMTQwMi0xMApHZXNjaMOkZnRzZsO8aHJlcjogTWF0dGhpYXMgS2F1c3NlbgpIYW5kZWxzcmVn
aXN0ZXJlaW50cmFnOiBBbXRzZ2VyaWNodCBBYWNoZW4sIEhSQiA0OTk2Cgp3d3cua2Fyby1lbGVj
dHJvbmljcy5kZSB8IGluZm9Aa2Fyby1lbGVjdHJvbmljcy5kZQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
