From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: call/normal switch was Re: omap4-droid4: voice
	call support was
Date: Fri, 6 Apr 2018 14:23:46 +0200
Message-ID: <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
References: <20180331195524.GB19388@amd> <20180331234314.GZ5700@atomide.com>
 <20180401131852.GA11086@amd> <20180401153631.GA5700@atomide.com>
 <20180401173012.GB5700@atomide.com>
 <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
 <20180402155754.GD5700@atomide.com> <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2168415748573824120=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180406120423.GA18691@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2168415748573824120==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Yg6daGM2LthClS44kTC15S8eIOJ1qdktd"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yg6daGM2LthClS44kTC15S8eIOJ1qdktd
Content-Type: multipart/mixed; boundary="1PGQP6m7Ci8bnWYKtrlqnHrPe51cDuysD";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Dan Williams <dcbw@redhat.com>,
 Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Message-ID: <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
References: <20180331195524.GB19388@amd> <20180331234314.GZ5700@atomide.com>
 <20180401131852.GA11086@amd> <20180401153631.GA5700@atomide.com>
 <20180401173012.GB5700@atomide.com>
 <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
 <20180402155754.GD5700@atomide.com> <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
In-Reply-To: <20180406120423.GA18691@amd>

--1PGQP6m7Ci8bnWYKtrlqnHrPe51cDuysD
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/04/18 14:04, Pavel Machek wrote:
> Hi!
>=20
>> OK that explains why the speaker keeps working then :)
>=20
> Ok, I pushed new version of unicsy_demo.
>=20
> It now sends & receives sms and you can call & receive call. Tone from
> linphone is used for incoming call. User interface and code is
> slightly weird, as ofono was -- and still is -- meant as a backend.

Great news, can't wait to try it.

Did you modify ofono beyond the patches you have already posted? And
what version of ofono was that for?

Cheers,
Merlijn


--1PGQP6m7Ci8bnWYKtrlqnHrPe51cDuysD--

--Yg6daGM2LthClS44kTC15S8eIOJ1qdktd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWsdm0gAKCRAGN09rynK8
Ws8sAP93UQwdDXpLrVbWYOChCd2Wq4VDL+W97apx969J1TFVDAD+I8heEI3NZTVS
BWnO78TUDpWCIQxqBLeD9VVDLEPeLwA=
=nLpl
-----END PGP SIGNATURE-----

--Yg6daGM2LthClS44kTC15S8eIOJ1qdktd--

--===============2168415748573824120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2168415748573824120==--
