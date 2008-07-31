From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Kernel hang on OMAP3 based Beagle board, RTC issue?
Date: Thu, 31 Jul 2008 15:33:10 +0200
Message-ID: <B8C1A084-3C54-48C6-A4DE-A437C80E2C52@student.utwente.nl>
References: <486BDD2A.5070500@googlemail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BB6621C@dbde02.ent.ti.com> <AF70E37B-038B-4117-B69F-B2BCD9EFF6AA@student.utwente.nl> <486F21F6.7020208@googlemail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73A2@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73BE@dbde02.ent.ti.com> <87vdzi2ln0.fsf@trdhcp146196.ntc.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9263@dbde02.ent.ti.com> <746A464E-F4E2-467A-9D01-DFE2AB3BB02E@student.utwente.nl> <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9641@dbde02.ent.ti.com> <0680EC522D0CC943BC586913CF3768C00208A6A03F@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-833305911"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:60652 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbYGaNgo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jul 2008 09:36:44 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C00208A6A03F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, H?gander Jouni <jouni.hogander@nokia.com>, Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-833305911
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 31 jul 2008, om 15:08 heeft Syed Mohammed, Khasim het volgende  
geschreven:

>
>>
>>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c
>>>>> b/arch/arm/mach-omap2/pm34xx.c
>>>>> index 202c269..308835b 100644
>>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>>> @@ -380,11 +380,11 @@ int __init omap3_pm_init(void)
>>>>>               goto err1;
>>>>>       }
>>>>>
>>>>> -       ret = pwrdm_for_each(pwrdms_setup);
>>>>> -       if (ret) {
>>>>> -               printk(KERN_ERR "Failed to setup powerdomains\n");
>>>>> -               goto err2;
>>>>> -       }
>>>>> +/*     ret = pwrdm_for_each(pwrdms_setup); */
>>>>> +/*     if (ret) { */
>>>>> +/*             printk(KERN_ERR "Failed to setup powerdomains 
>>>>> \n"); */
>>>>> +/*             goto err2; */
>>>>> +/*     } */
>>>>>
>>>>>       mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
>>>>>       if (mpu_pwrdm == NULL) {
>>>>
>
> Hi Jouni,
>
> Commenting the lines did fix my UART 3 issue, but I am not clear as  
> to what is happening by having it enabled. Before I dig in further  
> can you give your thoughts as to why these lines could result in  
> UART3 hang?

I've had these lines commented out for some weeks now and still get  
the hang.


>
>
> Thanks.
>
> Regards,
> Khasim
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-1-833305911
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIkb8YMkyGM64RGpERApGZAJ4iaQhy5ZCvMWskTsNcE3ta9/PiMwCfX3VQ
EBwF2ejIcS1h/Bw9qyCY7E0=
=XEXB
-----END PGP SIGNATURE-----

--Apple-Mail-1-833305911--
