From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: snd_soc_jack for HDMI audio: does it
 make	sense?
Date: Tue, 21 Aug 2012 13:05:12 +0100
Message-ID: <20120821120511.GB7995@opensource.wolfsonmicro.com>
References: <5032E8A5.8070108@ti.com>
 <s5hlih895kt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2747477949912194840=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hlih895kt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Ricardo Neri <ricardo.neri@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Guiriec,
 Sebastien" <s-guiriec@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============2747477949912194840==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 07:28:34AM +0200, Takashi Iwai wrote:
> Ricardo Neri wrote:

> > I was wondering about how much sense does it make to you guys use a=20
> > snd_soc_jack in this case?

> HD-audio already uses the generic jack event for the HDMI/DP
> connection change notification as well, so I think it would make sense
> in general.

The whole problem here is that we don't *have* a generic jack interface.
We've got:

 - sound/core/jack.c which was written to be a generic API and is used
   by everything that does jack support currently.

 - sound/core/ctljack.c which was added later and provides separate
   in-kernel and userspace APIs and is currently only used by HDA.

 - extcon which does have a good reason to be a separate API since that
   it's not audio specific (and is likely to be picked up by Android as
   the code was originally taken from there); it's currently not
   supported by the frameworks in ALSA.  I'd suggest Pulse should be using
   it too.

This is a complete shambles for both driver authors and userspace, the
ABI varies randomly with drivers and in theory driver authors have to
implement everything three times which is just nuts.

What I'd like to see happening is that we merge ctljack into jack (since
only HDA is going to be affected by that change it seems like the right
direction to make the merge) and also add extcon support, I have looked
at the extcon support.

Short term for drivers used on embedded systems I'd have to recommend
extcon rather than anything ALSA-specific.

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM3cQAAoJEFJkBDiqVpZ4RUkP/3MYbWl0tz76hqaxIRdiEqjC
VPvFOjIq2MCw+848IhHj3Gyu7U4Nb20eOZdrxXeGJXO5D79sR9bOlo9NSIIiN+Tj
1xc6CqeVuZnUIEHXU+WvGQvemxUFVY+2n8qj1Bs8Rr1IDZoXZkha/qDsZQPqFtRT
dMupl14B65RCtxi6C1GZ9iFXD3hVkNvfPxVskFDVP/M9SQeZZPGP5HFL9mCr5VSA
tDKPePqHQF/dXGrE5yMzV0PxA9ex2tHq8AFTI5xk+vDx7eP67hHkNcA2HBudXZCR
MqlSrCwcWlWfUUziEYFe137lt3hcsGRn2XvC91l70iWtth496u1WPJu76vfTp5SR
Yr50VLCCBrzb9ynOmCxsQueORu16r9n+XDSV8cMfG/QUgW0/Z5l/4cl5J07xTgvg
/BwwPpjBUIMTB9KaI8tg4UdIiLWD4hm4372LNLbG3cVP7RD5IXTq3DzYCyuGeDyh
IyGTQFmH/eSK/mxDCi3NTKfhLMedBABMKS+QfVND/VoEPxWjLH6fyWYoSdw5fCO+
6nU8memN5K3DR9pmfmUgnwYGaBjgXE3SoGzjLw0xuxISi5qmRPKzvG5JB7hcnEtJ
tWbfAoC1POvclSDaCyEZfWJwXOM02Nab5ETBdE+y46C5vcU2sVfz6jj0KaTvJCM/
WK8nrzcfW3BRH3xbDlEn
=m50x
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

--===============2747477949912194840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2747477949912194840==--
