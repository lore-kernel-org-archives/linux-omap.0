From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] twl4030_charger: add devicetree support.
Date: Thu, 24 Oct 2013 21:41:10 +1100
Message-ID: <20131024214110.2845670d@notabene.brown>
References: <20131024165005.78bc8740@notabene.brown>
	<1C8E8D31-1261-45ED-BBD0-161DFD627ACF@codeaurora.org>
	<20131024100652.6B31DC4039D@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/xSv6pjfUld.CsSUNQr5kAd_"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52629 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450Ab3JXKla (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Oct 2013 06:41:30 -0400
In-Reply-To: <20131024100652.6B31DC4039D@trevor.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Kumar Gala <galak@codeaurora.org>, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Belisko Marek <marek.belisko@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>

--Sig_/xSv6pjfUld.CsSUNQr5kAd_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2013 11:06:52 +0100 Grant Likely <grant.likely@linaro.org>
wrote:

> On Thu, 24 Oct 2013 04:44:03 -0500, Kumar Gala <galak@codeaurora.org> wro=
te:
> >=20
> > On Oct 24, 2013, at 12:50 AM, NeilBrown wrote:
> >=20
> > >=20
> > > [my first device-tree related patch.  Please let me know what I got w=
rong so
> > > I wont repeat the mistake in all the others I have queued]
> > >=20
> > > This allows the charger to be enabled with devicetree, and
> > > allows the parameters for charging the backup battery to be set.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/power/twl-charger.txt =
b/Documentation/devicetree/bindings/power/twl-charger.txt
> > > new file mode 100644
> > > index 0000000..8afaa9a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/twl-charger.txt
> > > @@ -0,0 +1,20 @@
> > > +TWL BCI (Battery Charger Interface)
> > > +
> > > +Required properties:
> > > +- compatible:
> > > +  - "ti,twl4030-bci"
> > > +- interrupts: two interrupt lines from the TWL SIH (secondary
> > > +  interrupt handler) - interrupts 9 and 2.
> > > +
> > > +Optional properties:
> > > +- bb-uvolt: microvolts for charging the backup battery.
> > > +- bb-uamp: microamps for charging the backup battery.
> >=20
> > prop should have vendor prefix.
> >=20
> > ti,bb-uvolt, ti,bb-uamp
>=20
> Agreed. Otherwise:

OK, I'll do that - thanks.

NeilBrown

>=20
> Acked-by: Grant Likely <grant.likely@linaro.org>
>=20
> >=20
> > - k
> >=20
> > > +
> > > +Examples:
> > > +
> > > +bci {
> > > +   compatible =3D "ti,twl4030-bci";
> > > +   interrupts =3D <9>, <2>;
> > > +   bb-uvolt =3D <3200000>;
> > > +   bb-uamp =3D <150>;
> > > +};
> >=20
> > --=20
> > Employee of Qualcomm Innovation Center, Inc.
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation
> >=20


--Sig_/xSv6pjfUld.CsSUNQr5kAd_
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUmj5Rjnsnt1WYoG5AQIGGQ/9ErGtUkYoVyAb2vJPmiEuQ9CVAVvaSPVg
stzE4oMAnfqVeUqf3f5TbUYd3gbc1P++FghnTc5+75J/wsvVx7nDl0u7ukmvFg7f
ptv6PQAGTCI4ZUusI0rDj9V5SQ62sBVFqQFi+MoRjGpViBS+YE+lgolMEYKl9TnM
+CQlzf0G40TkNkmriWwc+D08MNtXdM99p+NqroUmdwQ1RAsNHxQFBvfjkfRTwCbd
KvSkpNJ1yGG+j12QcsBxmDfYb26ra26cKpVSIdcrUhfQaqtx2CikW7Xrfj/HWkRE
lIHh4bqznnu3xmDO8Zli9KcPXeVBgvKRNSy4f03BQ7KBjokxvKgtg9hWStnxDQt7
gc8dy7u1P5MUXldpPDQDCHsUNBwXoLsaCIETq8GHxlhggbiJ6JLOp48D3mirDzqQ
0RnM/hOGoI8szJaqV/u7U/+5rohBOykaSe1yKn7LLb2VCa11Mmkl7dXxD085mKzS
iqHj9i3MViODZ5E6sBWWuJL3w2lvS6Vb+27DZ1yTxBgdutPIs0Um38a4oeuJG0or
Q40QRy2IB9yR2LDMGX976dsbYeG0xiHkcLOOO8VpGyoqVB+XARgZx7W7cK0+ymC/
Ug0c162DmPA83FmdryiwPwqMTQwnlRfXhYehuQcYj0mSPrMIa/bLCXkNom/HRsH4
GdNYmvsTUQA=
=6xmP
-----END PGP SIGNATURE-----

--Sig_/xSv6pjfUld.CsSUNQr5kAd_--
