From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 15/17] OMAPDSS: remove extra_info completion code
Date: Thu, 06 Sep 2012 16:04:41 +0300
Message-ID: <1346936681.2737.61.camel@deskari>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
	 <1346833555-31258-16-git-send-email-tomi.valkeinen@ti.com>
	 <50475444.2080509@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-eRix5lGB9BPPNb98Ex/t"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43326 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751436Ab2IFNEr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 09:04:47 -0400
Received: by lagy9 with SMTP id y9so1073016lag.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 06:04:44 -0700 (PDT)
In-Reply-To: <50475444.2080509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-eRix5lGB9BPPNb98Ex/t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-09-05 at 19:01 +0530, Archit Taneja wrote:
> On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
> > Now that fifo merge has been removed, nobody uses the extra_info relate=
d
> > completion code, which can be removed.
>=20
> I think this might come into use when we fix the usage of channel out=20
> field. That is, since channel out is an immediate write field, when we=
=20
> set a new manager for an overlay, we may need to wait till the overlay=
=20
> disable kicks in, only then we should change channel out.
>=20
> For this, we would need some wait for extra_info, right?

Hmm, yes, I think you are right. Previously the ovl_disable waited until
the overlay is not used anymore, but now it doesn't.

So I think I need to add wait_pending_extra_info_updates() call to the
beginning of dss_ovl_set_manager(). Or, should it be in unset_manager...
I think unset is better, then a "free" overlay always disabled also in
the HW level.

 Tomi


--=-eRix5lGB9BPPNb98Ex/t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQSJ9pAAoJEPo9qoy8lh71pJQP/0PrKEwtxxxDiAOLppjsu+Br
hcl55hkAUhV7uRm1H4KI6sk9lIpHx7V08urRCd25NaXbg4lCEpKh4r4jPQhYqADg
heYr9Xru7noPn2K4aILmUnEwrKkxaUvN8rg1rWlwT1AfM8Jhv/osm05gmz+pC+e6
eHaBnd3MLcn4VMtX+CB0FRiaM2LhYxF9SGUt4t5s/tu9z7Bmmb6ti8rtYmZ3sK+w
Y27T5+YAwX7FRsEzr2LlVcMzGFbDdtCUAG4RDAc/hdY/44qVLEefh8pn4S/J501b
PqjfiXwdATp1gbYgQHOgZMNNbJWIq3bTxbs4kKkm+1E+LlVoH7LaGQ/ubQVLEg6g
oc2jMqEp16pJ5r+dHp9v1DFbnbQ5n6kfLuSPR8AJFuGh9V2bAxOnF7ZUylQjPNr2
09kabA9uKUclzod/Sg/sOESUOARUJvenOYYmp3ltmB3baztStSuWOKPUJHt2NOp0
L4NYA9USRKTln/N1LzYvBfFYAWkGh+Uf4YcFbYRH2O/o5EpqSfhagUvQTMXnmIWS
8bJcXIh605JtHl9kVEZUOVubPJgsM+2O7YwInPJL3d40j8TadpLOwOAVLoOOjBDa
PstSHiRrwhUxvcK3+egcgqVZQxPUH6/VKASmnZr5/qluNijx93MO5mF6raJlIKwH
f/GWpZ6rOL8qNT+2LkOg
=XqoN
-----END PGP SIGNATURE-----

--=-eRix5lGB9BPPNb98Ex/t--

