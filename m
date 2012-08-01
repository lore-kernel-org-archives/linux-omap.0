From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 0/3] solving omapdrm/omapdss layering issues
Date: Wed, 01 Aug 2012 20:38:24 +0300
Message-ID: <1343842704.2645.94.camel@deskari>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
	 <1343742034.2633.56.camel@deskari>
	 <CAF6AEGuqi+E7i1cuZTCts1y46E3SDUzd8E3kuW52=jRC5EksaQ@mail.gmail.com>
	 <1343812870.2645.37.camel@deskari>
	 <CAF6AEGuoVaOwwXnS3MKcoeKrtA3=Oi108jqM3iObd3EqTmC9Bw@mail.gmail.com>
	 <50195D54.8020604@ti.com>
	 <CAF6AEGvjKCgPh=sTL922J48N9eqMGD_kNrYx_bU-zBF-bXv=Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-NL1yi4TMURR73Fb8K/+Q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45561 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754219Ab2HARi3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 13:38:29 -0400
Received: by lbol5 with SMTP id l5so509522lbo.20
        for <linux-omap@vger.kernel.org>; Wed, 01 Aug 2012 10:38:26 -0700 (PDT)
In-Reply-To: <CAF6AEGvjKCgPh=sTL922J48N9eqMGD_kNrYx_bU-zBF-bXv=Ww@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Archit Taneja <archit@ti.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>


--=-NL1yi4TMURR73Fb8K/+Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-01 at 11:53 -0500, Rob Clark wrote:

> Ok.. this would help.  I'll take a look.  I do request that
> interfaces/panels don't set any mgr/timing related registers.  I had
> to comment all this stuff out in my prototype.  Really we want to set
> the timings separately on the crtc (mgr) / encoder (interface) /
> connector (panel.. not sure if it is needed, though?).  KMS will take
> care of propagating the timings through the pipeline.

If we only had auto-update displays, and only the video timings were
shadow register, it'd work. Unfortunately we have other registers as
shadow registers also, like DISPC_CONTROL1, DISPC_CONFIG1 and
DISPC_DIVISOR1.

But we should think if this could be somehow be changed, so that all the
shadow register info would come from one place. I do find it a bit
unlikely with a quick thought, though.

Well, hmm. Perhaps... Omapdrm (or omapfb etc) doesn't really need to
know about the values of those registers, it just needs to control the
GO bit. So perhaps if we had some method to inform omapdrm that these
things have changed, and omapdrm would then set the GO bit as soon as
possible.

But there are some tricky stuff, like the divisors... Well, we need to
think about this.

 Tomi


--=-NL1yi4TMURR73Fb8K/+Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQGWmQAAoJEPo9qoy8lh71iwsP/0xHGTVWbkzc1mWL4qZ/aPHp
djTbGnPntg3LnQuq1pBa91/5HaLeTpNHdvVae9/d09Ubeuhw4fmFApwkd6EsptCo
dxYB7Bs2Z/pekfAPeH07KOsQva3Rv0HG3vRFiR9SGvy63hvaNpLayEkmbKSHC6fQ
UMjYcyNc5N/P5ZG9Pcvbr5ej5WTbaRsLh2qioddqbqN4MwpXDo0RiU2LIeCOD6VQ
su8yHcRhPki1LgXOBmb9tGiO/W0v3jZ5YTk8zhWgTzE7yr17jiSm0uwrahhLEEd0
sdtRtOheSAn3zmsgsLBikf/C/ond/GhvZ+i9Ky3Stt5SojtOm7ETU54R3Pj9zXwO
NsPjpyAHKb0vodMt1UrXmmCbx0Bd4S4wgRUJ1KAbA1aPo+lOVWMBuzRDrisWKixl
+XTRuFmK2T0V88fqwbzzwqdWtc0HVwNTy9Cv4PZeXFPsLG3FxJB9HeFkhAAIoYT3
kVzo8FsLSs/LlusReClnhsibxI1NISNgp2b4Rjcv2/+m7AEAqvtdHiU5kZpD8g9a
TBVygyGSNxye8WEuWsEDcoem7By3f6sp0USqWJ9o+sp4Z5N6yVLOUw2LDHcRxVfx
XsHVBPmNpwh7CJ1MvkVYtGtWJJDqokfJ2P3L0gJTDPk9gh3WkklO7ctGGcUBC/X5
j/HUaoHoJ8T8cZJMfJLS
=HdkE
-----END PGP SIGNATURE-----

--=-NL1yi4TMURR73Fb8K/+Q--

