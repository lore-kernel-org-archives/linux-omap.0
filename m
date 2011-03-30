From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: Smartreflex on 'pm-wip/voltdm' Branch
Date: Wed, 30 Mar 2011 11:51:48 +0530
Message-ID: <AANLkTinHsk0dSKVwTK4DMYn+wmLnxXFxQkbRUREa2REy@mail.gmail.com>
References: <AANLkTi=czLooLOFEZq-TYKLOqwFxn8eB6aTs7-3k_YSY@mail.gmail.com>
	<e3b58bb0f126f8849c7358c8f7e67222@mail.gmail.com>
	<874o6nky7a.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015173fe9ba0ec3f6049fad312e
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37968 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753126Ab1C3GVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 02:21:50 -0400
Received: by mail-bw0-f51.google.com with SMTP id 10so967759bwz.24
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 23:21:48 -0700 (PDT)
In-Reply-To: <874o6nky7a.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org

--0015173fe9ba0ec3f6049fad312e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 28, 2011 at 9:57 PM, Kevin Hilman <khilman@ti.com> wrote:
> Vishwa, Shweta,
>
> Vishwanath Sripathy <vishwanath.bs@ti.com> writes:
>
> [...]
>
>>> I am testing Smartreflex on your Branch 'pm-wip/voltdm'. There seems
>>> an issue with reading VP registers.
>>> For OMAP3 and OMAP4 reading debugfs entries shows constant voltage.
>
> Thanks for testing.
>
> [...]
>
>> I did a quick debug on this and found that the root cause of the issue i=
s
>> in usage of ffs (because of this, i2c slave address was configured wrong=
ly
>> in vc).
>> Basically ffs returns the position of the first (least significant) bit
>> set in the word and the least significant bit is position 1 where as our
>> bit operation assumes that least significant position is 0.
>
> Vishwa, Thanks for findingg this. =A0Indeed, I had assumed ffs() was zero=
 based,
> but it is 1 based.
>
>> I tested the attached patch on OMAP3 and it seems to work fine.
Attached, is Patch which fixes the Issue, It works Fine for OMAP3 and
OMAP4 SDP boards.
>> Kevin,
>> You may want to incorporate this change in your next version if this see=
ms
>> OK to you.
>
> Yes, I will fix this in forthcoming versions.
>
> Thanks,
>
> Kevin
>



--=20
Thanks,
Regards,
Shweta

--0015173fe9ba0ec3f6049fad312e
Content-Type: application/octet-stream;
	name="0001-OMAP2-PM-Ensure-Bitshifts-are-calculated-accurately.patch"
Content-Disposition: attachment;
	filename="0001-OMAP2-PM-Ensure-Bitshifts-are-calculated-accurately.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_glvva8g30

RnJvbSBlOTdkNmViNjM3NmNiY2ViZDA1Nzg3OTU4ODE1MWU5ZTU2Yjg1NGIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHdldGEgR3VsYXRpIDxzaHdldGEuZ3VsYXRpQHRpLmNvbT4K
RGF0ZTogV2VkLCAzMCBNYXIgMjAxMSAxMTozMTowNCArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIE9N
QVAyKzogUE06IEVuc3VyZSBCaXRzaGlmdHMgYXJlIGNhbGN1bGF0ZWQgYWNjdXJhdGVseQoKVG8g
U2V0IEkyQyBTbGF2ZSBBZGRyZXNzIGFuZCBzZXQgUE1JQyByZWdpc3RlciBhZGRyZXNzIHVzZWQK
YnkgVkMsIHRoZSBiaXQgc2hpZnRzIGFyZSBjYWxjdWxhdGVkIGJ5IHVzaW5nICdmZnMnIGZ1bmN0
aW9uCm9uIGJpdCBtYXNrcy5XaXRoICdmZnMnIGxlYXN0IHNpZ25pZmljYW50IGJpdCBpcyAxIGlu
c3RlYWQgb2YgMC4KU28gYWRkcmVzc2VzIGFyZSB3cm9uZ2x5IHNldC4gVXNpbmcgJ19fZmZzJyBp
bnN0ZWFkIG9mICdmZnMnCndoZXJlIDAgaXMgbGVhc3Qgc2lnbmlmaWNhbnQgYml0LgoKSXQgYXBw
bGllcyBvbiB0b3Agb2YgYnJhbmNoICdwbS13aXAvdm9sdGRtJwoKU2lnbmVkLW9mZi1ieTogU2h3
ZXRhIEd1bGF0aSA8c2h3ZXRhLmd1bGF0aUB0aS5jb20+Ci0tLQoKIGFyY2gvYXJtL21hY2gtb21h
cDIvcHJtMnh4eF8zeHh4LmMgfCAgICA2ICsrKy0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9wcm00
NHh4LmMgICAgICB8ICAgIDYgKysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL3BybTJ4
eHhfM3h4eC5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9wcm0yeHh4XzN4eHguYwppbmRleCA0ZDdm
ZTFhLi5lY2IxNWVkIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL3BybTJ4eHhfM3h4
eC5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvcHJtMnh4eF8zeHh4LmMKQEAgLTE4OSw3ICsx
ODksNyBAQCBpbnQgb21hcDNfcHJtX3ZjX3NldF9pMmNfc2xhdmVfYWRkcih1OCB2Y19pZCwgdTgg
c2xhdmVfYWRkcikKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlvbWFwMl9wcm1fcm13X21vZF9yZWdf
Yml0cyh2Yy0+c21wc19zYV9tYXNrLCAKLQkJCQkgICBzbGF2ZV9hZGRyIDw8IGZmcyh2Yy0+c21w
c19zYV9tYXNrKSwKKwkJCQkgICBzbGF2ZV9hZGRyIDw8IF9fZmZzKHZjLT5zbXBzX3NhX21hc2sp
LAogCQkJCSAgIE9NQVAzNDMwX0dSX01PRCwKIAkJCQkgICBPTUFQM19QUk1fVkNfU01QU19TQV9P
RkZTRVQpOwogCkBAIC0yMTMsMTMgKzIxMywxMyBAQCBzdGF0aWMgaW50IG9tYXAzX3BybV92Y19z
ZXRfcG1pY19yZWdfYWRkcnModTggdmNfaWQsIHU4IHZvbHRfYWRkciwgdTggY21kX2FkZHIpCiAJ
c3RydWN0IG9tYXAzX3BybV92YyAqdmMgPSAmdmNfY2hhbm5lbHNbdmNfaWRdOwogCiAJb21hcDJf
cHJtX3Jtd19tb2RfcmVnX2JpdHModmMtPnNtcHNfdm9sX3JhX21hc2ssIAotCQkJCSAgIHZvbHRf
YWRkciA8PCBmZnModmMtPnNtcHNfdm9sX3JhX21hc2spLAorCQkJCSAgIHZvbHRfYWRkciA8PCBf
X2Zmcyh2Yy0+c21wc192b2xfcmFfbWFzayksCiAJCQkJICAgT01BUDM0MzBfR1JfTU9ELAogCQkJ
CSAgIE9NQVAzX1BSTV9WQ19TTVBTX1ZPTF9SQV9PRkZTRVQpOwogCiAJaWYgKGNtZF9hZGRyKQog
CQlvbWFwMl9wcm1fcm13X21vZF9yZWdfYml0cyh2Yy0+c21wc19jbWRfcmFfbWFzaywgCi0JCQkJ
CWNtZF9hZGRyIDw8IGZmcyh2Yy0+c21wc19jbWRfcmFfbWFzayksCisJCQkJCWNtZF9hZGRyIDw8
IF9fZmZzKHZjLT5zbXBzX2NtZF9yYV9tYXNrKSwKIAkJCQkJT01BUDM0MzBfR1JfTU9ELAogCQkJ
CQlPTUFQM19QUk1fVkNfU01QU19DTURfUkFfT0ZGU0VUKTsKIAkKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL21hY2gtb21hcDIvcHJtNDR4eC5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9wcm00NHh4LmMK
aW5kZXggMjc1OGI3NS4uYzU0MmMyNSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9w
cm00NHh4LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9wcm00NHh4LmMKQEAgLTIzNCw3ICsy
MzQsNyBAQCBpbnQgb21hcDRfcHJtX3ZjX3NldF9pMmNfc2xhdmVfYWRkcih1OCB2Y19pZCwgdTgg
c2xhdmVfYWRkcikKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlvbWFwNF9wcm1pbnN0X3Jtd19pbnN0
X3JlZ19iaXRzKHZjLT5zbXBzX3NhX21hc2ssIAotCQkJCQlzbGF2ZV9hZGRyIDw8IGZmcyh2Yy0+
c21wc19zYV9tYXNrKSwKKwkJCQkJc2xhdmVfYWRkciA8PCBfX2Zmcyh2Yy0+c21wc19zYV9tYXNr
KSwKIAkJCQkJT01BUDQ0MzBfUFJNX1BBUlRJVElPTiwKIAkJCQkJT01BUDQ0MzBfUFJNX0RFVklD
RV9JTlNULAogCQkJCQlPTUFQNF9QUk1fVkNfU01QU19TQV9PRkZTRVQpOwpAQCAtMjYwLDE0ICsy
NjAsMTQgQEAgc3RhdGljIGludCBvbWFwNF9wcm1fdmNfc2V0X3BtaWNfcmVnX2FkZHJzKHU4IHZj
X2lkLAogCXN0cnVjdCBvbWFwNF9wcm1fdmMgKnZjID0gJnZjX2NoYW5uZWxzW3ZjX2lkXTsKIAog
CW9tYXA0X3BybWluc3Rfcm13X2luc3RfcmVnX2JpdHModmMtPnNtcHNfdm9sX3JhX21hc2ssIAot
CQkJCQl2b2x0X2FkZHIgPDwgZmZzKHZjLT5zbXBzX3ZvbF9yYV9tYXNrKSwKKwkJCQl2b2x0X2Fk
ZHIgPDwgX19mZnModmMtPnNtcHNfdm9sX3JhX21hc2spLAogCQkJCQlPTUFQNDQzMF9QUk1fUEFS
VElUSU9OLAogCQkJCQlPTUFQNDQzMF9QUk1fREVWSUNFX0lOU1QsCiAJCQkJCU9NQVA0X1BSTV9W
Q19WQUxfU01QU19SQV9WT0xfT0ZGU0VUKTsKIAogCWlmIChjbWRfYWRkcikKIAkJb21hcDRfcHJt
aW5zdF9ybXdfaW5zdF9yZWdfYml0cyh2Yy0+c21wc19jbWRfcmFfbWFzaywgCi0JCQkJCWNtZF9h
ZGRyIDw8IGZmcyh2Yy0+c21wc19jbWRfcmFfbWFzayksCisJCQkJCWNtZF9hZGRyIDw8IF9fZmZz
KHZjLT5zbXBzX2NtZF9yYV9tYXNrKSwKIAkJCQkJT01BUDQ0MzBfUFJNX1BBUlRJVElPTiwKIAkJ
CQkJT01BUDQ0MzBfUFJNX0RFVklDRV9JTlNULAogCQkJCQlPTUFQNF9QUk1fVkNfVkFMX1NNUFNf
UkFfQ01EX09GRlNFVCk7Ci0tIAoxLjcuMC40Cgo=
--0015173fe9ba0ec3f6049fad312e--
