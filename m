From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: new PM branch available
Date: Fri, 23 Jan 2009 13:10:48 +0100
Message-ID: <E5387292-875B-4ACA-A008-3F1F11B6562B@student.utwente.nl>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F51109B5@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-1002378079"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:22759 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbZAWMLQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Jan 2009 07:11:16 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F51109B5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: =?ISO-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-1002378079
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable


Op 23 jan 2009, om 13:00 heeft Nayak, Rajendra het volgende geschreven:

>
>
>> -----Original Message-----
>> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]
>> Sent: Friday, January 23, 2009 4:52 PM
>> To: Nayak, Rajendra
>> Cc: Kevin Hilman; linux-omap@vger.kernel.org
>> Subject: Re: new PM branch available
>>
>> "ext Nayak, Rajendra" <rnayak@ti.com> writes:
>>
>>>> I did some testing today on my 3.0GP 3430SDP. This is with
>> the omap_3430sdp_min_defconfig.
>>>>
>>>> 1) Idle.
>>>> echo -n 1 > /sys/power/clocks_off_while_idle
>>>> echo -n 1 > /sys/power/enable_off
>>>> Could not hit RET. something seems to be still active. Not
>> sure if it could be something
>>>> to do with this error that's thrown while bootup
>>>>
>>>> <6>Disabling unused clock "dpll5_ck"
>>>> Disabling unused clock "dpll5_ck"
>>>> <3>clock: dpll5_ck failed transition to 'locked'
>>>> clock: dpll5_ck failed transition to 'locked'
>>>>
>>>> This is the same results I see on my SDP.
>>>>
>>>> Looking at the registers, I am pretty sure it is the D2D
>> clockdomain
>>>> that still has activity, but due to very poor Stacked-mode
>> docs and no
>>>> responses to the D2D questions asked to TI I have not been able to
>>>> figure this one out.
>>>>
>>>> Help debugging this would be greatly appreciated.
>>>
>>> I looked some more into this today and saw that the hang is
>> indeed caused
>>> due to some kind of debug console going dead. The system
>> was still looping in the
>>> idle thread. I could even do a telnet remotely to my board and take
>>> some debug dumps..
>>
>> This might help you:
>
> Yup, this does help. There's no hang now either in idle or in suspend.
> Not sure why this was affecting only the SDP while the pm branch seems
> to function without this for beagle and other omap3 platforms?

I get 'hangs' on the beagle as well with the PM branch. They mostly =20
seem to happen when I boot a fresh rootfs and the packagemanager runs =20=

a lot of postinst scripts without any form of user interaction.

regards,

Koen


>
>
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c
>> b/arch/arm/mach-omap2/pm34xx.c
>> index b2db0ba..266e4f5 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -401,6 +401,8 @@ void omap_sram_idle(void)
>>                        omap3_prcm_restore_context();
>>                        omap3_sram_restore_context();
>>                }
>> +               omap_uart_resume_idle(0);
>> +               omap_uart_resume_idle(1);
>>                if (core_next_state =3D=3D PWRDM_POWER_OFF)
>>                        prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
>>                                               OMAP3430_GR_MOD,
>>
>> --=20
>> Jouni H=F6gander
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-=20
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>


--Apple-Mail-1-1002378079
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJebPLMkyGM64RGpERAsE9AJ9zOD1YXE7DNHNIeQq6waHQMqlmrgCgmqm5
w9DZsh6b/BwrVJMqv3y48us=
=Wd2/
-----END PGP SIGNATURE-----

--Apple-Mail-1-1002378079--
