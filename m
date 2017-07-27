From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 0/6] Motorola Droid 4 Audio Support
Date: Thu, 27 Jul 2017 11:23:21 +0100
Message-ID: <20170727102321.gq5ttxd4vcxcn4yz@sirena.org.uk>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
 <20170717092904.GG10026@atomide.com>
 <20170717101258.llyly7kwfnwtoftr@earth>
 <20170717101709.GI10026@atomide.com>
 <20170717141347.t2642xbkol3g36rv@earth>
 <20170718054833.GL10026@atomide.com>
 <20170718092931.be3lyp6m6xvjb5yv@earth>
 <s5h7ez6ccgm.wl-tiwai@suse.de> <20170727093943.GC10026@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5246149484835968958=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170727093943.GC10026@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============5246149484835968958==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5pshuhw4ekdubyav"
Content-Disposition: inline


--5pshuhw4ekdubyav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 02:39:43AM -0700, Tony Lindgren wrote:
> * Takashi Iwai <tiwai@suse.de> [170718 02:38]:

> > The problem manifests itself as an unblanaced of node reference.
> > The node is released mistakenly at of_node_put() and this is caught as
> > sleep-in-atomic, fortunately.

> > So likely either something forgot to take the node ref or it hits the
> > unreference due to the missing object by the implicit probe disorder,
> > etc, I suppose.

> Yup you're right. This is what happens, will send a fix for it shortly.

There was also a separate thread where people were trying to fix this
having run into it elsewhere.  The of_graph APIs look pretty confusing
=66rom a user point of view sadly :(

--5pshuhw4ekdubyav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll5vxgACgkQJNaLcl1U
h9ABAAf/aUte/JM4cSp+xi85Km1CU0rB38QE5HFirgzYSf96aJdTA0gt78efZ9ba
HszuD3Q0vK8wefBA929fcCtoycA/9zH4gKWRm6QLOGE5pG6bQyScjpUGDEA/e2NK
2+eg0u4li2eRJ3BLOzHCiaP+UEbSMezhbA+ZaqR03q4ArWDiKyRHdWX/P1csUp4L
rZaao2RWdufEkKfsM0IKpwqa/oWVC0QTX53OTIK7ssciO+/tKGBpYyOtg5SNxdwJ
5rtsrqM0Q4r7v5rr3U0ASL/UP9ZTssyBUKPCQuC2BvcrwhD2Za30Dg58DvsrKdL/
Wrpm7c3rkfwX+LGfHr9Vi2FAKfBvNg==
=6EYK
-----END PGP SIGNATURE-----

--5pshuhw4ekdubyav--

--===============5246149484835968958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5246149484835968958==--
