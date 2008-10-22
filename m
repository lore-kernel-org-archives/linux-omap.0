From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: ALSA sound on beagleboard
Date: Wed, 22 Oct 2008 20:35:05 +0200
Message-ID: <682C5801-1A95-4D51-8154-F393129E4477@student.utwente.nl>
References: <E1KsheN-0002oF-7M@amazonia.comcast.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-12--567313342"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:53603 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbYJVSfQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2008 14:35:16 -0400
Received: from [172.20.1.5] (vpn006013.vpn.utwente.nl [130.89.6.13])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m9MIZ8EK024371
          for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 20:35:08 +0200
In-Reply-To: <E1KsheN-0002oF-7M@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-12--567313342
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 22 okt 2008, om 19:37 heeft Rick Bronson het volgende geschreven:

> Dave,
>
>  Thanks for the info.  This patch did get sound output working.  But
> input doesn't seem to work.  I checked that I really have audio at the
> audio-in connector and that the mixer is set right:
>
>> amixer
> Simple mixer control 'Master',0
>  Capabilities: pvolume
>  Playback channels: Front Left - Front Right
>  Limits: Playback 0 - 127
>  Mono:
>  Front Left: Playback 75 [59%]
>  Front Right: Playback 75 [59%]
> Simple mixer control 'Capture',0
>  Capabilities: cvolume
>  Capture channels: Front Left - Front Right
>  Limits: Capture 0 - 127
>  Front Left: Capture 84 [66%]
>  Front Right: Capture 84 [66%]
>
>  Anyone else got it working?

Is your asound.conf set up correctly?

regards,

Koen

>
>
>  Thanks for any help.
>
>  Rick
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-12--567313342
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI/3JcMkyGM64RGpERAkZnAKCM8syGbRDQ7OOafMIZ93rz+cnMsQCeNwPU
FS62nIm74oILhXHkjPk+XMo=
=6IgM
-----END PGP SIGNATURE-----

--Apple-Mail-12--567313342--
