From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 14/15] twl4030_charger: Increase current carefully while
 watching voltage.
Date: Thu, 5 Mar 2015 17:51:48 +1100
Message-ID: <20150305175148.66453a33@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043353.4243.32335.stgit@notabene.brown>
	<20150302212945.GT13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/IK5bcqWrbZpInN5qoiQccgD"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150302212945.GT13270@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/IK5bcqWrbZpInN5qoiQccgD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:29:45 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> On Tue 2015-02-24 15:33:53, NeilBrown wrote:
> > The USB Battery Charging spec (BC1.2) suggests a dedicated
> > charging port can deliver from 0.5 to 5.0A at between 4.75 and 5.25
> > volts.
> >=20
> > To choose the "correct" current voltage setting requires a trial
> > and error approach: try to draw current and see if the voltage drops
> > too low.
> >=20
> > Even with a configure Standard Downstream Port, it may not be possible
> > to reliably pull 500mA - depending on cable quality and source
>=20
> "configured"?
>=20
> > quality I have reports of charging failure due to the voltage dropping
> > too low.
> >=20
> > To address both these concern, this patch introduce incremental
>=20
> concerns.
>=20
> > current setting.
> > The current pull from VBUS is increased in steps of 20mA every 100ms
> > until the target is reached or until the measure voltage drops below
> > 4.75V.  If the voltage does go too long, the target current is reduced
>=20
> "too low"?
>=20
> > by 20mA and kept there.
> >=20
> > This applies to currents selected automatically, or to values
> > set via sysfs.  So setting a large value will cause the maximum
> > available to be used - up to the limit of 1.7mA imposed by the
> > hardware.
>=20
> 1.7A?
>=20
>=20
> > @@ -249,8 +261,14 @@ static int twl4030_charger_update_current(struct t=
wl4030_bci *bci)
> >  		cur =3D bci->ac_cur;
> >  		bci->ac_is_active =3D 1;
> >  	} else {
> > -		cur =3D bci->usb_cur;
> > +		cur =3D bci->usb_cur_actual;
>=20
> usb_cur_actual is not a really great variable name...

I changed "usb_cur" to "usb_cur_target" and
"usb_cur_actual" to "usb_cur".

>=20
> >  		bci->ac_is_active =3D 0;
> > +		if (cur > bci->usb_cur) {
> > +			cur =3D bci->usb_cur;
> > +			bci->usb_cur_actual =3D cur;
> > +		}
> > +		if (cur < bci->usb_cur)
> > +			schedule_delayed_work(&bci->current_worker, USB_CUR_DELAY);
> >  	}
> > =20
> >  	/* First, check thresholds and see if cgain is needed */
> > @@ -379,6 +397,38 @@ static int twl4030_charger_update_current(struct t=
wl4030_bci *bci)
> >  	return 0;
> >  }
> > =20
> > +static void twl4030_current_worker(struct work_struct *data)
> > +{
> > +	int v;
> > +	int res;
> > +	struct twl4030_bci *bci =3D container_of(data, struct twl4030_bci,
> > +					       current_worker.work);
> > +
> > +	res =3D twl4030bci_read_adc_val(TWL4030_BCIVBUS);
> > +	if (res < 0)
> > +		v =3D 0;
> > +	else
> > +		/* BCIVBUS uses ADCIN8, 7/1023 V/step */
> > +		v =3D res * 6843;
> > +
> > +	printk("v=3D%d cur=3D%d target=3D%d\n", v, bci->usb_cur_actual,
> > +	       bci->usb_cur);
> > +
> > +	if (v < USB_MIN_VOLT) {
> > +		/* Back up and stop adjusting. */
> > +		bci->usb_cur_actual -=3D USB_CUR_STEP;
> > +		bci->usb_cur =3D bci->usb_cur_actual;
> > +	} else if (bci->usb_cur_actual >=3D bci->usb_cur ||
> > +		   bci->usb_cur_actual + USB_CUR_STEP > USB_MAX_CURRENT) {
> > +		/* Reach target and volts are OK - stop */
>=20
> Reached ... and the voltage is OK - stop.
>=20
>=20

Thanks for all your proof-reading :-)

NeilBrown

--Sig_/IK5bcqWrbZpInN5qoiQccgD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPf9BDnsnt1WYoG5AQJYtw//X87pOMZtGcxp4D7rMDYBVWhUauySjHgr
E6wbl0jBVa6I9aWhsYLjWMugYg9V7oooUfmwuSqWR6dB85M2Na8BNmtTWRLn8h6x
P+8mVS/FTj7GAG8Z5+wE48CBgADq6hwb+ZAzaE8nNng86/h+Awb5NBq0JjIzWiLo
E6oPjgvbKbVkAtjbI+GAzjQg6NPbSlfnmnup2Pmuqp93DoYHRlTRM6GajPp8GoWN
IK34fmKYsvcUPINShP2eIM6JXbXrg9FHMJiSdfjMVMpD1b0Dvl2akf53ahJj7D9k
T1S4gGrfMyjIO3wuduK0DbAn79rq1F02IFEjulj/BFc97Yaj76vh2QdaVdIzg8xn
CDHnuL8dxQ5Jh5pWt6iYTwfDGmkKuS6cMShhCUkhzo/TgfCVqAqZmnabOkOXfLem
tNIgvt/cGm0wSzcLnhlPZUh/+Ql/XI+Md0XzZYTR6lMAh8WawOeWgkL6SBNrV029
d0xryPkvae+KHyNKpGRxFZCz1bD95VdITxXhTDsMEndas6E9By6xy7boK4gF6418
Dwi4pGg9pTRWFCmBCE0yXMs7cEc+04vFPfuSj++7UxdW9MQ1WcQWuXZhPd+6fJDi
cweBKCWv4fJFW7ujiwrqcWb3kJ927QhzZKKuFRjco0wA68d45xY71Olxo+DGsqNH
kmZB6kUXoC8=
=o35n
-----END PGP SIGNATURE-----

--Sig_/IK5bcqWrbZpInN5qoiQccgD--
