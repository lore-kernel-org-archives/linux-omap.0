From: Ameya Palande <2ameya@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix module build warnings
Date: Wed, 1 Apr 2009 16:34:39 +0300
Message-ID: <269694c00904010634q1ad8d8dbg8d75a6be243c1b09@mail.gmail.com>
References: <1238516811-11401-1-git-send-email-ameya.palande@nokia.com>
	 <49D3111E.2060304@yandex.ru> <49D31218.8050200@yandex.ru>
	 <269694c00904010613g70a5de8eo5cac92865675ad0f@mail.gmail.com>
	 <269694c00904010614k4a2897e6p8c5c5fad120738d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016363b992299df3f04667e60c1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:55490 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759530AbZDANem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 09:34:42 -0400
Received: by fxm2 with SMTP id 2so33316fxm.37
        for <linux-omap@vger.kernel.org>; Wed, 01 Apr 2009 06:34:39 -0700 (PDT)
In-Reply-To: <269694c00904010614k4a2897e6p8c5c5fad120738d9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--0016363b992299df3f04667e60c1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2009 at 4:14 PM, Ameya Palande <2ameya@gmail.com> wrote:
> On Wed, Apr 1, 2009 at 4:13 PM, Ameya Palande <2ameya@gmail.com> wrote:
>>
>> Hi Artem,
>>
>> On Wed, Apr 1, 2009 at 10:04 AM, Artem Bityutskiy <dedekind@yandex.ru> w=
rote:
>>>
>>> Artem Bityutskiy wrote:
>>>>
>>>> Ameya Palande wrote:
>>>>>
>>>>> diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge=
/wmd/tiomap3430.c
>>>>> index 1fca3e5..b489da1 100644
>>>>> --- a/drivers/dsp/bridge/wmd/tiomap3430.c
>>>>> +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
>>>>> @@ -2034,26 +2034,27 @@ static DSP_STATUS PteSet(struct PgTableAttrs =
*pt, u32 pa, u32 va,
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pfn_valid(__phys_to_pfn=
(patemp))) {
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pg =3D phys_t=
o_page(patemp);
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_page(pg);
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (page_cou=
nt(pg) <=3D 1) {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0printk(KERN_EMERG "DSPBRIDGE:MAP =C2=A0"
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"function: COUNT 0 FOR PA "
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"0x%x\n", patemp);
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0printk(KERN_EMERG "Bad page state"
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"in process '%s'\n"
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"page:%p flags:0x%0*lx "
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"mapping:%p mapcount:%d "
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"count:%d\n"
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"Trying to fix it up, but "
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"a reboot is needed\n"
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"Backtrace:\n",
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0current->comm, pg,
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(int)(2*sizeof(unsigned long)),
>>>
>>> Why do you need this (int) cast? Thiere is a %zd modifyer.
>>>>>
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(unsigned long)pg->flags,
>>>
>>> What for do you have to cast here?
>>
>> I have attached a new patch which should take care of the ugly code.
>>
>> Cheers,
>> Ameya.
>
> Sorry about the last message. This one is in plain text.
>
> Cheers,
> Ameya.
>

This one removes dump_stack() and BUG_ON().

Cheers,
Ameya.

--0016363b992299df3f04667e60c1
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001--DSPBRIDGE-Fix-module-build-warnings.patch"
Content-Disposition: attachment;
	filename="0001--DSPBRIDGE-Fix-module-build-warnings.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ft027ptw1

RnJvbSBhNDI3ZGRiOWFkODNkYmIwZjgxNjVmOWMxYmZjYzBhNWUyZmNkM2NkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWV5YSBQYWxhbmRlIDxhbWV5YS5wYWxhbmRlQG5va2lhLmNv
bT4KRGF0ZTogV2VkLCAxIEFwciAyMDA5IDE2OjA1OjEzICswMzAwClN1YmplY3Q6IFtQQVRDSF0g
W1BBVENIXSBEU1BCUklER0U6IEZpeCBtb2R1bGUgYnVpbGQgd2FybmluZ3MKCkZyb206IEFtZXlh
IFBhbGFuZGUgPGFtZXlhLnBhbGFuZGVAbm9raWEuY29tPgoKU2lnbmVkLW9mZi1ieTogQW1leWEg
UGFsYW5kZSA8YW1leWEucGFsYW5kZUBub2tpYS5jb20+Ci0tLQogZHJpdmVycy9kc3AvYnJpZGdl
L3JtZ3IvZHJ2X2ludGVyZmFjZS5jIHwgICAgNiAtLS0tLS0KIGRyaXZlcnMvZHNwL2JyaWRnZS9y
bWdyL25vZGUuYyAgICAgICAgICB8ICAgIDIgKy0KIGRyaXZlcnMvZHNwL2JyaWRnZS93bWQvdGlv
bWFwMzQzMC5jICAgICB8ICAgMjkgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDMgZmls
ZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9kc3AvYnJpZGdlL3JtZ3IvZHJ2X2ludGVyZmFjZS5jIGIvZHJpdmVycy9kc3Av
YnJpZGdlL3JtZ3IvZHJ2X2ludGVyZmFjZS5jCmluZGV4IDM1MGUxYjUuLjk4MTM1NGEgMTAwNzU1
Ci0tLSBhL2RyaXZlcnMvZHNwL2JyaWRnZS9ybWdyL2Rydl9pbnRlcmZhY2UuYworKysgYi9kcml2
ZXJzL2RzcC9icmlkZ2Uvcm1nci9kcnZfaW50ZXJmYWNlLmMKQEAgLTY4NSwxMiArNjg1LDYgQEAg
c3RhdGljIGludCBicmlkZ2VfcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlwLCBzdHJ1Y3QgZmlsZSAq
ZmlscCkKIAlyZXR1cm4gc3RhdHVzOwogfQogCi1zdGF0aWMgdm9pZCBicmlkZ2VfZnJlZShzdHJ1
Y3QgZGV2aWNlICpkZXYpCi17Ci0JLyogbm90aGluZyB0byBGcmVlICovCi19Ci0KLQogLyogVGhp
cyBmdW5jdGlvbiBwcm92aWRlcyBJTyBpbnRlcmZhY2UgdG8gdGhlIGJyaWRnZSBkcml2ZXIuICov
CiBzdGF0aWMgaW50IGJyaWRnZV9pb2N0bChzdHJ1Y3QgaW5vZGUgKmlwLCBzdHJ1Y3QgZmlsZSAq
ZmlscCwgdW5zaWduZWQgaW50IGNvZGUsCiAJCXVuc2lnbmVkIGxvbmcgYXJncykKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZHNwL2JyaWRnZS9ybWdyL25vZGUuYyBiL2RyaXZlcnMvZHNwL2JyaWRnZS9y
bWdyL25vZGUuYwppbmRleCA1MWI0YjEyLi4xNzhiODAyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2Rz
cC9icmlkZ2Uvcm1nci9ub2RlLmMKKysrIGIvZHJpdmVycy9kc3AvYnJpZGdlL3JtZ3Ivbm9kZS5j
CkBAIC0zNDcxLDcgKzM0NzEsNyBAQCBzdGF0aWMgRFNQX1NUQVRVUyBHZXRSTVNGeG5zKHN0cnVj
dCBOT0RFX01HUiAqaE5vZGVNZ3IpCiAJCQl9CiAJCX0KIAl9Ci1mdW5jX2VuZDoKKwogCXJldHVy
biBzdGF0dXM7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZHNwL2JyaWRnZS93bWQvdGlvbWFw
MzQzMC5jIGIvZHJpdmVycy9kc3AvYnJpZGdlL3dtZC90aW9tYXAzNDMwLmMKaW5kZXggMWZjYTNl
NS4uZDk0Y2U2NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9kc3AvYnJpZGdlL3dtZC90aW9tYXAzNDMw
LmMKKysrIGIvZHJpdmVycy9kc3AvYnJpZGdlL3dtZC90aW9tYXAzNDMwLmMKQEAgLTIwMzQsMjQg
KzIwMzQsOCBAQCBzdGF0aWMgRFNQX1NUQVRVUyBQdGVTZXQoc3RydWN0IFBnVGFibGVBdHRycyAq
cHQsIHUzMiBwYSwgdTMyIHZhLAogCQkJaWYgKHBmbl92YWxpZChfX3BoeXNfdG9fcGZuKHBhdGVt
cCkpKSB7CiAJCQkJcGcgPSBwaHlzX3RvX3BhZ2UocGF0ZW1wKTsKIAkJCQlnZXRfcGFnZShwZyk7
Ci0JCQl9Ci0JCQlpZiAocGFnZV9jb3VudChwZykgPD0gMSkgewotCQkJCXByaW50ayhLRVJOX0VN
RVJHICJEU1BCUklER0U6TUFQICBmdW5jdGlvbjogIgotCQkJCQkiQ09VTlQgMCBGT1IgUEEgMHgl
eFxuIiwgcGF0ZW1wKTsKLQkJCQlwcmludGsoS0VSTl9FTUVSRyAiQmFkIHBhZ2Ugc3RhdGUiCi0J
CQkJCUtFUk5fRU1FUkcgImluIHByb2Nlc3MgJyVzJ1xuIgotCQkJCQlLRVJOX0VNRVJHICJwYWdl
OiVwIGZsYWdzOjB4JTAqbHggIgotCQkJCQlLRVJOX0VNRVJHICJtYXBwaW5nOiVwIG1hcGNvdW50
OiVkICIKLQkJCQkJS0VSTl9FTUVSRyAiY291bnQ6JWRcbiIKLQkJCQkJS0VSTl9FTUVSRyAiVHJ5
aW5nIHRvIGZpeCBpdCB1cCwgYnV0ICIKLQkJCQkJS0VSTl9FTUVSRyAiYSByZWJvb3QgaXMgbmVl
ZGVkXG4iCi0JCQkJCUtFUk5fRU1FUkcgIkJhY2t0cmFjZTpcbiIsCi0JCQkJCWN1cnJlbnQtPmNv
bW0sIHBnLAotCQkJCQkoaW50KSgyKnNpemVvZih1bnNpZ25lZCBsb25nKSksCi0JCQkJCSh1bnNp
Z25lZCBsb25nKXBnLT5mbGFncywgcGctPm1hcHBpbmcsCi0JCQkJCXBhZ2VfbWFwY291bnQocGcp
LCBwYWdlX2NvdW50KHBnKSk7Ci0JCQkJZHVtcF9zdGFjaygpOwotCQkJCUJVR19PTigxKTsKKwkJ
CQlpZiAocGFnZV9jb3VudChwZykgPD0gMSkKKwkJCQkJZ290byBwZ19jbnRfZXJyX291dDsKIAkJ
CX0KIAogCQkJcGF0ZW1wICs9IEhXX1BBR0VfU0laRV80S0I7CkBAIC0yMTI2LDYgKzIxMTAsMTUg
QEAgc3RhdGljIERTUF9TVEFUVVMgUHRlU2V0KHN0cnVjdCBQZ1RhYmxlQXR0cnMgKnB0LCB1MzIg
cGEsIHUzMiB2YSwKIAl9CiAJREJHX1RyYWNlKERCR19FTlRFUiwgIjwgUHRlU2V0IHN0YXR1cyAl
eFxuIiwgc3RhdHVzKTsKIAlyZXR1cm4gc3RhdHVzOworCitwZ19jbnRfZXJyX291dDoKKwlwcl9l
bWVyZygiRFNQQlJJREdFOk1BUCBmdW5jdGlvbjogQ09VTlQgMCBGT1IgUEEgMHgleFxuIiwgcGF0
ZW1wKTsKKwlwcl9lbWVyZygiQmFkIHBhZ2Ugc3RhdGUgaW4gcHJvY2VzcyAnJXMnXG4gcGFnZTol
cCBmbGFnczolbHggIgorCQkJIm1hcHBpbmc6JXAgbWFwY291bnQ6JWQgY291bnQ6JWRcbiIsCisJ
CQljdXJyZW50LT5jb21tLCBwZywgcGctPmZsYWdzLAorCQkJcGctPm1hcHBpbmcsIHBhZ2VfbWFw
Y291bnQocGcpLCBwYWdlX2NvdW50KHBnKSk7CisJcHJfZW1lcmcoIkJhY2t0cmFjZTpcbiIpOwor
CUJVRygpOwogfQogCiAvKiBNZW1vcnkgbWFwIGtlcm5lbCBWQSAtLSBtZW1vcnkgYWxsb2NhdGVk
IHdpdGggdm1hbGxvYyAqLwotLSAKMS42LjIuMQoK
--0016363b992299df3f04667e60c1--
