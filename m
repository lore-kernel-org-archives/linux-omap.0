From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Important changes, please read
Date: Wed, 14 Jan 2009 15:00:34 +0100
Message-ID: <B3F388AE-0C4C-4790-B700-042A0F761620@student.utwente.nl>
References: <20090114134152.GJ29324@atomide.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-14-231364362"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:39689 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbZANOAq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2009 09:00:46 -0500
Received: from [172.20.1.5] (vpn006015.vpn.utwente.nl [130.89.6.15])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n0EE0aCn002671
          for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 15:00:37 +0100
In-Reply-To: <20090114134152.GJ29324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-14-231364362
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 14 jan 2009, om 14:41 heeft Tony Lindgren het volgende geschreven:

> Hi all,
>
> I'll be merging in v2.6.29-rc1 soonish, and suggest that we make some
> changes to continue aligning our tree with the mainline tree. So
> I suggest:
>
> - We move the dspgateway code into a separate branch as discussed
>  earlier.
>
> - We stop using source.mvista.com git tree, and only use the
>  kernel.org git tree. There's no need for having two master trees,
>  and kernel.org is the standard way to go. Big thanks to
>  Monta Vista for hosting us for many years.
>
> - We reset arch/arm/mach-omap1 to be what's in the mainline and
>  tag that patch again with "REMOVE OMAP LEGACY CODE" so it's easy
>  to find later on. Naturally any code in that patch can be reworked
>  so it can be integrated to the mainline kernel.
>
> - We add a clocks branch maintained by Paul Walmsley that's based
>  off the mainline tree
>
> - We change the pm branch maintained by Kevin Hilman to be based
>  on top of the mainline tree
>
> Comments and suggestions anybody?

Will there be some official 'staging' tree that pulls in trees like  
bridge, dss2, etc? I'm fine with pulling patches from this  
mailinglist, but a single source for gathering them would be nice.

Also, what's the medium and long term plan for the clocks and pm branch?

regards,

Koen


>
>
> BTW, I've also re-cloned the omap tree on kernel.org as it had
> tons of old objects that we don't need. It should not affect
> local trees, but report problems here. It will take a while
> to get mirrored, and some branches might be missing until
> mirroring is done.
>
> I have also set up and empty for-next branch that will contain
> the reviewed patches for next merge window. This will also get
> pulled into Stephen Rothwell's linux next tree on daily basis.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-14-231364362
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJbfAEMkyGM64RGpERAqmhAJ9JPpuqUBPSiFIzdk3BFUHI5M9/EQCePdqT
w0u3P7OzgMkli3Rtbmnqz00=
=WNG1
-----END PGP SIGNATURE-----

--Apple-Mail-14-231364362--
