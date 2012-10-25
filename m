From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/8] i2c: omap: fix error checking
Date: Thu, 25 Oct 2012 13:48:40 +0300
Message-ID: <20121025104839.GF21217@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-4-git-send-email-balbi@ti.com>
 <5087FE07.6090504@amarulasolutions.com>
 <20121025101010.GC21217@arwen.pp.htv.fi>
 <5089156E.7020701@amarulasolutions.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5089156E.7020701-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 12:33:18PM +0200, Michael Trimarchi wrote:
> >>> @@ -587,9 +587,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *=
adap,
> >>>  		goto err_i2c_init;
> >>>  	}
> >>> =20
> >>> -	/* We have an error */
> >>> -	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
> >>> -			    OMAP_I2C_STAT_XUDF)) {
> >>> +	if ((dev->cmd_err & OMAP_I2C_STAT_AL)
> >>> +			|| (dev->cmd_err & OMAP_I2C_STAT_ROVR)
> >>> +			|| (dev->cmd_err & OMAP_I2C_STAT_XUDF)) {
> >>
> >> Sorry, what is the difference? I didn't understand the optimisation
> >> and why now is more clear. Can you just add a comment?
> >=20
> > semantically they're not the same, right ? We want to check if each of
> > those bits are set, not if all of them are set together.
> >=20
> > my 2 cents.
>=20
> You are doing the same thing, but of course is better with just one

I never claimed the contrary. I said *semantically* they're not the
same.

> *if* as before . A general rule is: when you have logic expression you

We still have a single *if* and I'm sure compiler will optimize that
expression as much as it likes.

> can use undefined states to simplify the logic.=20

don't-care is not the same as undefined states.

--=20
balbi

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiRkHAAoJEIaOsuA1yqRE6XoQAJwCFeow6Qy50c91NJSPWN5x
puEM/G87jD7HL66KixpwcW4f+bVa3WO3C3oPlW6DQ6gtpj65RQBknKqaNvXIcxd9
STFlPpz55jq/4HFqIkSgTAjzh4nE+8UEYF6PDVlBJ1LPIWf7Cy6H4dzuAowsg/fd
qt7OaNglSANv0RseMzUObd1bxKzmHmS88DWantgzpaUQkQvvEe+spibmuiOUZr/b
FS0WJ9BSmPY+7CVeM8gd2hmVsaoSnhnhozifzuVuWZRwBSeCwPzr5Bldb0wYjNLx
CjWsWkm4rmbzJda7uJyqGMw8+j8Pi7bw5wlYrRxHZt6swu/wZorqVSxL9JCwML+5
ijuNQPsAuk22iChZD2M4/azYMQ0lrh1JrWM5eHb6IN3ZRxIP7GUn/YJvQ1iVak1G
BgoLrFoudM5tr9Md2Z03yFxPIee6wZ8plr8xrWnj0Kv8FPsUsEla4P/b6h6ULfeI
5pdqAgaZftuQO36PsSiwf+dyhNCgHdl09T1QezhOFjXfsD/kRj3rWYLSkDchkeEH
0UK+UiELBnnJ1cDkioJO+HMM9ll40QSsCsoFf9IWoJFeZHHUL2xjnxpZmBGJiAnf
9d6Apl//vQBxPww7Yc5MBJr1s2evZe/eO39jHjtDJ6IP9jUkOtW5Ny5FZwxne9vD
asls1tRW5MQ9VZQ4VHnX
=MamA
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
