From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Mon, 12 Jan 2015 12:34:59 -0600
Message-ID: <20150112183459.GK6525@saruman>
References: <cover.1418972323.git.amit.virdi@st.com>
 <995bc6a5f9abd9a41f7229aafd1c2978b526783b.1418972323.git.amit.virdi@st.com>
 <20141222160626.GD12815@saruman>
 <CAEOkp44o-a1Onxwxp6rRZvN+vgWhALiNf=Z5FbRtyrOW2JWx=Q@mail.gmail.com>
 <20141227174628.GB17608@saruman>
 <CAEOkp447UBzCRfmCO1yy1_k4N40L_TsfbrCpoLXd=Wmav8JROg@mail.gmail.com>
 <20141229171232.GI29379@saruman>
 <CAEOkp466i87H2cRkG+GopsiqamV6Ym=Rm5Lbiqc2pk29X0Rt=w@mail.gmail.com>
 <20141230160215.GB415@saruman>
 <54AB7D3F.3030809@st.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54AB7D3F.3030809-qxv4g6HH51o@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
Cc: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, Amit Virdi <amitvi128-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pratyush Anand Thakur <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ajay KHANDELWAL <ajay.khandelwal-qxv4g6HH51o@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--AYsPlKobQGgtCvjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 06, 2015 at 11:44:23AM +0530, Amit Virdi wrote:
> >>>>I can certainly provide the dwc3 specific kernel bootup logs, full
> >>>>regdump and any loglevel you want me to, if that helps
> >>>
> >>>Yeah, if you can provide those, then that'll help me verifying. Full
> >>>logs from boot to failure point with VERBOSE_DEBUG enabled (considering
> >>>you're not running on anything recent).
> >>>
> >>
> >>Okay. I'll provide full verbose logs, along with the register dump,
> >>when I'm back to the office next week, for the working and non-working
> >>case, but how - as attachment or as inline?
> >
> >Either way will do but I have a feeling mailing list attachment size
> >will bite you, so maybe it's best to make a tarball of both logs and
> >send that as attachment. Compressed text will be very small.
> >
>=20
> Attached are the dwc3 verbose logs and register dump without and with the
> fixes in this patchset.

Sorry for the long delay, it has been a bit hectic.

I can see from your logs that we end up with a Transfer Not Ready
(Transfer Active) event and endpoint has BUSY flag set. I also see that
you're queueing 31 requests and all of them will use 2 TRBs, so we
clearly go over our TRB table.

This fix is, indeed, necessary but we need to improve commit log a bit
so it's extremely clear what the error is. Later, we can improve how we
handle requests in this driver, but that is outside of the scope of your
patchset.

Please improve commit log and resend your series so it can be applied.

cheers

--=20
balbi

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtBPTAAoJEIaOsuA1yqREfHMP/Rj5XIBI+oEuT3vD63gitp4Q
W7oZgoNTXm6cqvjumIIPrPTADulFG2VWif2cBFUoC89WpDywRgvT2AmD6i3oELuG
mMHcBRk0hSDFUBQlsPh5/GJhzRM+PJisBePzfm38yDEZxK5wjKKRZS3Ve4zEFYdW
Vl8TsTRcRKjlSgia9xPj/60KRgC6P8e7sL6XdgIRWjarR9JOgaYxXoIOwjARtMIN
SRdlLne3s1peI97Z7HZvh3PKlClqAacwd+SL3z5M1yOkPTGlsaeZUACuPX0Fi/H+
n0ZzTE0CG3JESgwREnVEGa+7vqeh59bdUKe/OIacy8ZwyMQztkgQGVxTReUfhZyz
CJw25dsvJ2zFJeYWJzBT1xVhyrnM2xJiI/WjaI3iQ9UU1ytRzeh1gXJVd5U1xehG
TZRc6eb+MWS8+A0BPdtJasgm8jq9zy1di94eZOFFWMnzTdMq45avTW7kV7wBsMY2
PoWmetbMNs5DCOQCLqDv+bMnPWXoS9Sv0h1UW6NHj8E7mRrgAxfZU+iQpcWzKQJD
qTquaVsCbGSn/SwmtyhWUrfPKgD7HNe0viz17auFptvpnikZfZq8BK68cfCZi7/v
4MddSimk7nWH6c+W8MrZWrdjYWaAYSIvOepqOKkJpM/1+MgNlNt+4UM5NvJM2v+F
/7g8xsIcQNRqw8qTbLIJ
=iyT9
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
