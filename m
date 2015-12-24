From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Thu, 24 Dec 2015 19:35:38 +0000
Message-ID: <20151224193538.GJ579@sirena.org.uk>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk>
 <1450980773.11913.3.camel@collins>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7845735744481694062=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450980773.11913.3.camel@collins>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============7845735744481694062==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="va4/JQ6j8/8uipEp"
Content-Disposition: inline


--va4/JQ6j8/8uipEp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 24, 2015 at 07:12:53PM +0100, Paul Kocialkowski wrote:
> Le mercredi 23 d=E9cembre 2015 =E0 11:56 +0000, Mark Brown a =E9crit :

> > This isn't really adding support for the enable GPIO as the changelog
> > suggests, it's requesting but not managing the GPIO.  Since there is
> > core support for manging enable GPIOs this seems especially silly,
> > please tell the core about the GPIO and then it will work at runtime
> > too.

> It looks like the core bindings for GPIO can only be used instead of the
> rdev->desc->ops->enable callback, not jointly, which doesn't fit my use
> case, where both the GPIO and register write have to be used to enable
> regulators.

> I think it would be worth making it possible to use both in core, since
> that situation is probably shared with other regulators. I suggest the
> following diff (that would be split into a separate patch in v2 of this
> series):

No, that's broken - the whole point with using a GPIO for enable control
on a lot of devices is that it is much faster than doing a register
write.  What I would expect to happen in this case is that when
initialsing the GPIO we set the register to enabled and then only manage
the GPIO at runtime.

--va4/JQ6j8/8uipEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWfEkIAAoJECTWi3JdVIfQ3AsH/jeYLGM1bJ/BheObxioiiFmz
ErauD/7BFjliYshyg37vN036iB8W1/bsw606ibtuylAJpG3ruWe0ygzoLCnANBux
KudQw1GiBdVGf4aaqXMR9yl3dZzvER9xNYoglBAu5k9CiJg19LWgzjmnPbMJz8cD
T+eRY9xZ/czrcqrYpBgU746fRRVmGrjNWeFh7SUSAsfcRVG84ZZBwm9zBC0mqBf7
M4eLq4/Lc+XT2fYsE9D/hsWREAPqCPVN2sHuxRDHK87032HOz9ZJhuk+FW/DXWoz
SSryF/KVeODQa5TeEwcj/ovKehytNr6tNf+kmHnmfQDIYXRImLJqzxst3eXv5Rw=
=3L9B
-----END PGP SIGNATURE-----

--va4/JQ6j8/8uipEp--


--===============7845735744481694062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7845735744481694062==--
