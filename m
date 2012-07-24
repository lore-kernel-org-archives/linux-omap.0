From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/2] PWM: ECAP: PWM driver support for ECAP APWM.
Date: Tue, 24 Jul 2012 10:07:24 +0200
Message-ID: <20120724080724.GA29810@avionic-0098.mockup.avionic-design.de>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-2-git-send-email-avinashphilip@ti.com>
 <20120723065235.GA23797@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971530@DBDE01.ent.ti.com>
 <20120723092204.GA8607@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971887@DBDE01.ent.ti.com>
 <20120723133704.GB21254@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9727CB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55840 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561Ab2GXIH2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 04:07:28 -0400
Content-Disposition: inline
In-Reply-To: <518397C60809E147AF5323E0420B992E3E9727CB@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2012 at 07:52:06AM +0000, Philip, Avinash wrote:
> On Mon, Jul 23, 2012 at 19:07:04, Thierry Reding wrote:
> > On Mon, Jul 23, 2012 at 12:44:38PM +0000, Philip, Avinash wrote:
> > > On Mon, Jul 23, 2012 at 14:52:04, Thierry Reding wrote:
> > > > On Mon, Jul 23, 2012 at 09:10:09AM +0000, Philip, Avinash wrote:
> > > > > On Mon, Jul 23, 2012 at 12:22:35, Thierry Reding wrote:
> > > > > > On Fri, Jul 13, 2012 at 03:05:01PM +0530, Philip, Avinash wrote:
> > > > > > > +	/*
> > > > > > > +	 * Enable 'Free run Time stamp counter mode' to start count=
er
> > > > > > > +	 * and  'APWM mode' to enable APWM output
> > > > > > > +	 */
> > > > > > > +	reg_val =3D readw(pc->mmio_base + ECCTL2);
> > > > > > > +	reg_val |=3D ECCTL2_TSCTR_FREERUN | ECCTL2_APWM_MODE;
> > > > > >=20
> > > > > > You already set the APWM_MODE bit in .config(), why is it neede=
d here
> > > > > > again? Seeing that .disable() clears the bit as well, perhaps l=
eaving it
> > > > > > clear in .config() is the better option.
> > > > >=20
> > > > > Clearing APWM mode in .disable() ensures PWM low output (i.e., PW=
M pin =3D low=20
> > > > > in idle state).
> > > > >=20
> > > > > The Period & Compare registers are updated from Shadow registers =
(CAP1 & CAP2)
> > > > > During PWM configuration. To enable loading from Shadow registers=
, APWM mode=20
> > > > > should be set.
> > > > > The same is done in .config().
> > > >=20
> > > > My point was that if you do it in .enable(), then why do you still =
set
> > > > it in .config()? Since the sequence is typically .config() followed=
 by
> > > > .enable(), setting the bit in both seems redundant. It should be en=
ough
> > > > to load the registers during .enable(), right?
> > >=20
> > > Consider scenarios where .enable() can be called without calling .con=
fig().
> > > Example I just need to stop the pwm signal momentarily and re-enable.
> > > In this case, .config() need not be called. So, APWM mode bit needs t=
o be=20
> > > set in .enable()
> > >=20
> > > Now, considering .config() followed by .enable().
> > > Currently in PWM driver, the CAP1 & CAP2 registers is copied to shado=
w=20
> > > Registers (CAP3 & CAP4) by hardwaare in .config(). This requires APWM
> > > mode bit to be set.=20
> > >=20
> > > The same can be done in .enable() also. However, we again need to pas=
s=20
> > > the pwm parameters (period & duty cycle values) to the .enable().=20
> > > We don't want to duplicate this parameter passing.=20
> > > To avoid this we enable the APWM mode bit in both .config() & .enable=
().
> >=20
> > That's weird. I assumed that the values written to the shadow registers
> > would automatically be copied to the active registers on each new PWM
> > period.
>=20
> This is correct in case if PWM is running.
>=20
> > If I understand correctly what you're saying, however, the eCAP
> > requires the APWM bit to be set in order to write the shadow registers
> > at all.
>=20
> In APWM mode, writing to CAP1/CAP2 (active registers) will also write the
> same value to the corresponding CAP3/CAP4 (shadow registers). This emulat=
es
> immediate mode.=20
>=20
> Writing directly to the shadow registers CAP3/CAP4 will invoke the
> shadow mode.
>=20
> If PWM is not running, cycle & duty values written to active registers, n=
ot
> to shadow registers. To copy these value to shadow registers APWM mode to=
 be
> set. This way reloading from shadow registers can be ensured on next PWM
> period/cycle.

I think this is the part I don't understand. If you wrote cycle and duty
values to the active registers already, then the shadow registers should
be ignored by the hardware. There should be no need to reload the active
registers.

> If PWM is running, cycle & duty values written to shadow registers. So th=
at
> it won't disturb current PWM period. On the next PWM period, new values w=
ill
> be reloaded from shadow registers to active registers.
>=20
> So APWM mode to be set to copy shadow registers from active registers
> (immediate mode).

I realize that I'm just talking from a general understanding of shadow
registers and maybe you're hardware doesn't work quite that way. If this
is really the only way that you can make the hardware work then I will
no longer object.

Thierry

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQDle7AAoJEN0jrNd/PrOhiTIP/3a/YozSvVNZGVBllauOl1Ua
gMQGMbBmGDl1GbvJlcoakUS9jcXVEBSNVL/qf4u2iahdOKouRlF3nNRzDBEUQBDY
ufllXOSQLD5+ciOdGMfCb8O/S2s4u6EOgEXShofnKuZgKydrJRSIv3WmitRB361y
/6eqe8W5QIpLkvU/YU4TI3gz/Y7838BMWDsKJb8cB+eJieCROdKaxuW8eYCwobMw
BRWbOs069nXhNzsLWkqlYCtCuwLKoqv0NkEB5x8Imlt5GsZ/KJf3Nt5aE6TsDPZW
EVhkILpkArL7WLtNU3m0qpLJvym/sQz18o4JArkPun6+W4sZzdQ7yPCXVu9biXX9
4CnJtYhWDxa1wlf0zEpcWu7gDcRuQU6FULDxTILD0MOOR1Eiqpt3iLv/mozXKshj
atX/Bpnle99Tv64NV1+NJWaMxqtURlAwfdsazWmW5RHLAmdL6IAuYvbBvDfDXfDZ
gOVKxTHgZudQ+Anc/wbOYEa5NNbXF4XjrHhM6xd7of5qX9fE8Ula8zd4PORMSRXr
NP/pYiHVWGNOCopCJpE+3LKE9d9zZuxm/hQLFx6UyQTg9YoMwtwmQMuADRHGYFam
dgxCqMLEWt3HGouhRZdKJwJpSq+QGFGkE5DpljqsqVocOQFt26wZR5f1m3UW3Z7i
qcO9k8gDZdm68Wvjfbr7
=MNSJ
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
