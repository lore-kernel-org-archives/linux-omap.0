From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: omap2: restore OMAP4 barrier behaviour
Date: Thu, 16 Jul 2015 22:48:42 -0700
Message-ID: <20150717054842.GS17550@atomide.com>
References: <20150715174647.GA7557@n2100.arm.linux.org.uk>
 <E1ZFQmM-0006GN-5Y@rmk-PC.arm.linux.org.uk>
 <20150716064854.GG17550@atomide.com>
 <20150716135413.GD7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150716135413.GD7576@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

KiBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXggPGxpbnV4QGFybS5saW51eC5vcmcudWs+IFsxNTA3
MTYgMDY6NTZdOgo+IE9uIFdlZCwgSnVsIDE1LCAyMDE1IGF0IDExOjQ4OjU0UE0gLTA3MDAsIFRv
bnkgTGluZGdyZW4gd3JvdGU6Cj4gPiBIaSwKPiA+IAo+ID4gKiBSdXNzZWxsIEtpbmcgPHJtaytr
ZXJuZWxAYXJtLmxpbnV4Lm9yZy51az4gWzE1MDcxNSAxMDo1MF06Cj4gPiA+IFJlc3RvcmUgdGhl
IE9NQVA0IGJhcnJpZXIgYmVoYXZpb3VyIHVzaW5nIHRoZSBuZXcgaW1wbGVtZW50YXRpb24gd2hp
Y2gKPiA+ID4gYWxsb3dzIG11bHRpcGxhdGZvcm0gc3lzdGVtcyB0byBob29rIGludG8gdGhlIG1i
KCkgYW5kIHdtYigpIEFSTQo+ID4gPiBpbXBsZW1lbnRhdGlvbnMgdG8gcGVyZm9ybSBhbnkgbmVj
ZXNzYXJ5IGFkZGl0aW9uYWwgYmFycmllciBtYWludGFuZW5jZS4KPiA+IAo+ID4gSSdtIGdldHRo
aW5nIHRoaXMgd2l0aCBvbWFwMnBsdXNfZGVmY29uZmlnIHdpdGggdGhlIGxhc3QgcGF0Y2gKPiA+
IGFwcGxpZWQ6Cj4gPiAKPiA+IGFyY2gvYXJtL21hY2gtb21hcDIvb21hcDQtY29tbW9uLmM6IElu
IGZ1bmN0aW9uIOKAmG9tYXA0X3NyYW1faW5pdOKAmToKPiA+IGFyY2gvYXJtL21hY2gtb21hcDIv
b21hcDQtY29tbW9uLmM6MTM4OjE0OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVu
Y3Rpb24g4oCYb2ZfZ2V0X25hbWVkX2dlbl9wb29s4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0
aW9uLWRlY2xhcmF0aW9uXQo+ID4gICBzcmFtX3Bvb2wgPSBvZl9nZXRfbmFtZWRfZ2VuX3Bvb2wo
bnAsICJzcmFtIiwgMCk7Cj4gPiAgICAgICAgICAgICAgIF4KPiA+IGFyY2gvYXJtL21hY2gtb21h
cDIvb21hcDQtY29tbW9uLmM6MTM4OjEyOiB3YXJuaW5nOiBhc3NpZ25tZW50IG1ha2VzIHBvaW50
ZXIgZnJvbSBpbnRlZ2VyIHdpdGhvdXQgYSBjYXN0IFstV2ludC1jb252ZXJzaW9uXQo+ID4gICBz
cmFtX3Bvb2wgPSBvZl9nZXRfbmFtZWRfZ2VuX3Bvb2wobnAsICJzcmFtIiwgMCk7Cj4gPiAgICAg
ICAgICAgICBeCj4gCj4gSSdkIGZvcmdvdHRlbiB0byBtZXJnZSBpbiB0aGUgbWVyZ2Ugd2luZG93
IGZpeGVzIGZvciB0aGlzLi4uIHdoaWNoIGhhdmUgbm93Cj4gYmVlbiBsb3N0LiAgVGhpcyBuZWVk
cyB0byBiZWNvbWUgb2ZfZ2VuX3Bvb2xfZ2V0KCkgaW4gNC4yLXJjMSBhbmQgbGF0ZXIuCgpPSyB3
aXRoIHRoYXQgY2hhbmdlIGxvb2tzIGdvb2QgdG8gbWUsIHNvIHBsZWFzZSBmZWVsIGZyZWUgdG8K
YWRkIGZvciB0aGUgd2hvbGUgc2VyaWVzOgoKQWNrZWQtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnlA
YXRvbWlkZS5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
