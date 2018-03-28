From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Wed, 28 Mar 2018 16:02:19 +0200
Message-ID: <20180328140219.f6667up5evrrafkv@earth.universe>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3395156663064364246=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180328022910.GM29239@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============3395156663064364246==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kv4lnffrs5agllfz"
Content-Disposition: inline


--kv4lnffrs5agllfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 28, 2018 at 10:29:10AM +0800, Mark Brown wrote:
> On Wed, Mar 28, 2018 at 12:22:37AM +0200, Sebastian Reichel wrote:
> > On Tue, Mar 27, 2018 at 08:14:41PM +0800, Mark Brown wrote:
>=20
> > > No, this is exactly the sort of use case with multiple DAIs that the
> > > graph card is intended to enable over the old simple-card.
>=20
> > +----------+         +-------------+
> > | OMAP4    |         | CPCAP       |
> > |          |         |             |
> > | [McBSP2] | <-----> | [HiFi DAI]  |
> > |          |         |             |
> > | [McBSP3] | <--+--> | [Voice DAI] |
> > |          |    |    |             |
> > +----------+    |    +-------------+
> >                 |
> > +----------+    |    +-------------+
> > | MDM6600  |    |    | WL1285      |
> > |          |    |    |             |
> > |    [DAI] | <--+--> | [DAI]       |
> > |          |         |             |
> > +----------+         +-------------+
>=20
> > Legend:
> >     OMAP4   =3D SoC running Linux
> >     CPCAP   =3D Audio codec
> >     MDM6600 =3D Baseband
> >     WL1285  =3D Bluetooth
>=20
> > Re-reading the audio-graph-card binding document I still don't see
> > how the network (OMAP.McBSP3, CPCAP.Voice, MDM6600, WL1285) is
> > supposed to look like. It seems to expect point-to-point DAI
> > connections.
>=20
> Ugh, a TDM mux?

Yes, at least that's how I understood Motorola's code.

> That's really unusual and not particularly supported yet, you'd
> need to extend the graph card to do it.  It's where things should
> end up for a generic card though.

Motorola's driver provided the following modes:

OMAP4 <-> CPCAP      (voice recording)
MDM6600 <-> CPCAP    (voice call, CPU not involved)
OMAP4 <-> WL1285     (bluetooth HFP/HSP)
MDM6600 <-> WL1285   (bluetooth voice call)

In case of the last two variants, the bus clock is provided by
CPCAP, so it needs to be enabled for any audio stream. I suppose
the codec <-> codec as part of TDM is out of scope for the graph
card and we need a Droid 4 specific card driver?

-- Sebastian

--kv4lnffrs5agllfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq7oGUACgkQ2O7X88g7
+pq2rQ/7BsWFnlf8oYXVK859+eH8vI+FlsTQd7NiOXuIPaaTt00faOY8sJHxt+RQ
NfR8FM0i2meCUlT+NrncqKXKb+TPBc4FzmEk5JspEFa6bZIsk0uGOGveHwy7p7lY
yEpnHM8rcODMUXXZnfVJxQI+PImEZvSStF8jYf47snO8oL48m890gOZnAv4EzeCf
YFvjJ0s7z7jAab1OIAX/gBzX4X8MeImjftrbgYrfvbQj3XycVrKw2DlinF7rE9Rt
NyrGS4ieX20ff7+G+e2ZomHyJwfnedRqLzAcPRdj6P1iDDhWn4BXSXsTiSDTFAdR
MqUq2QzjAP2RYsfxOrme3ayprzdK7LAawzDJCzZj56Noe+KMyPPIlpbGrTdxP6+/
u98cRnp39/YA5mDgF/mQb6lsiP8ALD2+ai78N306FKtdQyJ+LYGH4KdTzpMGY6Vt
Gpz3ikp1nOtR4Y5txQtW1uiobKuS1KUihdYy5Y0jJxQxHTnYm6mqDLCL6CXiqnng
dpaeYXbpHja/Doi9kzYQs8IIQT5nSETYEb5nv0CRDp7bIPtdb+nnbuZW0EuRWytS
bYKye39R+7WCLPRazVGfuLS3c0YMHgGq0iVQSeLeGuL1uMewAkxsZt0cijgWuAv2
jVA66wXnG0vpJU/aHtgCjwgj3bPIRs1oxrp6RWDCvty4os0grAI=
=CxnS
-----END PGP SIGNATURE-----

--kv4lnffrs5agllfz--

--===============3395156663064364246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3395156663064364246==--
