From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 00/16] i2c: drop class based instantiaion for selected
 drivers
Date: Thu, 10 Jul 2014 15:13:07 +0200
Message-ID: <20140710131307.GI2728@katana>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
 <20140710143837.558c1d07@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l0l+eSofNeLXHSnY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140710143837.558c1d07-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--l0l+eSofNeLXHSnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > +	/* Warn that the adapter lost class based instantiation */
> > +	if (adapter->class == I2C_CLASS_DEPRECATED) {
> > +		dev_dbg(&adapter->dev,
> > +			"This adapter dropped support for I2C classes and "
> > +			"won't auto-detect %s devices anymore. If you need it, check "
> > +			"'Documentation/i2c/instantiating-devices' for alternatives.\n",
> >
> It's usually a bad idea to split kernel messages across source lines

Yes, "usually". Not for this message, though, it's specific. The lines
would have been quite long.

> You could at least do the split at the sentence boundary.

OK, this would have been a compromise.


--l0l+eSofNeLXHSnY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTvpFjAAoJEBQN5MwUoCm2kUQQAKG2LIG6MzewzMHuFwCTeoFS
idHvMdE1d5HF8BUL/GE/IepNikzy9bvTQu1IPBhnaGcQQMQ0wSU9U5K1EClj1zgv
3s+n9hHLH/d3plLDM5ZRmf00DEjDGkHxX63vFctuyaWw20bRXeD86bvYAvZrc58n
+hed8FyF6KKzDS61jfoWA70LEG39Xssj/QIPDt5+bn3pUPK9OiTX234U1n5M9SV6
cfi7apgrT+KH2SIUzYsB8n8FXNH/QfrPjdIPIT3c7OZDrNIDzCP6kG68L4MPCT7v
+nET25q1MxMhYkrd1HaXkUNA3RFe4ZV7TuL7zhZCBetHDOe5Pg1NbloNwZiSkw+2
mMlvNyJBrmeRXVv3Ahbhpczh/WCi0pcLDmmeZEgBykB9Rz3atFQg9iCt5TA38kmf
xzbAU3h7la9b3FsvgUcfQ2v27g7uO5jv1WEdU59GXceEqDHcIq05Oop3XLBdNLeR
c1FAsJaMtiIlhsUMrx/o0Ex01NQFRdTdjAKjAzRifaAR7kCtDL93hR+sbdMyvyLq
2CJ+p/0mwVFkQuajN0zvmL/Rrs4PqF6Rs84Hq2hrqMF1C2PDqE9gBhMRzPCGljOz
RYauUQq0ZVOrpw5DQziLNF4eIh979umxHcq7EtSEY6D+H0Tai2VprqY1j/bwFAJi
3GxX/ks54HgF7b9PO+Aw
=/pKZ
-----END PGP SIGNATURE-----

--l0l+eSofNeLXHSnY--
