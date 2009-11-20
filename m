From: Maxime Petazzoni <mpetazzoni@mvista.com>
Subject: Re: VDD1 voltage after resume from idle
Date: Fri, 20 Nov 2009 19:31:42 +0100
Message-ID: <20091120183142.GD2354@mvista.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE5BC@dbde02.ent.ti.com>
 <20091120162933.GC2354@mvista.com>
 <87my2h3v9t.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hu47.mvista.com ([206.112.117.47]:42292 "HELO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with SMTP id S1753643AbZKTScS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 13:32:18 -0500
Content-Disposition: inline
In-Reply-To: <87my2h3v9t.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

* Kevin Hilman <khilman@deeprootsystems.com> [2009-11-20 10:29:02]:

> FWIW, the vdd*_opp sysfs hooks were for initial debug/dev and should
> be considered experimental (a.k.a broken.) They will disappear from
> the PM branch shortly.
> 
> CPUfreq should be the only interface used for DVFS.

Ah, well then I guess that fixes my problem. So, was I right on saying
that CPUfreq is "taking control" of the OPP values on wake up? (just
trying to make sure I understand how this works correctly).

Thanks for the info,
- Maxime
-- 
Maxime Petazzoni
Linux kernel & software dev
MontaVista Software, Inc

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksG4I4ACgkQ7KsOe4Pmrg3LnQCeNga9YEP8Fo1ds3HBAZ7WZBI7
GJsAoITBmcapBGE9ZQjZTmm0RbO2jbS+
=z1nN
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
