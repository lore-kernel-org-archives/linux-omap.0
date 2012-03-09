From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: OMAP: Build config cleanup for McBSP
Date: Fri, 9 Mar 2012 12:50:03 +0000
Message-ID: <20120309125003.GY3273@opensource.wolfsonmicro.com>
References: <1331283078-14846-1-git-send-email-peter.ujfalusi@ti.com>
 <1331283078-14846-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vavxEBoGuREFpPEl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44152 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753711Ab2CIMuJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 07:50:09 -0500
Content-Disposition: inline
In-Reply-To: <1331283078-14846-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>


--vavxEBoGuREFpPEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2012 at 10:51:18AM +0200, Peter Ujfalusi wrote:
> The McBSP driver stack has been moved, and rewritten resulting a single
> driver - selected by CONFIG_SND_OMAP_SOC_MCBSP. There is no longer need to
> have CONFIG_OMAP_MCBSP anymore.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--vavxEBoGuREFpPEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWfxzAAoJEBus8iNuMP3dbugP/AwMCc7TbmVDbhqjzSOiQ1T/
s0vcVIjC8KBjse4DgKe+2V4RcNZQwywdsyg8HrrA9kiHGGl24+FMMsPE6crQdoDp
+hqqQfEB86S505aRxEjbWGTJ+kUTZE4OFAL4OQY3iKOFuR9E+wWoqyFmEaB06/Uo
XdLqr226SEQ/M+CNaLVm76DuXhIhIXDHShr4apDE2MahVWE2YfZCP7KYwjLeXdv3
j7gnim7255vV2dh2+Gki0COBVZ7OPuytq7lwR93IsYrMF9MznmZB4DBbLr7WWcM3
9T+VB2NyN1+umYK1WQrpgePiLvR2EhCUajxnjPz+Oh70oHuIsxJqhnVOzAnNhREw
UE5PI50c1xeZlSBZdc75NMogXH36nIvuRRAMlAHnS1g25BSCYoDrnLEXBA4W+ZGr
iShgcKVuXaJrUloHAvnAD6gD+PgqL/uwfUSFBco3VlgkpCJyNliAki5YiDW0gWSK
RFgRLAuYALO/Mosa/VJ0Vw2FwUI+LGvTYn1k0cmKUYoCK3fzUMmU8Q1F7aLjn5rF
JQp0iCcQdj1gJL3SLsLWTTTFKSAsuvB8AlOTkiKGsooenH+AhejsNnhAve5KQ2+V
5OW2XsDyxSNkCMLSzacL2CTJuWQnkxVUq1Nlco5395oMv4kgfJnmomz8yD+6YU7S
bfMg6WrMksIUnqMaEwei
=GFOJ
-----END PGP SIGNATURE-----

--vavxEBoGuREFpPEl--
