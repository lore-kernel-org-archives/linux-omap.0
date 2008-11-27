From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 0/5] extra module resets to ensure full-chip idle
Date: Thu, 27 Nov 2008 10:02:20 +0100
Message-ID: <FF11085F-86D4-4350-AC79-878C9D7CC0F7@student.utwente.nl>
References: <1227744349-12118-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-50-361237541"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:49663 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbYK0JCa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2008 04:02:30 -0500
In-Reply-To: <1227744349-12118-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-50-361237541
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 27 nov 2008, om 01:05 heeft Kevin Hilman het volgende geschreven:

> Various bootloaders have been known to leave modules in a state
> which prevents full-chip retention.  This series forces
> MMC, IVA2 and D2D/modem into known reset/idle states so that
> the OMAP3 can hit full-chip idle.
>
> Tested on OMAP3 Beagle, and custom OMAP3 hardware.
>
> NOTE: this is similar to the set I posted for the PM branch
>      but this series is rebased onto linux-omap and includes
>      the MMC reset.

I'm having trouble applying these against current head  
(5019ed843f3208482c64043e4052e89b3d5462a0), against which rev were  
they generated?

regards,

Koen



>
>
> Kevin Hilman (5):
>  OMAP3: PM: HSMMC: force MMC module reset on boot
>  OMAP3: PM: Force IVA2 into idle during bootup
>  OMAP3: PM: Add D2D clocks and auto-idle setup to PRCM init
>  OMAP3: PM: D2D clockdomain supports SW supervised transitions
>  OMAP3: PM: Ensure modem is reset during PRCM init
>
> arch/arm/mach-omap2/clock34xx.h           |   37 +++++++++++++-
> arch/arm/mach-omap2/clockdomains.h        |    2 +-
> arch/arm/mach-omap2/cm-regbits-34xx.h     |   14 +++++
> arch/arm/mach-omap2/devices.c             |   76 ++++++++++++++++++++ 
> +++++++++
> arch/arm/mach-omap2/pm34xx.c              |   65 ++++++++++++++++++++ 
> ++++-
> arch/arm/plat-omap/include/mach/control.h |    5 ++
> 6 files changed, 195 insertions(+), 4 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-50-361237541
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJLmIeMkyGM64RGpERAnOtAKCF2z2BcIxxepyyv3KYARAcDM+grwCgpIcJ
wb8xaNgFmboJLDA9tzXYmIc=
=qocv
-----END PGP SIGNATURE-----

--Apple-Mail-50-361237541--
