From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: new PM branch available
Date: Wed, 4 Feb 2009 17:15:38 +0100
Message-ID: <975E7C45-55D7-4468-8C21-8EFB737ED60A@student.utwente.nl>
References: <87iqoij2me.fsf@deeprootsystems.com> <20090202174532.GJ4954@codecarver.research.nokia.com> <87wsc8bp79.fsf@deeprootsystems.com> <20090204005228.GA30147@codecarver.research.nokia.com> <87eiye89y1.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1--93615413"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:41149 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764AbZBDQRj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Feb 2009 11:17:39 -0500
In-Reply-To: <87eiye89y1.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1--93615413
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 4 feb 2009, om 17:04 heeft Kevin Hilman het volgende geschreven:

> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
>
>> Dynamic retention seems to work only once the system has been in  
>> static
>> retention once.
>>
>> Static off mode seems to work, but resume from off kills the UART.  
>> The
>> system seems to run though, at least LED0 flickers as usual when the
>> system runs. Sometimes it hangs and I have seen one reboot.
>
> I have noticed this as well.
>
> I haven't looked at all at the T2 scripts being used on Beagle.  Do
> you think some of these issues may be related to those scripts?

The scripts prevent 'reboot' from working, disabling them makes it  
work again (on beagle).

regards,

Koen

--Apple-Mail-1--93615413
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJib8sMkyGM64RGpERAkV1AKCZxPRHziCCp19iC/yxixiQ2/Jy7wCfY2Ka
Oi4O2Ip/zHEQOueBLWmNUqA=
=6La7
-----END PGP SIGNATURE-----

--Apple-Mail-1--93615413--
