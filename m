From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH 0/2] Make N810 keyboard work with console
Date: Thu, 15 May 2008 11:58:52 +0300
Message-ID: <20080515085852.GF12699@intune.research.nokia.com>
References: <1210824079-22548-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17579 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbYEOI5h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 04:57:37 -0400
Content-Disposition: inline
In-Reply-To: <1210824079-22548-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 14, 2008 at 09:01:17PM -0700, ext Tony Lindgren wrote:
> Here are few fun patches for N810 hackers to make the integrated
> keyboard work with console :) This should be done in a generic way
> and the old behaviour is preserved if optional sticky keys are not
> passed from platform_data.

Uhm.  If you're going to implement latching/locking keys, surely it'd be
better to do this in the generic input layer than the keyboard driver?

NAK from myself (for what little that means) simply due to the sheer
horror of seeing what should, by all rights, be a tiny driver, explode
into non-triviality. :)

Cheers,
Daniel

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIK/tM68xJuWtYYdURAtVGAKCVbu6CfQie4YogsVePSC6guJESQwCffdAX
bwb0FDi2qnwga6HrsLlm9+k=
=k5nN
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
