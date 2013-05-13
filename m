From: jean-philippe francois <jp.francois@cynove.com>
Subject: [PATCH] ARM: OMAP: fix __init section mismatch for _enable_preprogram
Date: Mon, 13 May 2013 11:28:38 +0200
Message-ID: <CAGGh5h1_-zbe=gw+YtMeddGxGkVzos=siavOv9nbSOVZqk1nVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0141a20242dd7b04dc9624b1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:47545 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab3EMJ2j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 May 2013 05:28:39 -0400
Received: by mail-we0-f182.google.com with SMTP id t60so6053175wes.41
        for <linux-omap@vger.kernel.org>; Mon, 13 May 2013 02:28:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

--089e0141a20242dd7b04dc9624b1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

_enable_preprogram is marked as __init, but is called from _enable
which is not. Without this patch, the board oopses after init. Tested
on custom hardware and on beagle board xM.

Signed-off-by: Jean-Philippe Fran=C3=A7ois <jp.francois@cynove.com>

--089e0141a20242dd7b04dc9624b1
Content-Type: application/octet-stream; name="omap_hwmod_fix.patch"
Content-Disposition: attachment; filename="omap_hwmod_fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgng7rxb0

SW5kZXg6IGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kLmMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0g
YS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2QuYworKysgYi9hcmNoL2FybS9tYWNoLW9t
YXAyL29tYXBfaHdtb2QuYwpAQCAtMjA2Niw3ICsyMDY2LDcgQEAKICAqIGRvIHNvIGlzIHByZXNl
bnQgaW4gdGhlIGh3bW9kIGRhdGEsIHRoZW4gY2FsbCBpdCBhbmQgcGFzcyBhbG9uZyB0aGUKICAq
IHJldHVybiB2YWx1ZTsgb3RoZXJ3aXNlLCByZXR1cm4gMC4KICAqLwotc3RhdGljIGludCBfX2lu
aXQgX2VuYWJsZV9wcmVwcm9ncmFtKHN0cnVjdCBvbWFwX2h3bW9kICpvaCkKK3N0YXRpYyBpbnQg
X2VuYWJsZV9wcmVwcm9ncmFtKHN0cnVjdCBvbWFwX2h3bW9kICpvaCkKIHsKIAlpZiAoIW9oLT5j
bGFzcy0+ZW5hYmxlX3ByZXByb2dyYW0pCiAJCXJldHVybiAwOwo=
--089e0141a20242dd7b04dc9624b1--
