From: GERBER Patrick <Patrick.Gerber@heig-vd.ch>
Subject: [Patch] Error when compiling without CONFIG_PM_DEBUG
Date: Fri, 1 Oct 2010 14:46:56 +0200
Message-ID: <8959501C0BAF9F40956CEBAD13FB297F17F38C757C@EINTMBX.einet.ad.eivd.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8959501C0BAF9F40956CEBAD13FB297F17F38C757CEINTMBXeineta_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailcl2.heig-vd.ch ([193.134.216.183]:59384 "EHLO heig-vd.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932069Ab0JAMq7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 08:46:59 -0400
Received: from [10.192.41.22] (helo=eintfe.einet.ad.eivd.ch)
	by heig-vd.ch stage1 with esmtp
	(Exim MailCleaner)
	id 1P1exd-0001JV-Qb
	for <linux-omap@vger.kernel.org>
	from <Patrick.Gerber@heig-vd.ch>; Fri, 01 Oct 2010 14:43:38 +0200
Content-Language: fr-CH
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_8959501C0BAF9F40956CEBAD13FB297F17F38C757CEINTMBXeineta_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

I have compiled a fresh clone of the linux-omap-2.6 kernel for overo and I =
have linker error.

The serial.c and pm34xx.c files used some variables declared as extern. The=
 real declaration of those variables are on pm-debug.c and are compiled onl=
y with CONFIG_PM_DEBUG.
So I have added some #ifdef to correct the error. I don't know if it's the =
best idea but anyway with the attached patch it's work.

Patrick

--_002_8959501C0BAF9F40956CEBAD13FB297F17F38C757CEINTMBXeineta_
Content-Type: application/octet-stream; name="pm_debug.patch"
Content-Description: pm_debug.patch
Content-Disposition: attachment; filename="pm_debug.patch"; size=1102;
	creation-date="Fri, 01 Oct 2010 14:46:04 GMT";
	modification-date="Fri, 01 Oct 2010 14:46:04 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvcG0zNHh4LmMgYi9hcmNoL2FybS9tYWNo
LW9tYXAyL3BtMzR4eC5jCmluZGV4IGQyYjk0MGMuLmE0MzQ0ZThkIDEwMDY0NAotLS0gYS9hcmNo
L2FybS9tYWNoLW9tYXAyL3BtMzR4eC5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvcG0zNHh4
LmMKQEAgLTQ3Niw4ICs0NzYsMTAgQEAgdm9pZCBvbWFwX3NyYW1faWRsZSh2b2lkKQogCiBpbnQg
b21hcDNfY2FuX3NsZWVwKHZvaWQpCiB7CisjaWZkZWYgQ09ORklHX1BNX0RFQlVHCiAJaWYgKCFz
bGVlcF93aGlsZV9pZGxlKQogCQlyZXR1cm4gMDsKKyNlbmRpZgogCWlmICghb21hcF91YXJ0X2Nh
bl9zbGVlcCgpKQogCQlyZXR1cm4gMDsKIAlyZXR1cm4gMTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtb21hcDIvc2VyaWFsLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3NlcmlhbC5jCmluZGV4
IDU2NmU5OTEuLjc3MGZiZjEgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvc2VyaWFs
LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9zZXJpYWwuYwpAQCAtMjI2LDggKzIyNiwxMCBA
QCBzdGF0aWMgdm9pZCBvbWFwX3VhcnRfc2F2ZV9jb250ZXh0KHN0cnVjdCBvbWFwX3VhcnRfc3Rh
dGUgKnVhcnQpCiAJdTE2IGxjciA9IDA7CiAJc3RydWN0IHBsYXRfc2VyaWFsODI1MF9wb3J0ICpw
ID0gdWFydC0+cDsKIAorI2lmZGVmIENPTkZJR19QTV9ERUJVRwogCWlmICghZW5hYmxlX29mZl9t
b2RlKQogCQlyZXR1cm47CisjZW5kaWYKIAogCWxjciA9IHNlcmlhbF9yZWFkX3JlZyhwLCBVQVJU
X0xDUik7CiAJc2VyaWFsX3dyaXRlX3JlZyhwLCBVQVJUX0xDUiwgMHhCRik7CkBAIC0yNTAsOCAr
MjUyLDEwIEBAIHN0YXRpYyB2b2lkIG9tYXBfdWFydF9yZXN0b3JlX2NvbnRleHQoc3RydWN0IG9t
YXBfdWFydF9zdGF0ZSAqdWFydCkKIAl1MTYgZWZyID0gMDsKIAlzdHJ1Y3QgcGxhdF9zZXJpYWw4
MjUwX3BvcnQgKnAgPSB1YXJ0LT5wOwogCisjaWZkZWYgQ09ORklHX1BNX0RFQlVHCiAJaWYgKCFl
bmFibGVfb2ZmX21vZGUpCiAJCXJldHVybjsKKyNlbmRpZgogCiAJaWYgKCF1YXJ0LT5jb250ZXh0
X3ZhbGlkKQogCQlyZXR1cm47Cg==

--_002_8959501C0BAF9F40956CEBAD13FB297F17F38C757CEINTMBXeineta_--
