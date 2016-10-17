From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v3 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 17 Oct 2016 15:57:47 +0200
Message-ID: <FD41BC96-41B9-48B1-AB57-05B2DCAB4E17@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com> <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com> <20160923224726.GA4639@rob-hp-laptop> <20160924003133.htaaiphjrm7vy52t@earth> <E8C59C6C-23D4-4417-8A9E-3E9AE5D2D100@goldelico.com> <20160930141603.mlo5v75oy72j64d5@earth> <29036A28-9997-4ED6-81FE-3ABC659EEEEB@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_C27A8AB6-3549-4267-BFA0-26B6FB31FF1B"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <29036A28-9997-4ED6-81FE-3ABC659EEEEB-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_C27A8AB6-3549-4267-BFA0-26B6FB31FF1B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Sebastian,
I did wait for the 4.9-rc1 merge window to be closed until I bring up =
this patch
set again.

> Am 30.09.2016 um 16:40 schrieb H. Nikolaus Schaller =
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:
>>=20
>> I do agree with Rob, that the ti,min/max-x/y should become common,
>> though. Also I would do s/minimum value/minimum raw value/g.
>=20
> Yes, that is a good idea!
>=20
> To me it seems as if "minimum-raw-value-x", "maximum-raw-value-y" =
could be good.
>=20
> Or is the string too long (then we can drop the "-value" or the =
"imum")? It
> might blow up the DTB and string constant for finding the property?
>=20
> If we come to some consensus on this, I can update the patch set.

Now when updating the patch set, I found that using ti,min/max-x/y was =
not really
a new invention. It is already upstream for a while for the ads7846/2046 =
driver!

This means: by introducing these properties to the tsc2007 as well we =
just extend the
already defined use of ti,min/max-x/y.

Simply changing that as well to use some minimum-raw-value-x etc. would =
break ads7846/2046
boards not in mainline or need ugly code to handle property alias names.

And since they are raw data and quite chip-specific, I think there is no =
urgent need
for harmonization of raw device data. While using the common bindings =
for output
scaling and fuzz, swap etc. is very important and helpful for board =
designers.

So I would prefer if we can keep it as is for the moment. And make =
property name
harmonization and evolution a separate task and discussion.

I will submit v4 in a couple of minutes. It contains some other small =
fixes as
suggested by the previous discussion.

BR and thanks,
Nikolaus


--Apple-Mail=_C27A8AB6-3549-4267-BFA0-26B6FB31FF1B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYBNjcAAoJEIl79TGLgAm6LdQP/3Rj7aocbqZQ2sAJeL2UJQpo
reT6eBsWslzmWFvYazF8NE7ZtMqFPpp7A23XbUn7gyy5mMOSKPue525GciddUNBI
YUAK8/Gkr69FlQJ6NQXt9Xc0wekHL4YzMR+1lD+UV40YB3cY347JW4laPP2feZOM
Y5BpPrmmSf39hZRtj+bZMdMb/uDwy35DQEHDVMmmKu/gOq+lne5Vp6xQ8GlBwLEF
51T8eGZfWyPI9xGYP8MBZBEdHEcobLguzCvoEdOyYqkbafu7hGqeCKwspAWMXAXu
1+9PsgTLRFUqlKZHZD0MR7wDIP2ml60xuZWuf/J/SlOdNO5c0CbTa7QvFmkSEtHL
EPu1OPZj20RrXMnW1TcYOmrRwIxZ+3dfWoLIh1ioTnjck8jA87poTPshC0Wn4Woy
fBoazzSI3fcftAqJRWB8YvGZPgmgGde9WNT0NVOa2FXhzsMnJrJGiuBmyTGUHH3Z
dZsFSKD/3VNiu7UKv5Az1euRnliln05ApDLblIB1Drqcg62JCWTlN+RvS8Mxblat
9wHsdNcgqN9LFINZuZO9jqczi7yRfM/5NeFnXUBiP2Qxjryj3dQ+3379EYC0PbzI
TI62eucZY8hh4xEvvKQlBhXz+ulNchBuI1/sWo1uYXe/Oh8oNjwYoDGALHErodV7
c67YXquFn+PKMsTm2lEt
=s6+4
-----END PGP SIGNATURE-----

--Apple-Mail=_C27A8AB6-3549-4267-BFA0-26B6FB31FF1B--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
