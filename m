From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 04/10] ASoC: omap-mcbsp: Create a single driver for
 McBSP
Date: Wed, 29 Feb 2012 23:31:29 +0000
Message-ID: <20120229233128.GG8295@opensource.wolfsonmicro.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
 <1330414820-4641-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54393 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756760Ab2B2Xbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 18:31:31 -0500
Content-Disposition: inline
In-Reply-To: <1330414820-4641-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2012 at 09:40:14AM +0200, Peter Ujfalusi wrote:
> The OMAP McBSP driver stack used to contain two different
> drivers. One of them was used as kind low-level access to
> the IP, while the other driver was the ASoC DAI driver.
> There were global, shared structures, in different places,
> the McBSP instances are reffered with id numbers (sometimes
> 0 based, in other cases 1 based id numbers).

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTrVKAAoJEBus8iNuMP3dp4cP+gJVpWgkYccR/iuhOL52A7Xb
wFq4BHIzmsMPWaThFtGuakzSBAIq4abp9i6CESBAvwmo50B05SQlUf8CW02CEIyS
GZ0YWdoVHt/PAfDpczXWMSKhLLffBvU7T9a2U8+Z+uBch2Z/4f7kffSXktxMQB30
a1LoC9niiNwNVxC7/5cLgEDigHIdy4pfLD5BAki7c9SQiAnq5SysRyFrBWZuwpQs
f4oS7caxLiBVl4k67rgHGLqrGKHD9SB7ktjgmEpuS/Q33HjxBxS/ESqmVXX+stQQ
4wQTXND4KhqvhLy7Z2e/8RAZ+uvrmrekDb+jsWF66g3Q1PqU4fzlFkjeCbasap/M
JXwZx/0reVm4qsV1DDB/tLcHnxg/+hLnONpTjDQCxVsk4u2LUVFwszKNWWzo2Mcm
D3l2ut2d/ndVEiFwrorIobowqacWuLlHngAIbqn02Ymu7tF88Tn/4EfD7oklfy8Z
Bl6eU7PPLP9XEnQNK3dox1Zf6k1sG0oKrEJoOoxEsf54HIo5YnoHa0SQFveitMWU
4L4+LH9tdIdB0wTHJ30C9mURiIgjNE1re9uWFntPDtcu0V9psmXufgC5QMC/PnMP
7oZVIbTx1UKHzvPmc2uqdSpUZddK8X38mCKkq6g9uKOIRL7jOz5PzagzVYsCfPcq
oaK6TKnkH1YQQSPRlxrL
=KU9c
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
