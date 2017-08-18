From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv3 2/6] dt-bindings: sound: add motorola,
	cpcap-audio-codec
Date: Fri, 18 Aug 2017 12:47:30 +0100
Message-ID: <20170818114730.57yc2r6d3temrepa@sirena.org.uk>
References: <20170725151030.26863-1-sebastian.reichel@collabora.co.uk>
 <20170725151030.26863-3-sebastian.reichel@collabora.co.uk>
 <20170726114827.pye3jm2b7x2nqo5v@sirena.org.uk>
 <20170727090141.sxzm6mq5cv4jzucg@earth>
 <20170810165358.GK8569@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2782198961296867222=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170810165358.GK8569@atomide.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org


--===============2782198961296867222==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mk63f6qznskjx7fv"
Content-Disposition: inline


--mk63f6qznskjx7fv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 10, 2017 at 09:53:59AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170727 02:02]:

> > I don't follow you here. Why can't other parts of the chip use the
> > same supply? Regarding the other point: Handling the audio-codec

They can, they know they're part of the parent chip and should be
looking for the supply on the chip level.

> > differently than all other sub-modules of cpcap seems much more
> > problematic to me and the codec is basically the last one
> > missing:

> Mark, any comments on the above? I'm just wondering if the
> related dts changes are safe for me to pick.

No, they don't make sense.

--mk63f6qznskjx7fv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmW09EACgkQJNaLcl1U
h9AKCAf9EWXupYCrST1QW4exCFfksCiJ0trEm2Xx2+o96FUOo3EOZ9AoLL/F4pgS
z7LgS+zdMIdITKfWfI/+TljgC2+WLsqys1Mjhq5Xyw1ud584QoXq78n0xp6+Zksw
1NKjfXLhvCtkin6eoCiKuKgMLLvMRnd8gSIS3kOKdqi6uWwEzRdDm0STjZAPQHO3
zjiZczKhrR/aVpoM6GkCMDumRmLocRWFWgBHGRYXuhfYuiNocmgGqFlLj/zs2NJ4
5wSgykajv6cLpZnZIaOonivd6p8BP1x6et1mpEpH9UlHI18ipHK9JRIIo0D3/6PC
CvyjhPEU3k5UpEfvWpuebZqV/jgywA==
=4Hpm
-----END PGP SIGNATURE-----

--mk63f6qznskjx7fv--

--===============2782198961296867222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2782198961296867222==--
