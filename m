From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 14/22] OMAP2+: voltage: split voltage controller (VC) code
	into dedicated layer
Date: Fri, 09 Sep 2011 14:51:40 -0700
Message-ID: <87vct1s7tf.fsf@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-15-git-send-email-khilman@ti.com>
	<CAORVsuWEZmChCjy8dJV+acosr_8N9XN0VL8-L6HWaKnZkoqqYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAORVsuWEZmChCjy8dJV+acosr_8N9XN0VL8-L6HWaKnZkoqqYA@mail.gmail.com>
	(Jean Pihet's message of "Wed, 7 Sep 2011 12:42:20 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

SmVhbiBQaWhldCA8amVhbi5waWhldEBuZXdvbGRiaXRzLmNvbT4gd3JpdGVzOgoKPiBLZXZpbiwK
Pgo+IE9uIE1vbiwgQXVnIDI5LCAyMDExIGF0IDc6MzUgUE0sIEtldmluIEhpbG1hbiA8a2hpbG1h
bkB0aS5jb20+IHdyb3RlOgo+PiBBcyBwYXJ0IG9mIHRoZSB2b2x0YWdlIGxheWVyIGNsZWFudXAs
IHNwbGl0IG91dCBWQyBzcGVjaWZpYyBjb2RlIGludG8KPj4gYSBkZWRpY2F0ZWQgVkMgbGF5ZXIu
IMKgVGhpcyBwYXRjaCBwcmltYXJpbHkganVzdCBtb3ZlcyBWQyBjb2RlIGZyb20KPj4gdm9sdGFn
ZS5jIGludG8gdmMuYywgYW5kIGFkZHMgcHJvdG90eXBlcyB0byB2Yy5oLgo+Pgo+PiBObyBmdW5j
dGlvbmFsIGNoYW5nZXMuCj4+Cj4+IEZvciByZWFkYWJpbGl0eSwgZWFjaCBmdW5jdGlvbiB3YXMg
Z2l2ZW4gYSBsb2NhbCAndmMnIHBvaW50ZXI6Cj4+Cj4+IMKgIMKgc3RydWN0IG9tYXBfdmNfaW5z
dGFuY2VfZGF0YSAqdmMgPSB2b2x0ZG0tPnZkZC0+dmNfZGF0YTsKPj4KPj4gYW5kIGEgZ2xvYmFs
IHJlcGxhY2Ugb2Ygcy92ZGQtPnZjX2RhdGEvdmMvIHdhcyBkb25lLgo+Pgo+PiBBbHNvIHZjX2lu
aXQgd2FzIHJlbmFtZWQgdG8gdmNfaW5pdF9jaGFubmVsIHRvIHJlZmxlY3QgdGhhdCB0aGlzIGlz
Cj4+IHBlci1WQyBjaGFubmVsIGluaXRpYWxpenRpb24uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEtl
dmluIEhpbG1hbiA8a2hpbG1hbkB0aS5jb20+Cj4+IC0tLQo+PiDCoGFyY2gvYXJtL21hY2gtb21h
cDIvTWFrZWZpbGUgwqB8IMKgIMKgMiArLQo+PiDCoGFyY2gvYXJtL21hY2gtb21hcDIvdmMuYyDC
oCDCoCDCoHwgwqAyNzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
Pj4gwqBhcmNoL2FybS9tYWNoLW9tYXAyL3ZjLmggwqAgwqAgwqB8IMKgIDEyICsrCj4+IMKgYXJj
aC9hcm0vbWFjaC1vbWFwMi92b2x0YWdlLmMgfCDCoDI2NCArLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPj4gwqA0IGZpbGVzIGNoYW5nZWQsIDI5MyBpbnNlcnRpb25zKCsp
LCAyNjEgZGVsZXRpb25zKC0pCj4+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gt
b21hcDIvdmMuYwo+Pgo+IC4uLgo+Cj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAy
L3ZjLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3ZjLmMKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQK
Pj4gaW5kZXggMDAwMDAwMC4uOThmNWE0Ygo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL2FyY2gv
YXJtL21hY2gtb21hcDIvdmMuYwo+PiBAQCAtMCwwICsxLDI3NiBAQAo+Cj4gVGhlIGNvcHlyaWdo
dCBub3RpY2UgaXMgbWlzc2luZy4KPgoKb29wcywgd2lsbCBhZGQuCgpUaGFua3MsCgpLZXZpbgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
