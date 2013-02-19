From: Felipe Balbi <balbi@ti.com>
Subject: OMAP reset requirements (was: Re: [RFC/NOT FOR MERGING 2/3] serial:
 omap: remove hwmod dependency) =?ISO-8859-1?Q?=1B:x?=
Date: Tue, 19 Feb 2013 22:10:12 +0200
Message-ID: <20130219201012.GA10166@arwen.pp.htv.fi>
References: <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130214222247.GE11362@atomide.com>
 <alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
 <20130219163820.GF5724@atomide.com>
 <87ppzww1ux.fsf@linaro.org>
 <20130219193237.GA8978@arwen.pp.htv.fi>
 <8738wsw0aa.fsf@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54995 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757184Ab3BSUKU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Feb 2013 15:10:20 -0500
Content-Disposition: inline
In-Reply-To: <8738wsw0aa.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 19, 2013 at 11:50:37AM -0800, Kevin Hilman wrote:
> >> The other problem is the where reset is need during runtime.  Again,
> >> what are the specific examples here?  The one I can think of off the t=
op
> >> of my head is I2C, where it's needed in certain error recovery
> >> scenarios.
> >
> > right, I still have a theory that it's not needed in that case either,
> > though I haven't had time to try that out.
>=20
> Great, I hope it's not needed.  I've asked several times in past as this
> driver was converted to runtime PM, but was told it was required for
> various reasons (which I can't remember anymore.)

:-) just like I2C's revision register was broken and had no useful data
or MUSB mode1 couldn't be made to work... right. Looking at the
functional spec, there's no mention that we need to driver reset signal
anywhere, we _do_ need to reinitialize the transfer-related registers
(I2C_CON, I2C_CNT, I2C_SA), other than that, I can't think of a need for
driving the reset signal.

The bus specification isn't that stupid right ? Arbitration Lost and
NACK are both expected bus conditions. My only concern is write
underflow and read overflow, but I haven't been able to force that to
happen yet. Even in those cases, I'd be very surprised if we really
needed to driver the reset signal.

> >> Here, we need a way for the driver itself to initiate a full reset.
> >> Maybe a new runtime PM hook like ->runtime_reset() as Felipe has
> >> suggested (though I'm not yet sure runtime PM is the right place for
> >> this, since it's not strictly related to runtime PM).  Or, if these are
> >
> > right, I agree with you but I couldn't think of a better place. Maybe we
> > need a reset hook in struct device itself (as I suggested on another
> > mail) but I'm not sure Greg would take it, unless we have a damn good
> > reason.
>=20
> I'm starting to think a ->hardreset() method in struct dev_pm_ops is the
> place to put this. =20
>=20
> IMO, it needs to be in dev_pm_ops, so it can be selectively overridden
> by PM domains.  On OMAP, we'd just hook it up to omap_device_shutdown()
> for all omap_devices, and we'd be done.

do you mean omap_device_shutdown(); omap_device_enable(); ?

> >> one have the other use cases handy?
> >
> > dwc3 gets reset during probe() too, but that has an IP specific reset
> > which doesn't need SYSCONFIG register for that.
>=20
> OK, but that's still an init-time reset issue

yeah, and this is pretty mandatory otherwise dwc3 and its PHYs (USB3
pair plus USB2) won't synchronize and we'll have all sorts of issues :-)

> Do you know of any other runtime reset cases?  If I2C is the only one,
> then maybe seeing if it can be removed is the right first step.  If that
> works, we don't need any of this.

I don't know of any other, but there might be a few... On the other
hand, I doubt there's any of them which is truly necessary, unless
there's a bug in the IP which we can solve by issuing a reset, other
than that, driving the reset signal shouldn't be necessary outside of
probe() (or something before probe()).

--=20
balbi

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRI9wkAAoJEIaOsuA1yqREOUcP/j+cDZg7vBAWj4GCsz9B6koe
1sJW+bQMbtoTZ5atL+MVKp9gptpLp8Ip/mCO6gXeh21PcWGAqtFP9ggQKyx6B/7k
7xs4WuUgrOeOBXicVAfbn4SRrjB7EQoyzZBama/Df7umu1I+In6s1CojZO3gXb/4
i+I88K8dmgxqDnMUCe6QnpI8bOnfzetyHJyy0OQd07fOB6n8z2IhDa9zPagpKtzC
i++I7tER/1iGGw7m8Meq8bTQy0yu5gz8S+XMhoDNDxLdG41x6XQ2XSDYT5mgehNL
jQxYUkvjxo5JB1sq0iURBuXLNy0riT9fWqMyHFDE7oGJh63uE6lVTAx9S3M81zCp
7pNUK1+s8464966MgIgqQCs8YSjQh8KjnwOgJ8AeFVwiJLIpc65nIvrrAIzbGjxy
1PUTnXlMuhCXWMAGXYu2mrqBLx21ASnDYWSowhZ/8aP/tIevAmEmQxruEiZeBnEK
HtTgF+D765jCTH1Wc2zGIk8Eqf/VLOBkoofI0t5ArF453MoqBMyv48h8evpLAt4A
rtOcFlQPrjfabzrkEYhZy0jWFi0AEJ6fw8Vn+n7O6y8Vj10mbtN0DpdC+u5XmNf7
RbSX9ewFMCqtnZiNdMTzaaXxBCqm+pY81y4S3BkshdE7bUMtWHhjKZOa4E7sePvP
dDIFR7G19G+3X+cgYcv0
=M/CQ
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
