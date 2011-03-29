From: Sebastian Reichel <sre@debian.org>
Subject: RX-51: Platform support for lp5523
Date: Tue, 29 Mar 2011 19:29:22 +0200
Message-ID: <20110329172922.GA19494@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:52244 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752341Ab1C2R3Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 13:29:25 -0400
Received: from sre.ring0.de (unknown [93.223.91.28])
	by smtp.ring0.de (Postfix) with ESMTP id DF0578148A
	for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 17:37:08 +0000 (UTC)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Is there any reason, that the rx51 platform code does not support
the lp5523 chip? The chip driver itself is in the mainline kernel
since 2.6.37-rc2.

-- Sebastian

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNkhbyAAoJENju1/PIO/qa0ocP/A2oJXF58nLFUCYdIK0Jv2Bm
Gn9xkR6/RwKCX+H7WQYSMOVvgGTR1SDW3cd5sPfRoUSymVu8toG4Bm+nNwbs8bVo
CrdJVixW2MK+T8ORufGYc+2gkspGxa8S2JS0wsDWFQqLVg1OqBBkFEFVQwZx/KaZ
F7WqMIc9R6AcpJo7kDnL3jWRjLrxxWRr97ObRzjLhzjul0boubkE4lwLhQJLaPEK
aIosE+5cU7PzH/DGMM34fJMdxDdUNUu5xcmCnPRUaTf46mnT863itr3HszFnDX6N
cVXy+NhEjOzxX13sSLq4kaCcBmseP1jAy29nhLjDzL0A8bsrG/9HIFiBBNYhHVtb
CwZyjBGgWiSEPis4aPkRr87kgHzxYbAA4nJ1++UugMoCO6yxPJLA9M/lOAYXV+zO
XK2qaprA7enXNOFyPbdqo9NTntCyHT9RnzMFGn+MP12g9ppVpIoMnfyMK+vG4rvW
9FkcWoLrBu1g9STFCnA4DQIx4UY+rJZsTRDasxNjg8q371vBCxDq2P1rBTy0rzsd
6+hybbPs9Hhh8BJ919CQdJlo0qtWPcMKBy0M4c+fpWfD6ULf+OcA1TDw2gQIL6s6
R0c3RHkK2R5SYNPUPyTMZth29LDwOx3qQxsBe4ha+cZWCjrhB2HLG5tpKn15/Ymv
EFuz5gLMsiLgLCLOBvjG
=xw92
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
