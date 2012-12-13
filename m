From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] OMAP: add pwm driver using dmtimers.
Date: Thu, 13 Dec 2012 15:33:02 +1100
Message-ID: <20121213153302.05120a6d@notabene.brown>
References: <20121212192430.50cea126@notabene.brown>
	<50C8ABFC.3080309@ti.com>
	<20121213140635.4eda5858@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/eNCjlSWfRGV.mhdCuWnIfgG"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121213140635.4eda5858@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Jon Hunter <jon-hunter@ti.com>, Thierry Reding <thierry.reding@avionic-design.de>, Grant Erickson <marathon96@gmail.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/eNCjlSWfRGV.mhdCuWnIfgG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Dec 2012 14:06:35 +1100 NeilBrown <neilb@suse.de> wrote:

> > > +	omap_dm_timer_enable(omap->dm_timer);
> >=20
> > Do you need to call omap_dm_timer_enable here? _set_load and _set_match
> > will enable the timer. So this should not be necessary.
>=20
> True.  That is what you get for copying someone else's code and not
> understanding it fully.

However .... omap_dm_timer_write_counter *doesn't* enable the timer, and
explicitly checks that it is already runtime-enabled.

Does that mean I don't need to call omap_dm_timer_write_counter here?  Or
does it mean that I do need the enable/disable pair?

>=20
> >=20
> > > +	omap_dm_timer_set_load(omap->dm_timer, autoreload, load_value);
> > > +	omap_dm_timer_set_match(omap->dm_timer, enable, match_value);
> > > +
> > > +	dev_dbg(chip->dev,
> > > +			"load value: %#08x (%d), "
> > > +			"match value: %#08x (%d)\n",
> > > +			load_value, load_value,
> > > +			match_value, match_value);
> > > +
> > > +	omap_dm_timer_set_pwm(omap->dm_timer,
> > > +			      !omap->polarity,
> > > +			      toggle,
> > > +			      trigger);
> > > +
> > > +	/* Set the counter to generate an overflow event immediately. */
> > > +
> > > +	omap_dm_timer_write_counter(omap->dm_timer, DM_TIMER_LOAD_MIN);
> > > +
> > > +	/* Now that we're done configuring the dual-mode timer, disable it
> > > +	 * again. We'll enable and start it later, when requested.
> > > +	 */
> > > +
> > > +	omap_dm_timer_disable(omap->dm_timer);
> >=20
> > Similarly the disable should not be needed here either.
> >=20


Thanks,
NeilBrown

--Sig_/eNCjlSWfRGV.mhdCuWnIfgG
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUMlafjnsnt1WYoG5AQLaIQ/9GNceqI598Nu6jc6D85lX+c+3GFzd0T5J
pH84IwoE8n0x1x2Nhiw31fj+eBdLqRP6ny1c9J7SQK5dd3Wy0+RcM1P4WZcw9U82
b6rdNyiooc190mB09ITj6qTP0pmAGEiViQ1OAncHXPCWKMLOfwa7knLqeH7cOkTa
Zz/ljjAggavJh41PYg3iSXWytUlq4xhCv2GEMWa2fa0f1izUgDUdHbfaDqKcHF+D
YAAlLqYhUDU2xe7OuLKITULdbkIlkf6ox7hO5UKvJC2xPQNG5yH5J7+ncS4KR0NC
tFSQpqeRIPWc4vX7nhK8R4LT4zAo8L/exu2uio5z3TnYuBILsuT32OqQDtu1fv5E
sCMFGYckO0JoYR10J5f4vQ/zJlJJHGC+haSR0AfFqouKhzr+obLC6c9dxVsk60Kc
U2g0yG5yvVDm/BOe7cTcGElpFCVfhZewhg5XvKfGfwK3hXA5Kgd2IRTBGyxttWk+
H4iTA4XeSj5zA1QkB3smW4GB0O6edq4sFVtfr96dXR28/m7irdRGo2yLXv3dnMqJ
RZF0XdR5gcH5R9TZ8FA/wYYcEsTKB1qm3MGftHFZc73G2S8ln+9OkCcfEzmv4RRP
8XPgiLkpVYZpJfsJg+Tcv4NORiypuGPsC22LKcsHp4xXie4StX9MFl5NF8M2UAPx
CMe5rmdYvC8=
=yufF
-----END PGP SIGNATURE-----

--Sig_/eNCjlSWfRGV.mhdCuWnIfgG--
