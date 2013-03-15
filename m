From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 0/2] ASoC: OMAP2+: Update Audio IP with sDMA binding
 for DT boot
Date: Fri, 15 Mar 2013 17:05:47 +0000
Message-ID: <20130315170547.GD8988@opensource.wolfsonmicro.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
 <51432FEE.4060709@ti.com>
 <20130315165609.GB8988@opensource.wolfsonmicro.com>
 <514353E0.8020906@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37898 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755316Ab3CORFu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 13:05:50 -0400
Content-Disposition: inline
In-Reply-To: <514353E0.8020906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2013 at 06:01:20PM +0100, Benoit Cousson wrote:

> Having the DTS without the ASoC change will do nothing, so it is fine
> merging them separately.

Yup, that's good and minimises the risk of cross tree issues too.

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQ1RkAAoJELSic+t+oim9he0P/jPLHSdBIova8GjMsAWl5dU+
8yxhuHP073MuvK84w3h6PzTDctraJrn8Jyb1JXEbnDoWqh441g6qvaDC+jiZ6isd
H+R+k4qd7zVnP9XqHuBcA3nN+U0X+OYyUBc8TiZX+UFaEzkoUWJeb1lb2YyeWeHZ
nkdaojaOlbqCZLdBhsHrOwCm4MrzURH89ly6JDv8nB1JIyBwk+MfyMDErOfSfUXj
4NL5IO0d/VqqKd/GWM0Vg2uJ5zWtMucR6djOqjVMEM5LdRkaI0MfznlbRcTsgHd2
VdIDjzfcoiBRV8EBXXDPYlZnITpyX2PENfsvF0Rp/BrTWzPRijv+s8en26JjfP32
HBPN6z/H4NqpfBysbwb1b7fYk1P5YRb7vJWxkwKttftegkog6sC2v58xw81RxWJ4
oWvb2CCre4az5w36KQnzjq34a18IiVx9GmRZlY6pEWeXb/Dp59Gh2yI0/gkGL0QI
ijyPH1ND4RNIrejhouzivC8kpWPk4+uobkv13+ikyinMcio0i3G1QwdMIVVEqJxN
Q3Idgtak4MwtGY6ZI4FNhpaDZp7FdQCWy581vrtpWa5ZwaQll+sPjnVkxTfvsRZv
+1z+sNHYdhExdr7Cmg36j4A/di02+1bHSbZgj09lD/BmPEdeA9iV0PWlVhghCZGR
C2MuY8EP9MzPOEvfUUHR
=xJ+R
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
