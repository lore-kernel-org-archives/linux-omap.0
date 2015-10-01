From: Neil Brown <neil@brown.name>
Subject: Re: [PATCH 10/13] twl4030_charger: add software controlled linear charging mode.
Date: Thu, 01 Oct 2015 16:14:41 +1000
Message-ID: <87bncjjesu.fsf@notabene.neil.brown.name>
References: <20150730001113.4012.18086.stgit@noble> <20150730001124.4012.27784.stgit@noble> <20150915112825.GA10704@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150915112825.GA10704@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Pavel Machek <pavel@ucw.cz> writes:

> On Thu 2015-07-30 10:11:24, NeilBrown wrote:
>>=20
>> Add a 'continuous' option for usb charging which enables
>> the "linear" charging mode of the twl4030.
>>=20
>> Linear charging does a good job with not-so-reliable power sources.
>> Auto mode does not work well as it switches off when voltage drops
>> momentarily.  Care must be taken not to over-charge.
>
> Can you explain how the user can "care not to over-charge"?

The following text reads:

    It was used with a bike hub dynamo since a year or so. In that case
    there are automatically charging stops when the cyclist needs a break.

so: take a break from cycling occasionally.

>
>> @@ -750,6 +784,17 @@ static int twl4030_bci_get_property(struct power_su=
pply *psy,
>>  		is_charging =3D state & TWL4030_MSTATEC_USB;
>>  	else
>>  		is_charging =3D state & TWL4030_MSTATEC_AC;
>> +	if (!is_charging) {
>> +		u8 s;
>> +		twl4030_bci_read(TWL4030_BCIMDEN, &s);
>> +		if (psy->desc->type =3D=3D POWER_SUPPLY_TYPE_USB)
>> +			is_charging =3D s & 1;
>> +		else
>> +			is_charging =3D s & 2;
>> +		if (is_charging)
>> +			/* A little white lie */
>> +			state =3D TWL4030_MSTATEC_QUICK1;
>
> I'm not sure... can't this white lie turn into black smoke?
>
> Like.. normally, when battery is below something (like 3.5V) it must
> not be quick-charged (because something is very wrong with it). Are
> you just forcing the quick charge here?

No.  That value is only used for reporting a status via sysfs.
That 'lie' gets translated to "POWER_SUPPLY_STATUS_CHARGING" which is
not a lie.

Thanks,
NeilBrown


>
> 									Pavel
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWDM9RAAoJEDnsnt1WYoG5g7wP/28bIljTq0v9OLBMAxbE6E42
IBr3dZDbAs3zLQfYXkEhSEGnJL1S91leoKwvDW7NXXb5FPCx1LIxapxOuUkkIF5b
CVaKjO8boSa1ch4x9pA/h4Zaqe+7AskYmwgGzjkzslRN7HgTVMIt+lEm905+M19s
ykML/vmPQzSXnakSYqQIQg0WiaBX/Y82EYqGoX1D/eXtwPcOqlojuZZ+prH7OteI
SmX/IEWzIy8YAibbFGCCGkEdw2sGCVySVJrI89fslJ/Sf4qmzMYTYpHlXRFpTo3j
d9oWK+qnuep43Pg5odR7ocweRhNxSTnkxS5NbyGD1dzfCfye4HfgdEhNnzzf2AiK
Lr0lxufRq1lgaC8WOfVPcjAJn4KVOeLkuWoBfwFuIwSTGPa/UfrdEAZjqYvTJeNQ
aLFpAU+Q2S3hHJz1AootJiHsqGuPwbdZNkmxIypATURagQMHaH3p4R/7fN4hi9+r
43v/n+/nxnoxAUzIjxlUnxmlTIoXOlsIBwPKPW3SiSfpe+oFCP4Z3SAg0nzF+ZJv
kPWsMvW6B0nO9DX1od8vMx4C5PHdk6oi+O00l4R9UM9ss2Qslny2KpSUqel3pTHt
4u1Gza/N7yCxYDXWaguE9Ls7TY5uVoCzhfQLUh9F04D704y1L8esv6yzB50I3Tyg
+Y1GEAvrQO5i9BwZ4FIQ
=aASZ
-----END PGP SIGNATURE-----
--=-=-=--
