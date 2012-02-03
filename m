From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
Date: Fri, 03 Feb 2012 09:54:07 -0800
Message-ID: <877h03ajls.fsf@ti.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
 <87obthcc57.fsf@ti.com>
 <CAMQu2gy2jDWszUAMDCfgyXsLNWUAb6phWpOP=7geFXTkc30S_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMQu2gy2jDWszUAMDCfgyXsLNWUAb6phWpOP=7geFXTkc30S_g@mail.gmail.com>
 (Santosh Shilimkar's message of "Fri, 3 Feb 2012 12:45:09 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

IlNoaWxpbWthciwgU2FudG9zaCIgPHNhbnRvc2guc2hpbGlta2FyQHRpLmNvbT4gd3JpdGVzOgoK
PiBPbiBGcmksIEZlYiAzLCAyMDEyIGF0IDEyOjEwIEFNLCBLZXZpbiBIaWxtYW4gPGtoaWxtYW5A
dGkuY29tPiB3cm90ZToKPj4gU2FudG9zaCBTaGlsaW1rYXIgPHNhbnRvc2guc2hpbGlta2FyQHRp
LmNvbT4gd3JpdGVzOgo+Pgo+Pj4gRnJvbTogUmFqZW5kcmEgTmF5YWsgPHJuYXlha0B0aS5jb20+
Cj4+Pgo+Pj4gaHdtb2Qgc2V0dXAgYWxyZWFkeSBkb2VzIGEgcmVzZXQgYW5kIHNldHMgdGhlIE9D
UCBzeXNjb25maWcKPj4+IHJlZ2lzdGVycyBhcHByb3ByaWF0ZWx5LiBBdm9pZCBkb2luZyBhIHJl
c2V0IGFnYWluIGFuZCBvdmVycmlkaW5nCj4+PiB0aGUgT0NQIHN5c2NvbmZpZyBzZXR0aW5ncyBp
biB0aGUgc3lzdGVtIHRpbWVyIGluaXQgY29kZS4KPj4KPj4gVGhhdCBpcyB0cnVlIGZvciBPTUFQ
NCwgYnV0IGhhdmUgeW91IHZlcmlmaWVkIGlmIHRoaXMgaXMgaW5kZWVkIGEKPj4gZHVwbGljYXRl
IHJlc2V0IG9uIMKgT01BUDIvMz8KPj4KPiBZZXMuIEl0IGlzIGR1cGxpY2F0ZSBmb3IgT01BUDIg
YW5kIE9NQVAzIGRldmljZXMgYXMgd2VsbC4KPiBBY3R1YWxseSB0aGlzIHNob3VsZCBoYXZlIGJl
ZW4gZml4ZWQgd2hlbiB0aGUgZHJpdmVyIHdhcwo+IGh3bW9kIGNvbnZlcnRlZCBidXQgc29tZSBo
b3cgZ290IG1pc3NlZC4gV2Ugbm90aWNlZAo+IGFuIGlzc3VlIG9uIE9NQVA1LCB3aGVuIHRpbWVy
IGludGVycnVwdHMgc3RvcHBlZCBmaXJpbmcgd2hlbgo+IGFsd2F5cyBvbiBjbG9jayBkb21haW4g
d2FzIGFsbG93ZWQgdG8gaWRsZS4gVGhpcyB3YXMgYmVjYXVzZQo+IHRoaXMgcmVzZXQgd2FzIGNs
ZWFyaW5nIHRoZSBjb3JyZWN0bHkgc2V0IHN5c2MgdmFsdWUgYnkgaHdtb2QuCj4KPiBUaGUgcGF0
Y2ggaXMgYWxzbyB0ZXN0ZWQgb24gWk9PTTMgKCBPTUFQMzYzMCkKPiBhbmQgT01BUDI0MzBTRFAu
CgpHcmVhdCwgdGhhbmtzIGZvciB0ZXN0aW5nIG9uIE9NQVAyLzMuCgpLZXZpbgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
