From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] Fixed OMAP3 version check
Date: Thu, 25 Sep 2008 15:10:14 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394308CEC47@vaebe110.NOE.Nokia.com>
References: <1221572797-15949-1-git-send-email-tero.kristo@nokia.com> <1221572797-15949-2-git-send-email-tero.kristo@nokia.com> <20080925101750.GG5222@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C91F07.AAF56C6A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45124 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbYIYMKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 08:10:49 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080925101750.GG5222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C91F07.AAF56C6A
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

Here is a fix that works on top of your patch. Tested with ES2.1 and
ES3.0 chips. I left out the caching for CPU type.

-Tero=20

>-----Original Message-----
>From: ext Tony Lindgren [mailto:tony@atomide.com]=20
>Sent: 25 September, 2008 13:18
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] Fixed OMAP3 version check
>
>Hi,
>
>* Tero Kristo <tero.kristo@nokia.com> [080916 14:59]:
>> CPU version was reported incorrectly (e.g. ES3.0 instead of ES2.1.)=20
>> Also added a piece of optimization for CPU type check (omap_type()).
>>=20
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/id.c |    7 +++++--
>>  1 files changed, 5 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/arm/mach-omap2/id.c=20
>b/arch/arm/mach-omap2/id.c index=20
>> ab7a6e9..4e2b449 100644
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -37,7 +37,10 @@ EXPORT_SYMBOL(omap_chip_is);
>> =20
>>  int omap_type(void)
>>  {
>> -	u32 val =3D 0;
>> +	static u32 val;
>> +
>> +	if (val !=3D 0)
>> +		return val;
>
>Hmm I guess this would return a random val? :)
>
>
>>  	if (cpu_is_omap24xx()) {
>>  		val =3D omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
>> @@ -169,7 +172,7 @@ void __init omap34xx_check_revision(void)
>>  	rev =3D (idcode >> 28) & 0xff;
>> =20
>>  	if (hawkeye =3D=3D 0xb7ae)
>> -		system_rev =3D 0x34300034 | ((1 + rev) << 12);
>> +		system_rev =3D 0x34300034 | (rev << 12);
>> =20
>>  out:
>>  	switch (system_rev) {
>
>Well AFAIK here are the numbers for rev:
>
>ES1.0	   0	/* Cannot read idcode register */
>ES2.0	   0
>ES2.1	   1
>ES3.0	   2
>
>While ES3.0 TRM claims:
>
>ES1.0 	   0
>ES2.0	   1
>ES2.1	   2
>ES3.0	   3
>
>Which I think is incorrect at least for ES2.0 and ES2.1.
>
>Can you please try the attached patch and see if it detects=20
>your ES3.0 correctly?
>
>Tony
>

------_=_NextPart_001_01C91F07.AAF56C6A
Content-Type: application/octet-stream;
	name="0001-OMAP3-Fixed-version-check.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-OMAP3-Fixed-version-check.patch
Content-Disposition: attachment;
	filename="0001-OMAP3-Fixed-version-check.patch"

RnJvbSAzYzYxMDg3NTY4ZjMwNzUzOThlZTUwMmJkOTFlNmU3NjBlMDRiY2ExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUZXJvIEtyaXN0byA8dGVyby5rcmlzdG9Abm9raWEuY29tPgpE
YXRlOiBUaHUsIDI1IFNlcCAyMDA4IDE2OjQzOjE4ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gT01B
UDM6IEZpeGVkIHZlcnNpb24gY2hlY2sKCkVTMi4xIGFuZCBFUzMuMCBhcmUgbm93IGRldGVjdGVk
IGNvcnJlY3RseS4KClNpZ25lZC1vZmYtYnk6IFRlcm8gS3Jpc3RvIDx0ZXJvLmtyaXN0b0Bub2tp
YS5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9pZC5jIHwgICAgNCArKy0tCiAxIGZpbGVz
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9h
cmNoL2FybS9tYWNoLW9tYXAyL2lkLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2lkLmMKaW5kZXgg
YmYzNjkxZi4uN2E3YWQxOCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9pZC5jCisr
KyBiL2FyY2gvYXJtL21hY2gtb21hcDIvaWQuYwpAQCAtMTc3LDExICsxNzcsMTEgQEAgdm9pZCBf
X2luaXQgb21hcDM0eHhfY2hlY2tfcmV2aXNpb24odm9pZCkKIAkJCXN5c3RlbV9yZXYgPSBPTUFQ
MzQzMF9SRVZfRVMyXzA7CiAJCQlyZXZfbmFtZSA9ICJFUzIuMCI7CiAJCQlicmVhazsKLQkJY2Fz
ZSAxOgorCQljYXNlIDI6CiAJCQlzeXN0ZW1fcmV2ID0gT01BUDM0MzBfUkVWX0VTMl8xOwogCQkJ
cmV2X25hbWUgPSAiRVMyLjEiOwogCQkJYnJlYWs7Ci0JCWNhc2UgMjoKKwkJY2FzZSAzOgogCQkJ
c3lzdGVtX3JldiA9IE9NQVAzNDMwX1JFVl9FUzNfMDsKIAkJCXJldl9uYW1lID0gIkVTMy4wIjsK
IAkJCWJyZWFrOwotLSAKMS41LjQuMwoK

------_=_NextPart_001_01C91F07.AAF56C6A--
