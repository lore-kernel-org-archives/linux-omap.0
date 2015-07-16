From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ARM: omap2: restore OMAP4 barrier behaviour
Date: Thu, 16 Jul 2015 14:54:13 +0100
Message-ID: <20150716135413.GD7576@n2100.arm.linux.org.uk>
References: <20150715174647.GA7557@n2100.arm.linux.org.uk>
 <E1ZFQmM-0006GN-5Y@rmk-PC.arm.linux.org.uk>
 <20150716064854.GG17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150716064854.GG17550@atomide.com>
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
Cc: linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

T24gV2VkLCBKdWwgMTUsIDIwMTUgYXQgMTE6NDg6NTRQTSAtMDcwMCwgVG9ueSBMaW5kZ3JlbiB3
cm90ZToKPiBIaSwKPiAKPiAqIFJ1c3NlbGwgS2luZyA8cm1rK2tlcm5lbEBhcm0ubGludXgub3Jn
LnVrPiBbMTUwNzE1IDEwOjUwXToKPiA+IFJlc3RvcmUgdGhlIE9NQVA0IGJhcnJpZXIgYmVoYXZp
b3VyIHVzaW5nIHRoZSBuZXcgaW1wbGVtZW50YXRpb24gd2hpY2gKPiA+IGFsbG93cyBtdWx0aXBs
YXRmb3JtIHN5c3RlbXMgdG8gaG9vayBpbnRvIHRoZSBtYigpIGFuZCB3bWIoKSBBUk0KPiA+IGlt
cGxlbWVudGF0aW9ucyB0byBwZXJmb3JtIGFueSBuZWNlc3NhcnkgYWRkaXRpb25hbCBiYXJyaWVy
IG1haW50YW5lbmNlLgo+IAo+IEknbSBnZXR0aGluZyB0aGlzIHdpdGggb21hcDJwbHVzX2RlZmNv
bmZpZyB3aXRoIHRoZSBsYXN0IHBhdGNoCj4gYXBwbGllZDoKPiAKPiBhcmNoL2FybS9tYWNoLW9t
YXAyL29tYXA0LWNvbW1vbi5jOiBJbiBmdW5jdGlvbiDigJhvbWFwNF9zcmFtX2luaXTigJk6Cj4g
YXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwNC1jb21tb24uYzoxMzg6MTQ6IGVycm9yOiBpbXBsaWNp
dCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhvZl9nZXRfbmFtZWRfZ2VuX3Bvb2zigJkgWy1X
ZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gICBzcmFtX3Bvb2wgPSBvZl9n
ZXRfbmFtZWRfZ2VuX3Bvb2wobnAsICJzcmFtIiwgMCk7Cj4gICAgICAgICAgICAgICBeCj4gYXJj
aC9hcm0vbWFjaC1vbWFwMi9vbWFwNC1jb21tb24uYzoxMzg6MTI6IHdhcm5pbmc6IGFzc2lnbm1l
bnQgbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3QgWy1XaW50LWNvbnZl
cnNpb25dCj4gICBzcmFtX3Bvb2wgPSBvZl9nZXRfbmFtZWRfZ2VuX3Bvb2wobnAsICJzcmFtIiwg
MCk7Cj4gICAgICAgICAgICAgXgoKSSdkIGZvcmdvdHRlbiB0byBtZXJnZSBpbiB0aGUgbWVyZ2Ug
d2luZG93IGZpeGVzIGZvciB0aGlzLi4uIHdoaWNoIGhhdmUgbm93CmJlZW4gbG9zdC4gIFRoaXMg
bmVlZHMgdG8gYmVjb21lIG9mX2dlbl9wb29sX2dldCgpIGluIDQuMi1yYzEgYW5kIGxhdGVyLgoK
LS0gCkZUVEMgYnJvYWRiYW5kIGZvciAwLjhtaWxlIGxpbmU6IGN1cnJlbnRseSBhdCAxMC41TWJw
cyBkb3duIDQwMGticHMgdXAKYWNjb3JkaW5nIHRvIHNwZWVkdGVzdC5uZXQuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
