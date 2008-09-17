From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: OMAP support in mainline?
Date: Wed, 17 Sep 2008 15:23:49 +0200
Message-ID: <8192948C-751F-4C1C-B382-E381F903CC46@student.utwente.nl>
References: <87tzcgi1gv.fsf@nokia.com> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <200809162255.00918.david-b@pacbell.net> <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl> <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6-684977005"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:41389 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352AbYIQNYB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2008 09:24:01 -0400
Received: from [172.20.1.5] (vpn006014.vpn.utwente.nl [130.89.6.14])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8HDNpIp032419
          for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 15:23:51 +0200
In-Reply-To: <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6-684977005
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 17 sep 2008, om 14:24 heeft Steve Sakoman het volgende geschreven:

> On Wed, Sep 17, 2008 at 12:16 AM, Koen Kooi  
> <k.kooi@student.utwente.nl> wrote:
>
>> And they aren't working too well with current l-o git either with  
>> MUSB being
>> broken. There's a patch to fix client mode, but host mode still isn't
>> working.
>
> Host mode musb is working just fine on Overo with the "set
> transceiver" patch.  Not sure why you are having trouble with Beagle
> (and can't check since I don't have my Beagle board with me at the
> moment)

I should clarify: OTG mode with a host cable doesn't work in .27rc, it  
does work in 2.6.26. I haven't tried specifying pure hostmode, only OTG.
I would try it on the evm as well, but that is having serious irq  
issues with .27rc, pressing a key on the keypad triggers an irq  
overrun, ethernet gives an oops on boot when trying to register and  
irq etc,etc. 2.6.27 is looking really, really bad on omap3 at the  
moment.

regards,

Koen


>
>
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-6-684977005
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI0QTmMkyGM64RGpERAs0NAJ4qzKsmIxjyzrqX7V01SIkn0DpA7QCcCiVq
MJkk8va53zzDmAPvK9dGjoA=
=PvcH
-----END PGP SIGNATURE-----

--Apple-Mail-6-684977005--
