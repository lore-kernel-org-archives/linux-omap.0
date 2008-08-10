From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: omap24xx is broken in current head
Date: Sun, 10 Aug 2008 14:37:23 +0200
Message-ID: <C558C578-1F45-433E-B82F-F5667CEBAFAF@student.utwente.nl>
References: <20080810115818.GG7574@frodo> <20080810121655.GH7574@frodo>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1--453524576"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:3202 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373AbYHJMhn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 10 Aug 2008 08:37:43 -0400
In-Reply-To: <20080810121655.GH7574@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1--453524576
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 10 aug 2008, om 14:16 heeft Felipe Balbi het volgende geschreven:

> On Sun, Aug 10, 2008 at 02:58:19PM +0300, Felipe Balbi wrote:
>> <5>Kernel command line: root=1f03 rootfstype=jffs2
>> <6>Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
>> <1>Unhandled fault: alignment exception (0x001) at 0xc02c1b4e
>
> Reverting commit 718fc6cd4db902aa2242a736cc3feb8744a4c71a, looks like
> gcc is not being able to align that union ??
>
> I'm using codesourcery 2008q1-126 (gcc 4.2.3)
>
> Did you guys have any problems with this version of CS ??

"Broken as hell" if you want to do anything NEON related with it. I  
use 2007q3 with the -Os fix for compiling omap3 kernels and vanilla  
gcc 4.2.4 for all other arm kernels. I would rather uses vanilla gcc  
4.3.1 + neon fix, but then I'd need to patch all kernels for the pld  
problem :/

regards,

Koen

--Apple-Mail-1--453524576
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFInuEHMkyGM64RGpERApurAJ44NelxLAxkqOUzAg5B2BaWD30mLwCfbUWm
Wxp/77se5fyobSWJSk8n+ZY=
=oeJZ
-----END PGP SIGNATURE-----

--Apple-Mail-1--453524576--
