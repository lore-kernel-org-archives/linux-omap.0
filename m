From: NeilBrown <neilb@suse.de>
Subject: twl4030_charger seems to be broken by switch from 'notifier' to
 'mailbox'.
Date: Fri, 14 Dec 2012 20:04:27 +1100
Message-ID: <20121214200427.2405f30a@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/0po2cNPvW8Bl.Fj8ANwu4R0"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60711 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab2LNJEl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 04:04:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

--Sig_/0po2cNPvW8Bl.Fj8ANwu4R0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


Hi,

 this commit:

commit c9721438c009adf8e81d376839ed037c53b9b8d9
Author: Kishon Vijay Abraham I <kishon@ti.com>
Date:   Fri Jun 22 17:40:52 2012 +0530

    usb: musb: twl: use mailbox API to send VBUS or ID events
   =20
    The atomic notifier from twl4030/twl6030 to notifiy VBUS and ID events,
    is replaced by a direct call to omap musb blue.
   =20
    Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>


Seems to have broken twl4030_charger.c.
This code relies on the notifier to know when the USB has been plugged in a=
nd
so it should consider enabling the charger.

now that the notification has gone, the charger never turns on.

If I put the atomic_notifier_call_chain() calls back in, then the charger is
activated as appropriate.

What is the plan here?  Should the calls go back, or is there some way for
twl4030_charger to hook into the "mailbox"?  Or is there some other way it
should work?

Thanks,
NeilBrown

--Sig_/0po2cNPvW8Bl.Fj8ANwu4R0
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUMrrmznsnt1WYoG5AQLtiw/7Ben+KqiSFzhxDXnlYg1FR8GatLHo6R/d
qe37QIyd5H0mG6oY7bMOvQxxfep0/Y+oCmoQIQOYBRYbo1ZqqP1nPxqFAYmIU+3p
8yNe3qIBfQ/PYAzlCKafrzTRQDR1ayTQFBwwdjFIvsiCM4tttsqcXnjFReOOsM2Z
6pQY+jLrUb++OjeAkFx9+8y83Mb5XimmdF4C4nRLfr/Yxk2gQ9qTJfOg8/SAFMUI
FodBVbH7LMgyMJWEm2TrtCFPH2b+voWpjAznhKZh9fTgmg/BgjyGMgrBQuh4KFHE
+0nDhNIr57dMriFbCdwzY6hsdtYy3spStndlKWbdzAzGJiwrvpabnLVljOryclvm
gE2sXgG3t35iVcK6gjNjyPg0p5nfKt8nM6gnn9fkFG0Km+H47DXSCevrSANrSdj4
d5JcQC3m05bkYHJHh3WugwYTtQ5eLznah5NRbJpJRvWFooHnKO4nrBKoblEWmOhD
kVLEUviPb+n5Bcic21THuiyiFh5BE4Y2luFpGmENR92Qrs7jss/fsPgVUxS04vdf
Col5BXUW0GULFRNoyWFNY9NexBhGIJplsxGpi7tgj+IN/g9KK/6sd9eLmjbtMJya
hxDdnnUcQDldq9kUvfb9Gd+Rbudp7M/MlVraqCyp6BiF2rWAcB9xpZVcpPvxulcB
FZgXjphruKE=
=DmgL
-----END PGP SIGNATURE-----

--Sig_/0po2cNPvW8Bl.Fj8ANwu4R0--
