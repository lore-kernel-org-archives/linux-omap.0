From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Tue, 30 Dec 2014 10:02:15 -0600
Message-ID: <20141230160215.GB415@saruman>
References: <cover.1418972323.git.amit.virdi@st.com>
 <995bc6a5f9abd9a41f7229aafd1c2978b526783b.1418972323.git.amit.virdi@st.com>
 <20141222160626.GD12815@saruman>
 <CAEOkp44o-a1Onxwxp6rRZvN+vgWhALiNf=Z5FbRtyrOW2JWx=Q@mail.gmail.com>
 <20141227174628.GB17608@saruman>
 <CAEOkp447UBzCRfmCO1yy1_k4N40L_TsfbrCpoLXd=Wmav8JROg@mail.gmail.com>
 <20141229171232.GI29379@saruman>
 <CAEOkp466i87H2cRkG+GopsiqamV6Ym=Rm5Lbiqc2pk29X0Rt=w@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEOkp466i87H2cRkG+GopsiqamV6Ym=Rm5Lbiqc2pk29X0Rt=w@mail.gmail.com>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amit Virdi <amitvi128-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pratyush Anand Thakur <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ajay.khandelwal-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2014 at 08:11:13PM +0530, Amit Virdi wrote:
> >> The only reason why I have not been able to test these fixes on the
> >> latest is because the customized webcam gadget is not ported on the
> >> latest kernel. There have been a lot of changes in the video framework
> >> lately and that is not my area of expertise. So porting the customized
> >> webcam gadget to latest kernel and testing these fixes is not feasible
> >> for me.
> >
> > right, so while I can see that both patches are very minimal and likely
> > to be correct, I have no way of guaranteeing that. The only thing I can
> > do, is run the tests which I already run (none of which exercise the
> > cases you found though, other I'd have found them already) to make sure
> > your patches don't break what's already working.
> >
>=20
> Okay
>=20
> >> Having said all this, the fact remains that these are bugs in the dwc3
> >> driver from kernel v3.9 onwards. The log messages clearly depict this.
> >
> > no, it doesn't :-) your log snippet is so small that I cannot see how
> > the driver got to that point :-) The only thing I can see is that you
> > started two requests, one for 960000 bytes and another one for 2 bytes,
> > but I don't know how many TRBs we had available, nor do I see a Start
> > Transfer command, so I can't validate Start Transfer command parameters
> > were correct or not.
> >
> >> These bugs are obviously present till date.
> >
> > Right, the code is the same :-)
> >
> >> I ask you to give a more deeper thought on the whole situation and not
> >> undermine the importance of code review.
> >
> > heh
> >
> >>  - [Patch 2/4] fixes a bug that could have been found in the code revi=
ew.
> >>  - [Patch 1/4] fixes a bug which was very very subtle but a deeper
> >> code review can certainly boost the confidence about the change made.
> >> list_is_last won't work when SG is used because, for the last request
> >> in the request_list, the TRB for the first sg entry modifies the
> >> list's next and prev pointers while moving the URB to req_queued.
> >>
> >> I can certainly provide the dwc3 specific kernel bootup logs, full
> >> regdump and any loglevel you want me to, if that helps
> >
> > Yeah, if you can provide those, then that'll help me verifying. Full
> > logs from boot to failure point with VERBOSE_DEBUG enabled (considering
> > you're not running on anything recent).
> >
>=20
> Okay. I'll provide full verbose logs, along with the register dump,
> when I'm back to the office next week, for the working and non-working
> case, but how - as attachment or as inline?

Either way will do but I have a feeling mailing list attachment size
will bite you, so maybe it's best to make a tarball of both logs and
send that as attachment. Compressed text will be very small.

--=20
balbi

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUosyHAAoJEIaOsuA1yqREAVcP/1RnYYcO1J3+nWfzFq3YfoGb
M0tuY3Shj+gJz8Sf1DnIxRIkod0ntnCrUKxHPwPooYQqnuhUomjF2thaSiLOYQfc
hJeTuyxP2OX7waTw9JY7I2Lvv91d1tY6c+IqnYQ2TKYvo/YL8UmaZYyr1nLg8Tdv
aF9Gm5zyUTTcTESy8CD2z1GqDgOHx9VvoAKqsvmGoLJKoPD45PL/rvpMUyoE/9vY
FjVo6r1EtBYIwHa4cv859CwHrH/o4xLwiTSl0yW06ZESXi7k+aOgW77rdrLVDcAx
icxWkvhzBZNz5XNVVtkOcvpnXyBY1+9o4RLRdFEFEm3UCEAE1dLmZPZjbVBincG6
akehBQ+Gawmh6U14SZwEXASLhFPF3tcmXF0ZcBxLgBLrt76LBK2wdxP9ZLwxznAi
soKhK5SXZ58NkPTwfUUmCQLcTgdUaG43momIiocIUeKvcW+sy74GpO/izWQGhail
9Fvqk1Q/Yrxi7qwnnz0ON5xOdlByYfRAGbzyHogvqDU1IbRSWuVR/9SiBmeYC4Cw
EhQz6cGMb/wOtQOIO5OSdQjHg4VV/k1UkKGkLmUQDb34CTAhaFMn4beKJ1FZVsVp
8Tbgfj1HIdn2gp971lef1ISLPBO73lLmm8Rz+x9q4Fz6mlSUxXmEWPOV4Hul7YLX
xn+idXpQTOHYJVR2eCIu
=BTNl
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
