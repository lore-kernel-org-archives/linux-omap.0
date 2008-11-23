From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 2/2] TVP514x V4L int device driver support
Date: Sun, 23 Nov 2008 23:04:58 +0100
Message-ID: <E960EE8F-D598-499F-AF23-8EB4EB7FE22D@student.utwente.nl>
References: <hvaibhav@ti.com> <1227280923-31654-1-git-send-email-hvaibhav@ti.com> <200811232300.40530.hverkuil@xs4all.nl>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-11-62595755"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:53812 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbYKWWFZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Nov 2008 17:05:25 -0500
In-Reply-To: <200811232300.40530.hverkuil@xs4all.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: video4linux-list@redhat.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-11-62595755
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 23 nov 2008, om 23:00 heeft Hans Verkuil het volgende geschreven:

> Remember that this is not a driver for use with omap, this is a  
> generic
> i2c driver for this chip. omap just happens to be the only bridge
> driver using it right now, but that can easily change.
>
> Yes, it makes it harder to write an i2c driver, but experience has  
> shown
> us that the advantages regarding reuse far outweigh this initial cost.

And google suggests that this chip is is used on dm35x and davinci  
platforms as well :)

regards,

Koen

--Apple-Mail-11-62595755
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJKdOMMkyGM64RGpERAsk5AJ4kHuKYs9HV1olbbgV52AJkSWycbQCglzRN
YLmRjf3Ncsvh6f5lSS3rCEE=
=rBlR
-----END PGP SIGNATURE-----

--Apple-Mail-11-62595755--
