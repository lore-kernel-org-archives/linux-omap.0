From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Tue, 13 Jan 2015 10:28:08 -0600
Message-ID: <20150113162808.GF16533@saruman>
References: <20141222160626.GD12815@saruman>
 <CAEOkp44o-a1Onxwxp6rRZvN+vgWhALiNf=Z5FbRtyrOW2JWx=Q@mail.gmail.com>
 <20141227174628.GB17608@saruman>
 <CAEOkp447UBzCRfmCO1yy1_k4N40L_TsfbrCpoLXd=Wmav8JROg@mail.gmail.com>
 <20141229171232.GI29379@saruman>
 <CAEOkp466i87H2cRkG+GopsiqamV6Ym=Rm5Lbiqc2pk29X0Rt=w@mail.gmail.com>
 <20141230160215.GB415@saruman>
 <54AB7D3F.3030809@st.com>
 <20150112183459.GK6525@saruman>
 <54B4A394.5060005@st.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52972 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbbAMQ2x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2015 11:28:53 -0500
Content-Disposition: inline
In-Reply-To: <54B4A394.5060005@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Virdi <amit.virdi@st.com>
Cc: "balbi@ti.com" <balbi@ti.com>, Amit Virdi <amitvi128@gmail.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pratyush Anand Thakur <pratyush.anand@gmail.com>, Ajay KHANDELWAL <ajay.khandelwal@st.com>

--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 13, 2015 at 10:18:20AM +0530, Amit Virdi wrote:
> On 1/13/2015 12:04 AM, Felipe Balbi wrote:
> >Hi,
> >
> >On Tue, Jan 06, 2015 at 11:44:23AM +0530, Amit Virdi wrote:
> >>>>>>I can certainly provide the dwc3 specific kernel bootup logs, full
> >>>>>>regdump and any loglevel you want me to, if that helps
> >>>>>
> >>>>>Yeah, if you can provide those, then that'll help me verifying. Full
> >>>>>logs from boot to failure point with VERBOSE_DEBUG enabled (consider=
ing
> >>>>>you're not running on anything recent).
> >>>>>
> >>>>
> >>>>Okay. I'll provide full verbose logs, along with the register dump,
> >>>>when I'm back to the office next week, for the working and non-working
> >>>>case, but how - as attachment or as inline?
> >>>
> >>>Either way will do but I have a feeling mailing list attachment size
> >>>will bite you, so maybe it's best to make a tarball of both logs and
> >>>send that as attachment. Compressed text will be very small.
> >>>
> >>
> >>Attached are the dwc3 verbose logs and register dump without and with t=
he
> >>fixes in this patchset.
> >
> >Sorry for the long delay, it has been a bit hectic.
> >
>=20
> It's okay!
>=20
> >I can see from your logs that we end up with a Transfer Not Ready
> >(Transfer Active) event and endpoint has BUSY flag set. I also see that
> >you're queueing 31 requests and all of them will use 2 TRBs, so we
> >clearly go over our TRB table.
> >
> >This fix is, indeed, necessary but we need to improve commit log a bit
> >so it's extremely clear what the error is. Later, we can improve how we
> >handle requests in this driver, but that is outside of the scope of your
> >patchset.
> >
> >Please improve commit log and resend your series so it can be applied.
> >
>=20
> Alright! I'll improve the commit messages and, also, cc stable list while
> resending the patches. As I see, you have already picked patches [3/4] and
> [4/4]. So, I'll resend only [1/4] and [2/4]
>=20
> >cheers
> >
>=20
> Thank you for your patience and kind understanding.

Alright, I just applied your patches to testing/fixes. I'll start
testing today and should be able to send a pull request to Greg by the
end of the week, hopefully.

cheers

--=20
balbi

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtUeYAAoJEIaOsuA1yqREbVYP/RceT5Dx5HwM1HdtWJV9G9N2
cESzvKSpfjlTlx2bYaQNsIBcNeavLl2/6bJ6DkKk8eDeLDdBL1t2PuE/6Qgj7vr5
GIGsnlXuuzitxClnYO6XrpyHu+l7L95RjLndFSgPhTKluidLHM2yq7VqsPVvX8OQ
DL8JUNtf0h0kJTc1VhdScucviSPQJjfwLetivroPq4s3WePSmgAlteO6V24Jj5BK
TaX3zTQSu0ilMYS9nPfmY716yO6ersk2/549A4FjF/WCy8QiEnYd4O5dw5af5DH5
M8w7YQT+R2CGAeLLVr+/zuWjN2lgYHfeDb5OTNS+2EjS5+qM3aBR05feVGDlrOxO
3yL9lBtj7zj9m8h8laOmPMt4GO7OzEzb4lnQFC0hjrCW8eTHOHeWc/ac9Mfo/UKE
vwR3rNV22KUUZfLo9BjLSwtRytv8DKpvyt2GlhsmStfJ8S1KuZmAnZLtPdtNMlwn
V6QUfBj7TFbpr4Zcse+3neFLjpH/K9C/Jqx8LnYNZR5uw6JiDJe/2rAtH4CQeLmu
yfX58t3pRWKnqHJhOgeJtH6U9X+uQj134Z1X/fUR0ypCy5oxyBkzF0GjgNiKbnhm
Vy60Y4PaRKPISumieJocu/9TMlHGWGPTg9teiJLJAPA37Ly16ZGCTa88rtBj9cCI
4ixQcqbKzO3+R8Oxr6Q9
=ePNL
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
