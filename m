From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PM branch updates: 3430sdp and omap3evm results
Date: Tue, 27 Jan 2009 21:00:36 +0100
Message-ID: <7833D650-75C3-4227-B820-1DA51657FC38@student.utwente.nl>
References: <87fxj4ty1l.fsf@deeprootsystems.com> <C4A9358E-0172-49B4-9E23-21A87732C37B@student.utwente.nl> <87wscgsezy.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4--771317025"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:34734 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755760AbZA0UAs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2009 15:00:48 -0500
In-Reply-To: <87wscgsezy.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4--771317025
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 27 jan 2009, om 20:52 heeft Kevin Hilman het volgende geschreven:

> Koen Kooi <k.kooi@student.utwente.nl> writes:
>
>> Op 27 jan 2009, om 19:16 heeft Kevin Hilman het volgende geschreven:
>>
>>> Hello,
>>>
>>> I've updated the PM branch with a couple of fixes that get it  
>>> working
>>> on the 3430SDP.
>>
>> Any chance of the beagle cpufreq patch ending up in the branch?
>>
>
> Yes, a 100% chance.  :)
>
> I reworked the version you sent me to use a common header for the
> rates since it was shared between beagle and SDP.
>
> Just pushed it to my pm branch[1].

Thanks! I checked 15 minutes ago, just before you pushed it :)

regards,

Koen

>
>
> NOTE: Tony's tree wont sync yet for while, so I recomment you pull
> straight from mine.  Also, I just pushed this, so the git.kernel.org
> mirrors might take some time to sync up as well.
>
> The tip of the branch should now be:
> OMAP3: PM: add common OPP definitions and use them on Beagle
>
> Kevin
>
> [1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
>>>
>>>
>>> For it to work on the SDP, you need the latest u-boot from the
>>> omapzoom u-boot tree[1].  This fixes the problems I was having with
>>> the D2D clockdomain remaining active or hanging upon clock disable.
>>>
>>> For omap3evm, it is not hitting retention because it uses the GPIO
>>> debounce feature for the touchscreen and the GPIO debounce clocks  
>>> are
>>> not disabled in idle or suspend.  As a temporary hack, you can test
>>> the patch below[2] which simply doesn't call the gpio debounce
>>> functions for the touchscreen.  In the meantime, I'm working on a
>>> patch to disable the debounce clocks on idle.
>>>
>>> Kevin
>>>
>>> [1] git://git.omapzoom.org/repo/u-boot.git
>>>
>>> [2]
>>> da7df18bc7f5648ac7fe6e674065ca5899ff8d3d
>>> arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
>>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
>>> omap2/board-omap3evm.c
>>> index 6fbbe95..18a07b5 100644
>>> --- a/arch/arm/mach-omap2/board-omap3evm.c
>>> +++ b/arch/arm/mach-omap2/board-omap3evm.c
>>> @@ -176,8 +176,8 @@ static void ads7846_dev_init(void)
>>>
>>> 	gpio_direction_input(OMAP3_EVM_TS_GPIO);
>>>
>>> -	omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1);
>>> -	omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa);
>>> +/* 	omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1); */
>>> +/* 	omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa); */
>>> }
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-
>>> omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>


--Apple-Mail-4--771317025
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJf2fmMkyGM64RGpERAs+bAKCE32ZniWCTY0AW46Glr/xN0nPRLACdGUpD
3KmY30T7E+3OorpG7yCVNiM=
=s2zV
-----END PGP SIGNATURE-----

--Apple-Mail-4--771317025--
