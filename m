From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 21:20:07 +0100
Message-ID: <40134428-B064-4C6A-9229-FBEC8918B296@student.utwente.nl>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com> <20081126110854.GA6234@sirena.org.uk> <20081126134028.b3c6aa46.jarkko.nikula@nokia.com> <200811261034.42356.david-b@pacbell.net> <20081126200750.GK6234@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-48-315504315"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:40130 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbYKZUUg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2008 15:20:36 -0500
In-Reply-To: <20081126200750.GK6234@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: David Brownell <david-b@pacbell.net>, Jarkko Nikula <jarkko.nikula@nokia.com>, "Stanley.Miao" <stanley.miao@windriver.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-48-315504315
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 26 nov 2008, om 21:07 heeft Mark Brown het volgende geschreven:

> On Wed, Nov 26, 2008 at 10:34:41AM -0800, David Brownell wrote:
>
>> Re TWL4030 codec configuration ... I count three microphone
>> input channels not used on Beagle, plus a speaker output
>> and some other stuff.  So it's obvious that something which
>> works on Beagle won't handle more interesting configurations
>> of that audio support.
>
> Can someone post an overview of what the hardware configurations of
> these boards are, please?  It's starting to sound like they're not  
> very
> similar at all.

On the codec level all these board use a variant of the TWL4030. The  
variants differ slightly in what kind of extra goodies they provide.  
On the board level not every feature of the TWL familiy is used, the  
beagle only analog in and analog out, the overo exposes more  
interfaces, etc.

Other people can fill in the details, but these are the differences I  
can think of.

regards,

Koen 

--Apple-Mail-48-315504315
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJLa95MkyGM64RGpERAtAEAJ4q9MfcKR3SavDc7Gex1ggBjcvl9wCff6Xm
CdzAhqoh7HZUoqk4kjyKIaM=
=Djq5
-----END PGP SIGNATURE-----

--Apple-Mail-48-315504315--
