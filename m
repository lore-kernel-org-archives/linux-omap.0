From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 3/3] rtc: omap: Support regulator supply for RTC
Date: Tue, 28 Oct 2014 15:11:16 +0000
Message-ID: <20141028151116.GV18557@sirena.org.uk>
References: <1414490332-14856-1-git-send-email-lokeshvutla@ti.com>
 <1414490332-14856-4-git-send-email-lokeshvutla@ti.com>
 <20141028150148.GE8123@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yzwzo2Lpb9tBI5S/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53332 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbaJ1PMB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Oct 2014 11:12:01 -0400
Content-Disposition: inline
In-Reply-To: <20141028150148.GE8123@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, johan@kernel.org, tony@atomide.com, akpm@linux-foundation.org, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, nm@ti.com


--Yzwzo2Lpb9tBI5S/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2014 at 10:01:48AM -0500, Felipe Balbi wrote:
> On Tue, Oct 28, 2014 at 03:28:52PM +0530, Lokesh Vutla wrote:

> > +- vrtc-minuV: Minimum required voltage in uV, If default voltage needs=
 to be changed
> > +- vrtc-maxuV: Maximum acceptable voltage in uV, If default voltage nee=
ds to be changed

> huh ? minuV and maxuV is already part of the regulator binding itself.

No, they aren't - there's bindings for setting constraints but not
bindings for setting values in consumers since consumers generally
understand why they are setting a voltage if they do so.  I'd expect
that we'd have a property for whatever system feature might cause us to
need to explicitly set the voltage if we need to vary the voltage at
runtime, or alternatively for systems to set a voltage through the
constraints on the supply rather than having properties on the consumer
- why are they here?

If for some reason we really need these properties they should be -max-uV
and -min-uV.

> > @@ -514,6 +516,37 @@ static int omap_rtc_probe(struct platform_device *=
pdev)
> >  	if (IS_ERR(rtc->base))
> >  		return PTR_ERR(rtc->base);
> > =20
> > +	rtc->supply =3D devm_regulator_get_optional(&pdev->dev, "vrtc");

> I'm not sure if this is optional either, it's just that many of our
> current DTS don't really pass a regulator to RTC, right ?

If the RTC can run without power that would certainly be most
impressive.  I can't see any reason for this driver to use anything
other than a standard regulator_get().

> > +		if (vrtc_minuV && vrtc_maxuV) {
> > +			ret =3D regulator_set_voltage(rtc->supply,
> > +						    vrtc_minuV, vrtc_maxuV);
> > +			if (ret) {
> > +				dev_err(&pdev->dev, "failed to set volt %d\n",
> > +					ret);
> > +				return ret;
> > +			}
> > +		}

> I'd really like to Mark's comments here but I was under the impression
> that if the binding already gives min_microvolt =3D=3D max_microvolt then
> driver shouldn't really care about a set_voltage. Mark ?

That's what happens for the standard properties on the supplying
regulator, these properties are separate to that.  Like I say I'm not
sure I understand why this is being done on a per-consumer basis.

--Yzwzo2Lpb9tBI5S/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUT7IUAAoJECTWi3JdVIfQu78H/ifkVg7vhquFaJAD/XLQd87h
pPXUhWJfprKyn3giq5pmMbr+CsAF9wwkeui9hYPPqvumFEN46dPCkMdiegkypXsv
15ZGoBdB3lUdX7dzMY8vvHD8G35rVUHIiemqYU+iX1xAfm+N+MgjP6dp4SSRKuXu
jgqwzQHvCYCs/xDjCGhN+S0ZU18cckvqZaNIkixE3OWnQ1Ex1dC14d7ydpKiSWwd
8eg5ScKGMp4dbyjWtNAvQOZbEO3Dx3Rm+5u4YxXd/dm7UxavUpoge4TwS6xGqxKk
LNnhd8ywQL1jKABQdt70M0736i0UtJS32TQEOVYiccEa8akhzF7MaC/e3dfCoOc=
=KyNh
-----END PGP SIGNATURE-----

--Yzwzo2Lpb9tBI5S/--
