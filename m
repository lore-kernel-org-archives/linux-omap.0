From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 7/8] 34XX: PM: Workaround to disable mmc
Date: Tue, 17 Jun 2008 14:38:59 +0200
Message-ID: <3CA7DEA0-D060-464D-AC25-355E8FB848E3@student.utwente.nl>
References: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com> <1213687871-30038-1-git-send-email-jouni.hogander@nokia.com> <663b4c9bb83ca6e0f9e490db7bfdccce@felipebalbi.com> <87d4mg460j.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:51680 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748AbYFQMkK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 08:40:10 -0400
In-Reply-To: <87d4mg460j.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 17 jun 2008, om 14:09 heeft H=F6gander Jouni het volgende geschreven=
:

> "ext Felipe Balbi" <me@felipebalbi.com> writes:
>
>> On Tue, 17 Jun 2008 10:31:11 +0300, Jouni Hogander
>> <jouni.hogander@nokia.com> wrote:
>>> Current hsmmc is not pm friendly. Disable it because it prevents =20
>>> omap3
>>> retention
>>
>> Disabling will just hide the bug. Better making it modular
>> and let mmc guys dig on it.
>
> Ok, I can change it, if this set needs to be sent again. I think
> disabling mmc increases visibility of its PM problems. I mean missing
> mmc driver is more visible than missing PM in this case.

My rootfs and kernel are on SD, so disabling SD results in the biggest =
=20
powersaving possible: not turning on the board ;)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIV7BlMkyGM64RGpERAlcJAJ412DshyLeAvZhrCa0beMXsZPy2UgCeL/KQ
UKjp5Lb11vjTd9P/lSovNCU=3D
=3D36Pq
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
