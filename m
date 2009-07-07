From: "Fischer Steven-P27614" <Steven.Fischer@motorola.com>
Subject: (unknown)
Date: Tue, 7 Jul 2009 08:53:57 -0400
Message-ID: <84FF2D40FEDEB74A98203E6EA01A4E1C059446C7@de01exm63.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C9FF01.F998507E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail119.messagelabs.com ([216.82.241.195]:47441 "EHLO
	mail119.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbZGGMyS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 08:54:18 -0400
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate4.mot.com (8.14.3/8.14.3) with ESMTP id n67CsKtN023039
	for <linux-omap@vger.kernel.org>; Tue, 7 Jul 2009 05:54:20 -0700 (MST)
Received: from il27vts02.mot.com (il27vts02.cig.mot.com [10.17.196.86])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id n67CsKwt024788
	for <linux-omap@vger.kernel.org>; Tue, 7 Jul 2009 07:54:20 -0500 (CDT)
Received: from de01exm63.ds.mot.com (de01exm63.am.mot.com [10.176.8.108])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id n67CsJYX024781
	for <linux-omap@vger.kernel.org>; Tue, 7 Jul 2009 07:54:19 -0500 (CDT)
Content-class: urn:content-classes:message
Subject: 
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9FF01.F998507E
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

All,
=20
The DSS2 code base seems to inadvertently prevent downscaling of video
overlay frames.  Attached is my attempt at a patch to resolve this
issue.
=20
As I gather from the code, there is an attempt to limit the overlay
output frame size (x, y, outw, outh) to the managers updated window
(mc->x, mc->y, mc->w, mc->h).  The problem is that the input frame size
(w & h) is being used to instead of the output frame size (outw, outh).
Due to this, when the input frame size is large than the output frame
size, the input frame is being cropped, thus no downscaling occurs.  My
patch corrects this issue and also attempts to properly scale the input
frame size if indeed the output frame is cropped.
=20
In my particular case, the output frame size is never cropped, so I have
not explicitly tested these equations, but I believe they are
mathematically correct.
=20
With this patch overlay downscaling is functional.
=20
Steve.

------_=_NextPart_001_01C9FF01.F998507E
Content-Type: application/octet-stream;
	name="0001-Proper-Scaling-Fix.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Proper-Scaling-Fix.patch
Content-Disposition: attachment;
	filename="0001-Proper-Scaling-Fix.patch"

RnJvbSA0MzE5MjcwODgxZThlOWEwOTE1YWVjMTQwYzFkOGI1ZjZjMjdjODc2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGaXNjaGVyIDxzdGV2ZW4uZmlzY2hlckBtb3Rvcm9s
YS5jb20+CkRhdGU6IFRodSwgMiBKdWwgMjAwOSAwOToyOToxMiAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIFByb3BlciBTY2FsaW5nIEZpeAoKLS0tCiBkcml2ZXJzL3ZpZGVvL29tYXAyL2Rzcy9tYW5h
Z2VyLmMgfCAgIDI0ICsrKysrKysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAx
OCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlk
ZW8vb21hcDIvZHNzL21hbmFnZXIuYyBiL2RyaXZlcnMvdmlkZW8vb21hcDIvZHNzL21hbmFnZXIu
YwppbmRleCAwYmUzNzBlLi4zZWQ5ZjNmIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL29tYXAy
L2Rzcy9tYW5hZ2VyLmMKKysrIGIvZHJpdmVycy92aWRlby9vbWFwMi9kc3MvbWFuYWdlci5jCkBA
IC03MDEsNiArNzAxLDggQEAgc3RhdGljIGludCBjb25maWd1cmVfb3ZlcmxheShlbnVtIG9tYXBf
cGxhbmUgcGxhbmUpCiAJc3RydWN0IG1hbmFnZXJfY2FjaGVfZGF0YSAqbWM7CiAJdTE2IG91dHcs
IG91dGg7CiAJdTE2IHgsIHksIHcsIGg7CisJdTMyIGR3ID0gMDsKKwl1MzIgZGggPSAwOwogCXUz
MiBwYWRkcjsKIAlpbnQgcjsKIApAQCAtNzcyLDE1ICs3NzQsMjUgQEAgc3RhdGljIGludCBjb25m
aWd1cmVfb3ZlcmxheShlbnVtIG9tYXBfcGxhbmUgcGxhbmUpCiAJCQl5ID0gYy0+cG9zX3kgLSBt
Yy0+eTsKIAkJfQogCi0JCWlmIChtYy0+dyA8ICh4K3cpKQotCQkJdyA9ICh4K3cpIC0gKG1jLT53
KTsKKwkJaWYgKG1jLT53IDwgKHgrb3V0dykpIHsKKwkJCWR3ID0gKHgrb3V0dykgLSAobWMtPncp
OworCQkJb3V0dyAtPSBkdzsKKwkJfQogCi0JCWlmIChtYy0+aCA8ICh5K2gpKQotCQkJaCA9ICh5
K2gpIC0gKG1jLT5oKTsKKwkJaWYgKG1jLT5oIDwgKHkrb3V0aCkpIHsKKwkJCWRoID0gKHkrb3V0
aCkgLSAobWMtPmgpOworCQkJb3V0aCAtPSBkaDsKKwkJfQogCiAJCWlmICghZGlzcGNfaXNfb3Zl
cmxheV9zY2FsZWQoYykpIHsKLQkJCW91dHcgPSB3OwotCQkJb3V0aCA9IGg7CisJCQl3ID0gb3V0
dzsKKwkJCWggPSBvdXRoOworCQl9IGVsc2UgeworCQkJaWYgKGR3KQorCQkJCXcgLT0gKHUxNikg
KCgoKGR3IDw8IDE2KSAvIHcpICogb3V0dykgPj4gMTYpOworCisJCQlpZiAoZGgpCisJCQkJaCAt
PSAodTE2KSAoKCgoZGggPDwgMTYpIC8gaCkgKiBvdXRoKSA+PiAxNik7CiAJCX0KIAl9CiAKLS0g
CjEuNS40LjMKCg==

------_=_NextPart_001_01C9FF01.F998507E--
