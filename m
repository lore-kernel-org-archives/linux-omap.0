From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/2] PWM: ECAP: PWM driver support for ECAP APWM.
Date: Tue, 24 Jul 2012 10:48:44 +0200
Message-ID: <20120724084844.GA25395@avionic-0098.mockup.avionic-design.de>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-2-git-send-email-avinashphilip@ti.com>
 <20120723065235.GA23797@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971530@DBDE01.ent.ti.com>
 <20120723092204.GA8607@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971887@DBDE01.ent.ti.com>
 <20120723133704.GB21254@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9727CB@DBDE01.ent.ti.com>
 <20120724080724.GA29810@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E972876@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53767 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab2GXIsr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 04:48:47 -0400
Content-Disposition: inline
In-Reply-To: <518397C60809E147AF5323E0420B992E3E972876@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2012 at 08:36:08AM +0000, Philip, Avinash wrote:
> On Tue, Jul 24, 2012 at 13:37:24, Thierry Reding wrote:
> > On Tue, Jul 24, 2012 at 07:52:06AM +0000, Philip, Avinash wrote:
> > > On Mon, Jul 23, 2012 at 19:07:04, Thierry Reding wrote:
> > > > On Mon, Jul 23, 2012 at 12:44:38PM +0000, Philip, Avinash wrote:
> > > > > On Mon, Jul 23, 2012 at 14:52:04, Thierry Reding wrote:
> > > > > > On Mon, Jul 23, 2012 at 09:10:09AM +0000, Philip, Avinash wrote:
> > > > > > > On Mon, Jul 23, 2012 at 12:22:35, Thierry Reding wrote:
> > > > > > > > On Fri, Jul 13, 2012 at 03:05:01PM +0530, Philip, Avinash w=
rote:
> > > > > > > > > +	/*
> > > > > > > > > +	 * Enable 'Free run Time stamp counter mode' to start c=
ounter
> > > > > > > > > +	 * and  'APWM mode' to enable APWM output
> > > > > > > > > +	 */
> > > > > > > > > +	reg_val =3D readw(pc->mmio_base + ECCTL2);
> > > > > > > > > +	reg_val |=3D ECCTL2_TSCTR_FREERUN | ECCTL2_APWM_MODE;
> > > > > > > >=20
> > > > > > > > You already set the APWM_MODE bit in .config(), why is it n=
eeded here
> > > > > > > > again? Seeing that .disable() clears the bit as well, perha=
ps leaving it
> > > > > > > > clear in .config() is the better option.
> > > > > > >=20
> > > > > > > Clearing APWM mode in .disable() ensures PWM low output (i.e.=
, PWM pin =3D low=20
> > > > > > > in idle state).
> > > > > > >=20
> > > > > > > The Period & Compare registers are updated from Shadow regist=
ers (CAP1 & CAP2)
> > > > > > > During PWM configuration. To enable loading from Shadow regis=
ters, APWM mode=20
> > > > > > > should be set.
> > > > > > > The same is done in .config().
> > > > > >=20
> > > > > > My point was that if you do it in .enable(), then why do you st=
ill set
> > > > > > it in .config()? Since the sequence is typically .config() foll=
owed by
> > > > > > .enable(), setting the bit in both seems redundant. It should b=
e enough
> > > > > > to load the registers during .enable(), right?
> > > > >=20
> > > > > Consider scenarios where .enable() can be called without calling =
=2Econfig().
> > > > > Example I just need to stop the pwm signal momentarily and re-ena=
ble.
> > > > > In this case, .config() need not be called. So, APWM mode bit nee=
ds to be=20
> > > > > set in .enable()
> > > > >=20
> > > > > Now, considering .config() followed by .enable().
> > > > > Currently in PWM driver, the CAP1 & CAP2 registers is copied to s=
hadow=20
> > > > > Registers (CAP3 & CAP4) by hardwaare in .config(). This requires =
APWM
> > > > > mode bit to be set.=20
> > > > >=20
> > > > > The same can be done in .enable() also. However, we again need to=
 pass=20
> > > > > the pwm parameters (period & duty cycle values) to the .enable().=
=20
> > > > > We don't want to duplicate this parameter passing.=20
> > > > > To avoid this we enable the APWM mode bit in both .config() & .en=
able().
> > > >=20
> > > > That's weird. I assumed that the values written to the shadow regis=
ters
> > > > would automatically be copied to the active registers on each new P=
WM
> > > > period.
> > >=20
> > > This is correct in case if PWM is running.
> > >=20
> > > > If I understand correctly what you're saying, however, the eCAP
> > > > requires the APWM bit to be set in order to write the shadow regist=
ers
> > > > at all.
> > >=20
> > > In APWM mode, writing to CAP1/CAP2 (active registers) will also write=
 the
> > > same value to the corresponding CAP3/CAP4 (shadow registers). This em=
ulates
> > > immediate mode.=20
> > >=20
> > > Writing directly to the shadow registers CAP3/CAP4 will invoke the
> > > shadow mode.
> > >=20
> > > If PWM is not running, cycle & duty values written to active register=
s, not
> > > to shadow registers. To copy these value to shadow registers APWM mod=
e to be
> > > set. This way reloading from shadow registers can be ensured on next =
PWM
> > > period/cycle.
> >=20
> > I think this is the part I don't understand. If you wrote cycle and duty
> > values to the active registers already, then the shadow registers should
> > be ignored by the hardware. There should be no need to reload the active
> > registers.
>=20
> ECAP PWM hardware always loads active registers from shadow registers at
> counter =3D period value (starting of next period). So on every next cycle
> active registers being updated from shadow registers. So shadow registers
> acting as a backup.

Okay, in that case I don't see any other option.

Thierry

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQDmFsAAoJEN0jrNd/PrOhXSgP/1wITTATK26RrdAzEPVIF4uC
OGxLam6FjhUnbMh69y7EmSY245FHhP+aPv3YfO4ZfNMJGmmJ+UsnQ2sf/B9rHINN
ECC4fZXZG6vNAHleNNW7V1KF6hLt9yctQupggpHV1n5TMuWaXX/n+dRdyKqW8Epe
YnfiriUQsgQf6aauKrO+qldeyEAUA24OfwSRMpUJ3PDlc3F9R+4bRrJgWj2zLMeA
TKuVDaSL0Kfd8YY2Uqt+KcaJzJbyXX4aAMWnUokKxV9zWFGuIM2pppRPo9i59ooJ
neIt7f7gioSNnh1oWW4eg39advX3G9f6C7w0r4YcxgytyHXNAxg+2SxQrK81e0CH
MmWfvhKJf/Duc6bH+fKjGlPK3DW+VABlP59VvUNHoZdRlGKztPW/TnqfTqy4Z19V
p+BIWZG4yu3ib5oPHgLqvElyABK8wyZOoMl/r33KTBoUcq+9NcBCIQ8Ce5SOhKyU
cjlI09UmaIXak1YvZYJjgEJDJwmxfaxtGhnM/onECasYw2xtTh6hDf1jdxLIHleQ
tPJVcDJE6fuPR4J2YgEKSQioLeDFay9xD4rQEFmsO21h2PJoSr8MCkIl9Id3X1QD
YPQbV301QzGPXFRhm+WIPlhYsmZzt4JQEzwt5UWITGH+SuAmq3Dk1HFcxwMwm7Xt
32gVz4ZVm5a5Rd9Sv1sq
=oUxy
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
