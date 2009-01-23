From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: new PM branch available
Date: Fri, 23 Jan 2009 19:27:57 +0100
Message-ID: <C7828274-1409-462B-9C88-0ADCA5B0462C@student.utwente.nl>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F51109B5@dbde02.ent.ti.com> <E5387292-875B-4ACA-A008-3F1F11B6562B@student.utwente.nl> <87skna6isi.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5-1025007107"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:43835 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbZAWS2M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Jan 2009 13:28:12 -0500
In-Reply-To: <87skna6isi.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5-1025007107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable


Op 23 jan 2009, om 18:20 heeft Kevin Hilman het volgende geschreven:

> Koen Kooi <k.kooi@student.utwente.nl> writes:
>
>> Op 23 jan 2009, om 13:00 heeft Nayak, Rajendra het volgende =20
>> geschreven:
>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]
>>>> Sent: Friday, January 23, 2009 4:52 PM
>>>> To: Nayak, Rajendra
>>>> Cc: Kevin Hilman; linux-omap@vger.kernel.org
>>>> Subject: Re: new PM branch available
>>>>
>>>> "ext Nayak, Rajendra" <rnayak@ti.com> writes:
>>>>
>>>>>> I did some testing today on my 3.0GP 3430SDP. This is with
>>>> the omap_3430sdp_min_defconfig.
>>>>>>
>>>>>> 1) Idle.
>>>>>> echo -n 1 > /sys/power/clocks_off_while_idle
>>>>>> echo -n 1 > /sys/power/enable_off
>>>>>> Could not hit RET. something seems to be still active. Not
>>>> sure if it could be something
>>>>>> to do with this error that's thrown while bootup
>>>>>>
>>>>>> <6>Disabling unused clock "dpll5_ck"
>>>>>> Disabling unused clock "dpll5_ck"
>>>>>> <3>clock: dpll5_ck failed transition to 'locked'
>>>>>> clock: dpll5_ck failed transition to 'locked'
>>>>>>
>>>>>> This is the same results I see on my SDP.
>>>>>>
>>>>>> Looking at the registers, I am pretty sure it is the D2D
>>>> clockdomain
>>>>>> that still has activity, but due to very poor Stacked-mode
>>>> docs and no
>>>>>> responses to the D2D questions asked to TI I have not been able =20=

>>>>>> to
>>>>>> figure this one out.
>>>>>>
>>>>>> Help debugging this would be greatly appreciated.
>>>>>
>>>>> I looked some more into this today and saw that the hang is
>>>> indeed caused
>>>>> due to some kind of debug console going dead. The system
>>>> was still looping in the
>>>>> idle thread. I could even do a telnet remotely to my board and =20
>>>>> take
>>>>> some debug dumps..
>>>>
>>>> This might help you:
>>>
>>> Yup, this does help. There's no hang now either in idle or in =20
>>> suspend.
>>> Not sure why this was affecting only the SDP while the pm branch =20
>>> seems
>>> to function without this for beagle and other omap3 platforms?
>>
>> I get 'hangs' on the beagle as well with the PM branch. They mostly
>> seem to happen when I boot a fresh rootfs and the packagemanager runs
>> a lot of postinst scripts without any form of user interaction.
>>
>
> Koen,
>
> What are your /sys/power/clocks_off_while_idle and ../sleep_while_idle
> set to?

Ehm, the default I guess, I'm not touching to sysfsnodes anywhere :)

> Do you see the hangs when both of these are zero?

I'll have a look at that later next week.

regards,

Koen=

--Apple-Mail-5-1025007107
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJegwvMkyGM64RGpERAlp7AKCClNakmoo2IHDkdkBku4cDrmVJaACeMRWt
BTYJwhbyJqe1UARVwNMPBng=
=5gMX
-----END PGP SIGNATURE-----

--Apple-Mail-5-1025007107--
