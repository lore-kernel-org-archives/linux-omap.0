From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot in
 DT only mode
Date: Tue, 26 Nov 2013 15:25:30 +0100
Message-ID: <20131126142530.GA32406@earth.universe>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <52949790.1010900@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:43048 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757128Ab3KZOZf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 09:25:35 -0500
Content-Disposition: inline
In-Reply-To: <52949790.1010900@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Nov 26, 2013 at 01:44:00PM +0100, Florian Vaussard wrote:
> IMHO one remaining issue is the missing binding for the camera interface
> (ISP). I saw recently an RFC from Sebastian Reichel to add the necessary
> binding [1], but this work will probably take some time. So probably a
> quirk is necessary here to bring up this IP.

My DT patches for omap3-isp won't be ready for 3.14.

-- Sebastian

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSlK9ZAAoJENju1/PIO/qawLEQAJ435hFECb0rhScmy7gZ28Dw
SuVuSMWfU/8pU+XC2rQj0mhRFtFdQWvttRm+EHhApDwvUGIXQjY9cJbveyenknXY
WvdrkNuS4F8pI/hK7FeRVtdzndCs4jAKXl7OT3VjgKISmm4bjHN1Hfn8lyukA9jh
pa0E0zfwATAEc2FchvU/8uRvmQj/kmDod0ZAoDGOpJ/6ZaOYlJIxCpANEy/RGJWU
g6F0TUuriRJW95hEYKnfHXH4p5Y6tHa0eVehoAdec9+YgGuRoMEDzuhpduHLrAxp
OR47e/Fct9ZK9ebE7xqV0JZTTSqdX3EaAbdlB/7kbDjO3vsFpWHw6csdygwRB3b8
03xY1k6Cf2P/tSNIArZXgBKr1lTudV29J0jE4n80fFQ7rkIAPZXRcw2DaCuQiRnk
SLSLyL80OFR3RUVNjpBBwhPdPpQn59Hc50lrn9KYD9ntkw8IyjRJ3/ao9zuD3YNL
jm2fyyFGBy/P62NOhUjtS00gAl1eeXP2ZI2QRC/m6qGuEy1H4qwcjKnGwEQLbGDA
CrvzXS7eka9cxORK72qXA9ztLBCsrjmbWY74D/8r/9uGLS+6B5dnlfZ++Jxfp+fG
65Xl67c+RsB9+k4HgVM9l4RPTmuZezhO/tkpvwx1N7CRRjkWl6SsmU9Ho6rqri5I
BCmoalOntec+68QHAbWC
=+py/
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
