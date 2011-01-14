From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Passing mem=1G to kernel on Panda, system is unstable.
Date: Fri, 14 Jan 2011 14:26:33 +0530
Message-ID: <842cdfd0907812989c0dfda45a25c5d3@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com> <641ab84b6cedfd62b9b6bedeae077f1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a53185ca8a0499ca9c34
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:44189 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751427Ab1ANI4g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Jan 2011 03:56:36 -0500
Received: by mail-fx0-f45.google.com with SMTP id 12so2774065fxm.18
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 00:56:35 -0800 (PST)
In-Reply-To: <641ab84b6cedfd62b9b6bedeae077f1b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

--20cf3054a53185ca8a0499ca9c34
Content-Type: text/plain; charset=ISO-8859-1

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Friday, January 14, 2011 1:43 PM
> To: Bryan Wu; linux-omap@vger.kernel.org; Ricardo Salveti de Araujo
> Subject: RE: Passing mem=1G to kernel on Panda, system is unstable.
>
> Bryan,
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Bryan Wu
> > Sent: Tuesday, January 11, 2011 10:22 PM
> > To: linux-omap@vger.kernel.org; Ricardo Salveti de Araujo
> > Subject: Passing mem=1G to kernel on Panda, system is unstable.
> >
> > Hi folks,
> >
> > We are trying to build kernel package or GCC natively on OMAP4
> panda
> > board. With the mainline 2.6.37 kernel or Ubuntu Natty 2.6.35
> based
> > kernel, we met same instabilities on the system when we try to use
> > mem=1G on the board.
> >
> > Please find our bug tracker here:
> > https://bugs.launchpad.net/ubuntu/+source/linux-ti-
> omap4/+bug/633227
> > and I think another bug is also related:
> > https://bugs.launchpad.net/ubuntu/+source/linux-ti-
> > omap4/+bug/690370.
> > System will freeze at all when building GCC natively on Panda.
> >
> > Did any folks meet this issue? or we need more simple test case to
> > catch the root cause of this issue.
> >
> Haven't seen this issue on my SDP with 2.6.37.
> Have you enabled HIGHMEM, when tried mem = 1G on 2.6.37 ?

This patch may not be relevant but last week while scanning
errata's I came across one which is applicable to OMAP4 ES2.x

Am attaching it. Please give a try. Have boot tested with latest
mainline tree.

Regards,
Santosh

--20cf3054a53185ca8a0499ca9c34
Content-Type: application/octet-stream;
	name="0001-ARM-l2x0-Errata-fix-for-flush-by-Way-operation-can.patch"
Content-Disposition: attachment;
	filename="0001-ARM-l2x0-Errata-fix-for-flush-by-Way-operation-can.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: dab28c0b595c2211_0.1

RnJvbSAzODQwNmRiZjBlZDNmNGIyNTM2OWRhZWE3ZDc5NzI5MmUwMGYzZjBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBGcmksIDE0IEphbiAyMDExIDE0OjE2OjA0ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gQVJNOiBsMngwOiBFcnJhdGEgZml4IGZvciBmbHVzaCBieSBXYXkgb3BlcmF0aW9uIGNh
biBjYXVzZSBkYXRhIGNvcnJ1cHRpb24KClBMMzEwIGltcGxlbWVudHMgdGhlIENsZWFuICYgSW52
YWxpZGF0ZSBieSBXYXkgTDIgY2FjaGUgbWFpbnRlbmFuY2UKb3BlcmF0aW9uIChvZmZzZXQgMHg3
RkMpLiBUaGlzIG9wZXJhdGlvbiBydW5zIGluIGJhY2tncm91bmQgc28gdGhhdApQTDMxMCBjYW4g
aGFuZGxlIG5vcm1hbCBhY2Nlc3NlcyB3aGlsZSBpdCBpcyBpbiBwcm9ncmVzcy4gVW5kZXIgdmVy
eQpyYXJlIGNpcmN1bXN0YW5jZXMsIGR1ZSB0byB0aGlzIGVycmF0dW0sIHdyaXRlIGRhdGEgY2Fu
IGJlIGxvc3Qgd2hlbgpQTDMxMCB0cmVhdHMgYSBjYWNoZWFibGUgd3JpdGUgdHJhbnNhY3Rpb24g
ZHVyaW5nIGEgQ2xlYW4gJiBJbnZhbGlkYXRlCmJ5IFdheSBvcGVyYXRpb24uCgpXb3JrYXJvdW5k
OgpEaXNhYmxlIFdyaXRlLUJhY2sgYW5kIENhY2hlIExpbmVmaWxsIChEZWJ1ZyBDb250cm9sIFJl
Z2lzdGVyKQpDbGVhbiAmIEludmFsaWRhdGUgYnkgV2F5ICgweDdGQykKUmUtZW5hYmxlIFdyaXRl
LUJhY2sgYW5kIENhY2hlIExpbmVmaWxsIChEZWJ1ZyBDb250cm9sIFJlZ2lzdGVyKQoKU2lnbmVk
LW9mZi1ieTogU2FudG9zaCBTaGlsaW1rYXIgPHNhbnRvc2guc2hpbGlta2FyQHRpLmNvbT4KLS0t
CiBhcmNoL2FybS9LY29uZmlnICAgICAgICAgICAgfCAgIDExICsrKysrKysrKysrCiBhcmNoL2Fy
bS9tYWNoLW9tYXAyL0tjb25maWcgfCAgICAxICsKIGFyY2gvYXJtL21tL2NhY2hlLWwyeDAuYyAg
ICB8ICAgMTYgKysrKysrKysrKy0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL0tjb25maWcgYi9hcmNo
L2FybS9LY29uZmlnCmluZGV4IDk2NzhlZTUuLmE3ZGZjMDUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJt
L0tjb25maWcKKysrIGIvYXJjaC9hcm0vS2NvbmZpZwpAQCAtMTE4MSw2ICsxMTgxLDE3IEBAIGNv
bmZpZyBBUk1fRVJSQVRBXzc0MzYyMgogCSAgdmlzaWJsZSBpbXBhY3Qgb24gdGhlIG92ZXJhbGwg
cGVyZm9ybWFuY2Ugb3IgcG93ZXIgY29uc3VtcHRpb24gb2YgdGhlCiAJICBwcm9jZXNzb3IuCiAK
K2NvbmZpZyBQTDMxMF9FUlJBVEFfNzI3OTE1CisJYm9vbCAiQmFja2dyb3VuZCBDbGVhbiAmIElu
dmFsaWRhdGUgYnkgV2F5IG9wZXJhdGlvbiBjYW4gY2F1c2UgZGF0YSBjb3JydXB0aW9uIgorCWRl
cGVuZHMgb24gQ0FDSEVfTDJYMCAmJiBBUkNIX09NQVA0CisJaGVscAorCSAgUEwzMTAgaW1wbGVt
ZW50cyB0aGUgQ2xlYW4gJiBJbnZhbGlkYXRlIGJ5IFdheSBMMiBjYWNoZSBtYWludGVuYW5jZQor
CSAgb3BlcmF0aW9uIChvZmZzZXQgMHg3RkMpLiBUaGlzIG9wZXJhdGlvbiBydW5zIGluIGJhY2tn
cm91bmQgc28gdGhhdAorCSAgUEwzMTAgY2FuIGhhbmRsZSBub3JtYWwgYWNjZXNzZXMgd2hpbGUg
aXQgaXMgaW4gcHJvZ3Jlc3MuIFVuZGVyIHZlcnkKKwkgIHJhcmUgY2lyY3Vtc3RhbmNlcywgZHVl
IHRvIHRoaXMgZXJyYXR1bSwgd3JpdGUgZGF0YSBjYW4gYmUgbG9zdCB3aGVuCisJICBQTDMxMCB0
cmVhdHMgYSBjYWNoZWFibGUgd3JpdGUgdHJhbnNhY3Rpb24gZHVyaW5nIGEgQ2xlYW4gJgorCSAg
SW52YWxpZGF0ZSBieSBXYXkgb3BlcmF0aW9uIE5vdGUgdGhhdCB0aGlzIGVycmF0YSB1c2VzIFRl
eGFzCisJICBJbnN0cnVtZW50J3Mgc2VjdXJlIG1vbml0b3IgYXBpIHRvIGltcGxlbWVudCB0aGUg
d29yayBhcm91bmQuCiBlbmRtZW51CiAKIHNvdXJjZSAiYXJjaC9hcm0vY29tbW9uL0tjb25maWci
CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL0tjb25maWcgYi9hcmNoL2FybS9tYWNo
LW9tYXAyL0tjb25maWcKaW5kZXggZDAyYTA2OC4uZDYzODBhNiAxMDA2NDQKLS0tIGEvYXJjaC9h
cm0vbWFjaC1vbWFwMi9LY29uZmlnCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvS2NvbmZpZwpA
QCAtNDYsNiArNDYsNyBAQCBjb25maWcgQVJDSF9PTUFQNAogCXNlbGVjdCBDUFVfVjcKIAlzZWxl
Y3QgQVJNX0dJQwogCXNlbGVjdCBQTDMxMF9FUlJBVEFfNTg4MzY5CisJc2VsZWN0IFBMMzEwX0VS
UkFUQV83Mjc5MTUgCiAJc2VsZWN0IEFSTV9FUlJBVEFfNzIwNzg5CiAJc2VsZWN0IEFSQ0hfSEFT
X09QUAogCXNlbGVjdCBQTV9PUFAgaWYgUE0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21tL2NhY2hl
LWwyeDAuYyBiL2FyY2gvYXJtL21tL2NhY2hlLWwyeDAuYwppbmRleCAxNzBjOWJiLi5jN2M4ZmJl
IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tbS9jYWNoZS1sMngwLmMKKysrIGIvYXJjaC9hcm0vbW0v
Y2FjaGUtbDJ4MC5jCkBAIC02Nyw3ICs2Nyw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsMngwX2lu
dl9saW5lKHVuc2lnbmVkIGxvbmcgYWRkcikKIAl3cml0ZWxfcmVsYXhlZChhZGRyLCBiYXNlICsg
TDJYMF9JTlZfTElORV9QQSk7CiB9CiAKLSNpZmRlZiBDT05GSUdfUEwzMTBfRVJSQVRBXzU4ODM2
OQorI2lmIGRlZmluZWQoQ09ORklHX1BMMzEwX0VSUkFUQV81ODgzNjkpIHx8IGRlZmluZWQoQ09O
RklHX1BMMzEwX0VSUkFUQV83Mjc5MTUpCiBzdGF0aWMgdm9pZCBkZWJ1Z193cml0ZWwodW5zaWdu
ZWQgbG9uZyB2YWwpCiB7CiAJZXh0ZXJuIHZvaWQgb21hcF9zbWMxKHUzMiBmbiwgdTMyIGFyZyk7
CkBAIC03OCw3ICs3OCwxNCBAQCBzdGF0aWMgdm9pZCBkZWJ1Z193cml0ZWwodW5zaWduZWQgbG9u
ZyB2YWwpCiAJICovCiAJb21hcF9zbWMxKDB4MTAwLCB2YWwpOwogfQorI2Vsc2UKKy8qIE9wdGlt
aXNlZCBvdXQgZm9yIG5vbi1lcnJhdGEgY2FzZSAqLworc3RhdGljIGlubGluZSB2b2lkIGRlYnVn
X3dyaXRlbCh1bnNpZ25lZCBsb25nIHZhbCkKK3sKK30KKyNlbmRpZgogCisjaWZkZWYgQ09ORklH
X1BMMzEwX0VSUkFUQV81ODgzNjkKIHN0YXRpYyBpbmxpbmUgdm9pZCBsMngwX2ZsdXNoX2xpbmUo
dW5zaWduZWQgbG9uZyBhZGRyKQogewogCXZvaWQgX19pb21lbSAqYmFzZSA9IGwyeDBfYmFzZTsK
QEAgLTkxLDExICs5OCw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsMngwX2ZsdXNoX2xpbmUodW5z
aWduZWQgbG9uZyBhZGRyKQogfQogI2Vsc2UKIAotLyogT3B0aW1pc2VkIG91dCBmb3Igbm9uLWVy
cmF0YSBjYXNlICovCi1zdGF0aWMgaW5saW5lIHZvaWQgZGVidWdfd3JpdGVsKHVuc2lnbmVkIGxv
bmcgdmFsKQotewotfQotCiBzdGF0aWMgaW5saW5lIHZvaWQgbDJ4MF9mbHVzaF9saW5lKHVuc2ln
bmVkIGxvbmcgYWRkcikKIHsKIAl2b2lkIF9faW9tZW0gKmJhc2UgPSBsMngwX2Jhc2U7CkBAIC0x
MTksOSArMTIxLDExIEBAIHN0YXRpYyB2b2lkIGwyeDBfZmx1c2hfYWxsKHZvaWQpCiAKIAkvKiBj
bGVhbiBhbGwgd2F5cyAqLwogCXNwaW5fbG9ja19pcnFzYXZlKCZsMngwX2xvY2ssIGZsYWdzKTsK
KwlkZWJ1Z193cml0ZWwoMHgwMyk7CiAJd3JpdGVsX3JlbGF4ZWQobDJ4MF93YXlfbWFzaywgbDJ4
MF9iYXNlICsgTDJYMF9DTEVBTl9JTlZfV0FZKTsKIAljYWNoZV93YWl0X3dheShsMngwX2Jhc2Ug
KyBMMlgwX0NMRUFOX0lOVl9XQVksIGwyeDBfd2F5X21hc2spOwogCWNhY2hlX3N5bmMoKTsKKwlk
ZWJ1Z193cml0ZWwoMHgwMCk7CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbDJ4MF9sb2NrLCBm
bGFncyk7CiB9CiAKLS0gCjEuNi4wLjQKCg==
--20cf3054a53185ca8a0499ca9c34--
