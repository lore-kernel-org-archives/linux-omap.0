From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Kernel hang on OMAP3 based Beagle board, RTC issue?
Date: Tue, 15 Jul 2008 09:18:59 +0200
Message-ID: <746A464E-F4E2-467A-9D01-DFE2AB3BB02E@student.utwente.nl>
References: <486BDD2A.5070500@googlemail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BB6621C@dbde02.ent.ti.com> <AF70E37B-038B-4117-B69F-B2BCD9EFF6AA@student.utwente.nl> <486F21F6.7020208@googlemail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73A2@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73BE@dbde02.ent.ti.com> <87vdzi2ln0.fsf@trdhcp146196.ntc.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9263@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-7--571545042"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:10378 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277AbYGOHTW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Jul 2008 03:19:22 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9263@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: =?ISO-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-7--571545042
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 14 jul 2008, om 15:27 heeft Gadiyar, Anand het volgende geschreven:

>> diff --git a/arch/arm/mach-omap2/pm34xx.c
>> b/arch/arm/mach-omap2/pm34xx.c
>> index 202c269..308835b 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -380,11 +380,11 @@ int __init omap3_pm_init(void)
>>                goto err1;
>>        }
>>
>> -       ret = pwrdm_for_each(pwrdms_setup);
>> -       if (ret) {
>> -               printk(KERN_ERR "Failed to setup powerdomains\n");
>> -               goto err2;
>> -       }
>> +/*     ret = pwrdm_for_each(pwrdms_setup); */
>> +/*     if (ret) { */
>> +/*             printk(KERN_ERR "Failed to setup powerdomains\n"); */
>> +/*             goto err2; */
>> +/*     } */
>>
>>        mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
>>        if (mpu_pwrdm == NULL) {
>
> With this change, the hang does not happene. Applied this patch on  
> the current
> linux-omap tree.
>
> Thanks for the patch. It fixes the hang for now. I'm not sure why  
> the hang
> happens, but could it be because the SDP uses ttyS0 by default as the
> console while the Beagle is on ttyS2?

With that patch I still get the same behaviour:

serial console freezes, but responds to sysrq

I don't know if its related, but after the serial console freezes  
animated backgrounds in X stop animating, but will refresh if you  
press a key on the keyboard. The same effect can be seen with running  
'top' on the screen.
I'm using the CPUidle patches posted to the list a few weeks back +  
the timer suppression patch.

regards,

Koen


--Apple-Mail-7--571545042
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIfE9nMkyGM64RGpERAlNzAKCKxYoBcyDq2HNi642Q2LXObC4u1gCfYTEp
SKcrw/83CGspnHkXtXabpS0=
=HRJw
-----END PGP SIGNATURE-----

--Apple-Mail-7--571545042--
