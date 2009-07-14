From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/4] DSPBRIDGE: Fix macros that break when inside an
 if/else
Date: Tue, 14 Jul 2009 23:22:45 +0300 (EEST)
Message-ID: <20090714.232245.246532819.Hiroshi.DOYU@nokia.com>
References: <1247570430.13580.16.camel@pcarmody-desktop>
	<20090714.153035.258117413.Hiroshi.DOYU@nokia.com>
	<1247577445.13580.47.camel@pcarmody-desktop>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Tue_Jul_14_23_22_45_2009_641)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32895 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbZGNUX0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 16:23:26 -0400
In-Reply-To: <1247577445.13580.47.camel@pcarmody-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-phil.2.carmody@nokia.com
Cc: nm@ti.com, x0095840@ti.com, ameya.palande@nokia.com, linux-omap@vger.kernel.org, h-kanigeri2@ti.com

----Next_Part(Tue_Jul_14_23_22_45_2009_641)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>
Subject: Re: [PATCH 1/4] DSPBRIDGE: Fix macros that break when inside an if/else
Date: Tue, 14 Jul 2009 15:17:25 +0200

[...]
> > I am not sure if these copy_from_user() wrapping are practically
> > useful or not. It may be enough just to use kernel API as is. But if
> > there are some reason to requires strict parameter checkings or
> > debugging feature support for these family here, introducing inline
> > functions for them, instead of macro, may be another option?
> 
> I did mention that possibility to Ameya. In the 21st century, I think we
> should be able to trust the compiler to generate identical code from
> inline functions as functional macros. (Are we allowed to use 'restrict'
> pointers?)

I tried to create the attached patch.

----Next_Part(Tue_Jul_14_23_22_45_2009_641)--
Content-Type: Application/Octet-Stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-DSPBRIDGE-fix-macros-that-break-when-inside-an-if-e.patch"

RnJvbSBhNGE5MzgwZjI1ZThkOTQ0N2MwMmI4MTQ0MGI1OWQ4NzYyOGVlYzE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIaXJvc2hpIERPWVUgPEhpcm9zaGkuRE9ZVUBub2tpYS5jb20+
CkRhdGU6IFR1ZSwgMTQgSnVsIDIwMDkgMjI6Mjc6NDQgKzAzMDAKU3ViamVjdDogW1BBVENIIDEv
MV0gRFNQQlJJREdFOiBmaXggbWFjcm9zIHRoYXQgYnJlYWsgd2hlbiBpbnNpZGUgYW4gaWYvZWxz
ZQoKQmFzZWQgb24gdGhlIGZvbGxvd2luZyBkaXNjdXNzaW9uOgogICAgICBodHRwOi8vbWFyYy5p
bmZvLz9sPWxpbnV4LW9tYXAmbT0xMjQ2OTc4OTM3MjQ4ODEmdz0yCgpTaWduZWQtb2ZmLWJ5OiBI
aXJvc2hpIERPWVUgPEhpcm9zaGkuRE9ZVUBub2tpYS5jb20+Ci0tLQogZHJpdmVycy9kc3AvYnJp
ZGdlL3BtZ3Ivd2NkLmMgfCAgIDYwICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kc3AvYnJpZGdlL3BtZ3Ivd2NkLmMgYi9kcml2ZXJzL2Rz
cC9icmlkZ2UvcG1nci93Y2QuYwppbmRleCA4NjgxMmM2Li40MzA5NjBiIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2RzcC9icmlkZ2UvcG1nci93Y2QuYworKysgYi9kcml2ZXJzL2RzcC9icmlkZ2UvcG1n
ci93Y2QuYwpAQCAtMTQ1LDI3ICsxNDUsNDUgQEAKICNkZWZpbmUgTUFYX1NUUkVBTVMgICAgIDE2
CiAjZGVmaW5lIE1BWF9CVUZTCTY0CiAKLS8qIEZvbGxvd2luZyB0d28gbWFjcm9zIHNob3VsZCBp
ZGVhbGx5IGhhdmUgZG97fXdoaWxlKDApICovCi0KLSNkZWZpbmUgY3BfZm1fdXNyKGRlc3QsIHNy
Yywgc3RhdHVzLCBlbGVtZW50cykgICAgXAotICAgIGlmIChEU1BfU1VDQ0VFREVEKHN0YXR1cykp
IHtcCi0JICAgIGlmICh1bmxpa2VseShzcmMgPT0gTlVMTCkgfHwJCQkJXAotCQl1bmxpa2VseShj
b3B5X2Zyb21fdXNlcihkZXN0LCBzcmMsIGVsZW1lbnRzICogc2l6ZW9mKCooZGVzdCkpKSkpIHsg
XAotCQlHVF8xdHJhY2UoV0NEX2RlYnVnTWFzaywgR1RfN0NMQVNTLCBcCi0JCSJjb3B5X2Zyb21f
dXNlciBmYWlsZWQsIHNyYz0weCV4XG4iLCBzcmMpOyAgXAotCQlzdGF0dXMgPSBEU1BfRVBPSU5U
RVIgOyBcCi0JfSBcCi0gICAgfQotCi0jZGVmaW5lIGNwX3RvX3VzcihkZXN0LCBzcmMsIHN0YXR1
cywgZWxlbWVudHMpICAgIFwKLSAgICBpZiAoRFNQX1NVQ0NFRURFRChzdGF0dXMpKSB7XAotCSAg
ICBpZiAodW5saWtlbHkoZGVzdCA9PSBOVUxMKSB8fAkJCQlcCi0JCXVubGlrZWx5KGNvcHlfdG9f
dXNlcihkZXN0LCBzcmMsIGVsZW1lbnRzICogc2l6ZW9mKCooc3JjKSkpKSkgeyBcCi0JCUdUXzF0
cmFjZShXQ0RfZGVidWdNYXNrLCBHVF83Q0xBU1MsIFwKLQkJImNvcHlfdG9fdXNlciBmYWlsZWQs
IGRlc3Q9MHgleFxuIiwgZGVzdCk7IFwKLQkJc3RhdHVzID0gRFNQX0VQT0lOVEVSIDtcCi0JfSBc
Ci0gICAgfQorc3RhdGljIGlubGluZSB2b2lkIF9fY3BfZm1fdXNyKHZvaWQgKnRvLCBjb25zdCB2
b2lkIF9fdXNlciAqZnJvbSwKKwkJCSAgICAgICBEU1BfU1RBVFVTICplcnIsIHVuc2lnbmVkIGxv
bmcgYnl0ZXMpCit7CisJaWYgKERTUF9GQUlMRUQoKmVycikpCisJCXJldHVybjsKKworCWlmICh1
bmxpa2VseSghZnJvbSkpIHsKKwkJKmVyciA9IERTUF9FUE9JTlRFUjsKKwkJcmV0dXJuOworCX0K
KworCWlmICh1bmxpa2VseShjb3B5X2Zyb21fdXNlcih0bywgZnJvbSwgYnl0ZXMpKSkgeworCQlH
VF8ydHJhY2UoV0NEX2RlYnVnTWFzaywgR1RfN0NMQVNTLAorCQkJICAiJXMgZmFpbGVkLCBmcm9t
PTB4JTA4eFxuIiwgX19mdW5jX18sIGZyb20pOworCQkqZXJyID0gRFNQX0VQT0lOVEVSOworCX0K
K30KKyNkZWZpbmUgY3BfZm1fdXNyKHRvLCBmcm9tLCBlcnIsIG4pCQkJCVwKKwlfX2NwX2ZtX3Vz
cih0bywgZnJvbSwgJihlcnIpLCAobikgKiBzaXplb2YoKih0bykpKQorCitzdGF0aWMgaW5saW5l
IHZvaWQgX19jcF90b191c3Iodm9pZCBfX3VzZXIgKnRvLCBjb25zdCB2b2lkICpmcm9tLAorCQkJ
ICAgICAgIERTUF9TVEFUVVMgKmVyciwgdW5zaWduZWQgbG9uZyBieXRlcykKK3sKKwlpZiAoRFNQ
X0ZBSUxFRCgqZXJyKSkKKwkJcmV0dXJuOworCisJaWYgKHVubGlrZWx5KCF0bykpIHsKKwkJKmVy
ciA9IERTUF9FUE9JTlRFUjsKKwkJcmV0dXJuOworCX0KKworCWlmICh1bmxpa2VseShjb3B5X3Rv
X3VzZXIodG8sIGZyb20sIGJ5dGVzKSkpIHsKKwkJR1RfMnRyYWNlKFdDRF9kZWJ1Z01hc2ssIEdU
XzdDTEFTUywKKwkJCSAgIiVzIGZhaWxlZCwgdG89MHglMDh4XG4iLCBfX2Z1bmNfXywgdG8pOwor
CQkqZXJyID0gRFNQX0VQT0lOVEVSOworCX0KK30KKyNkZWZpbmUgY3BfdG9fdXNyKHRvLCBmcm9t
LCBlcnIsIG4pCQkJCVwKKwlfX2NwX3RvX3Vzcih0bywgZnJvbSwgJihlcnIpLCAobikgKiBzaXpl
b2YoKihmcm9tKSkpCiAKIC8qIERldmljZSBJT0N0bCBmdW5jdGlvbiBwb2ludGVyICovCiBzdHJ1
Y3QgV0NEX0NtZCB7Ci0tIAoxLjYuMC40Cgo=

----Next_Part(Tue_Jul_14_23_22_45_2009_641)----
