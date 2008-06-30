From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [RFC][PATCH] usb: musb: pass configuration specifics via pdata
Date: Mon, 30 Jun 2008 19:56:36 +0200
Message-ID: <E25964AA-D229-4654-B24B-30A48708B056@student.utwente.nl>
References: <1214826653-19005-1-git-send-email-felipe.balbi@nokia.com> <E4E2FDD8-E1E5-4601-A0B0-D2FC7B27C7C3@student.utwente.nl> <20080630174859.GC4877@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2-318194975"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:54758 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763285AbYF3SFi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jun 2008 14:05:38 -0400
In-Reply-To: <20080630174859.GC4877@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgre <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Anand Gadiyar <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, Bryan Wu <cooloney@kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2-318194975
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 30 jun 2008, om 19:49 heeft Felipe Balbi het volgende geschreven:

> On Mon, Jun 30, 2008 at 07:29:28PM +0200, Koen Kooi wrote:
>>
>> Op 30 jun 2008, om 13:50 heeft Felipe Balbi het volgende geschreven:
>>
>>> Use platform_data to pass musb configuration-specific
>>> details to musb driver.
>>>
>>> It's easier to maintain in the sense that neither board
>>> will affect the other.
>>>
>>> For now tested on n800 only, wanna hear from everybody what
>>> guys think before test on omap3430sdp
>>>
>>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>>> Cc: Tony Lindgre <tony@atomide.com>
>>> Cc: David Brownell <david-b@pacbell.net>
>>> Cc: Anand Gadiyar <gadiyar@ti.com>
>>> Cc: Kevin Hilman <khilman@mvista.com>
>>> Cc: Bryan Wu <cooloney@kernel.org>
>>> ---
>>> arch/arm/mach-omap2/board-3430sdp.c  |   75 ++++++++++++++-
>>> arch/arm/mach-omap2/board-n800-usb.c |   46 +++++++++-
>>> arch/arm/mach-omap2/usb-musb.c       |   55 +++--------
>>> arch/arm/mach-omap2/usb-tusb6010.c   |    1 -
>>> drivers/usb/musb/musb_core.c         |   37 +++----
>>> drivers/usb/musb/musb_core.h         |   14 +---
>>> drivers/usb/musb/tusb6010.h          |  169
>>> --------------------------------
>>> include/asm-arm/arch-omap/hdrc_cnf.h |  177
>>> ----------------------------------
>>> include/asm-arm/arch-omap/usb-musb.h |    6 +-
>>> include/linux/usb/musb.h             |   38 +++++++-
>>> 10 files changed, 189 insertions(+), 429 deletions(-)
>>> delete mode 100644 include/asm-arm/arch-omap/hdrc_cnf.h
>>
>>
>> Wouldn't omap3-beagleboard.c  and omap3-evm.c need a similar change?
>
> Yeah :-)
>
> but for now I only played with omap2. Omap3-based boards I'm still  
> doing
> ;-)
>
> That's why the patch is marked RFC.

I was wondering what would happen if I would test the patch  on  
beagleboard, now I know :)

regards,

Koen


>
>
> -- 
> Best Regards,
>
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-2-318194975
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIaR5VMkyGM64RGpERAkA0AJ9aVseht001Wbty2Sn3/D7di85BnQCbBxyq
JQ6eQe8Veg34oEAtSXoSOVM=
=/6kt
-----END PGP SIGNATURE-----

--Apple-Mail-2-318194975--
