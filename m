From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] device property: Fix usecount for
 of_graph_get_port_parent()
Date: Thu, 27 Jul 2017 17:17:07 +0100
Message-ID: <20170727161707.uc36lxpg5x2bxajp@sirena.org.uk>
References: <20170727094405.19778-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bpwpucmuuosseaxz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170727094405.19778-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org


--bpwpucmuuosseaxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 27, 2017 at 02:44:05AM -0700, Tony Lindgren wrote:
> Fix inconsistent use of of_graph_get_port_parent() where
> asoc_simple_card_parse_graph_dai() does of_node_get() before
> calling it while other callers do not. We can fix this by
> not trashing the node passed to of_graph_get_port_parent().

This looks like it gives a much less surprising API so hopefully helps
avoid issues in callers:

Reviewed-by: Mark Brown <broonie@kernel.org>

--bpwpucmuuosseaxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll6EgIACgkQJNaLcl1U
h9B+OQf+N+0ajW5ZH/YBmCCSI/SUncBjj4w16WX6pS1o6C17X3UdY2ZSVQBUOM7j
dwS22opewhLX2Pfbr6zEIMeanLSDq5pec2amVPTLKmTc1nOhiqODL46D+e65ZANI
Tv/ZGi6SCVnHn6yh11/eOh2AQfiC6bg0SuP9Nueb4XF2/+tKpe7DZkmc65dobMcR
p8tLJgXcHcpTjdrybIO8P3UomsuoDasI7NAid1kCyaan2zo6uLtjxFPv5xZfNs1k
6hC4znKV+jYaHyrg021vgi6tMM81RCu/4DhEBPXJvE0HIRVMIsbifHz1Cn79SiXJ
LpQlDqMjz8N/Z37U+bg8U5Qk/gpthQ==
=KMaW
-----END PGP SIGNATURE-----

--bpwpucmuuosseaxz--
