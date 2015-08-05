From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/8] ARM: dts: AM4372: Reorder the rtc compatible string
Date: Wed, 5 Aug 2015 11:51:22 -0500
Message-ID: <20150805165122.GH12328@saruman.tx.rr.com>
References: <1438771792-12604-1-git-send-email-j-keerthy@ti.com>
 <1438771792-12604-2-git-send-email-j-keerthy@ti.com>
 <20150805153148.GB12328@saruman.tx.rr.com>
 <55C230E9.9010309@ti.com>
 <20150805161445.GF12328@saruman.tx.rr.com>
 <55C23740.2080102@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C23740.2080102-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2015 at 09:48:08PM +0530, Keerthy wrote:
>=20
>=20
> On Wednesday 05 August 2015 09:44 PM, Felipe Balbi wrote:
> >On Wed, Aug 05, 2015 at 09:21:05PM +0530, Keerthy wrote:
> >>Felipe,
> >>
> >>On Wednesday 05 August 2015 09:01 PM, Felipe Balbi wrote:
> >>>On Wed, Aug 05, 2015 at 04:19:45PM +0530, Keerthy wrote:
> >>>>Compared to da830-rtc compatibility am3352-rtc is more compatible to
> >>>>the one in am437x. Hence adding the am3352-rtc compatible to cover the
> >>>>entire feature set.
> >>>>
> >>>>The ti,am4372-rtc has no Documentation and not used even in the driver
> >>>>hence removing it.
> >>>
> >>>why don't you do the inverse ? Document am4372-rtc and make driver use
> >>>it ?
> >>
> >>am3352-rtc suffices for am4372 too. No need to add additional one for
> >>am4372.
> >
> >Until we end up needing it, right ? :-)
> >
> >Besides, it's already used in a DTS. What happens if someone branched
> >from that DTS and ships that in a product. RTC will just stop working
> >for them. Sure, it wasn't documented, but that's a problem of commit
> >73456012734b80442b33916406cfd13bf1b73acb (ARM: dts: AM4372: add few
> >nodes) which, essentially, added that compatible flag without
> >documenting it.
> >
> >BTW, this compatible has been in tree since August 2013, IMO it's unfar
> >to drop it just like that. Documenting it would be a better approach.
>=20
> Okay. Can you point me to a file which is already accessing it in dts?

Accessing what ? Also, once DTS reaches a major kernel release, it's
deemed stable and should be supported. Are we dropping that ?

--=20
balbi

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwj8KAAoJEIaOsuA1yqRE5FIP+weLVq3tCNu4L6sPDoe7yzyO
D0izq54WF5anU+3Zj1DgTrEWsY3IQd4UegIXfYMAISzIuVww2KXwRYn/i67xp2lm
FMII94eiCMKH8cdjOZ2SwUsmhYR9Cx8+vOUkrK6v2N37BjAdts82Q/nNSgyVmVIB
p5LFy2Gu6xw0lH9wUKE23UzgtVOrKF+ieq90l2eXlKdc2BsxuEN8VcHz2+n9v3PZ
fM7AoKYv/VF3O+SE6eXoSVHzOwZv+50mSXEXqy/vozWOEnwiwpFhuMeN6IEh9UHT
oj8JFGVJK+6I4YLOseZ5fHQl8nzDGt4YB6IWNIDpwybmsJIIADln2/6KRwBVaOdS
yUzvjKj9A7ZlX+4/fLmyBuSc/jgvMMnHq4LoJ8tC0fleOffGh+Zs3iB0rj9N+v8g
Gm95aeJxC+2/94NygtNlU+r7RI5j3FrRlM2HJKnm3BBNYjy7v4v6hYbOaYHw317k
bzgz/9GWhsJB45uow0nzcsOxH1nKqWKtAkjA/PalgIiaYg/fZUuCLau0zfQ1KUUw
B6Hue1Qk2moC6ZgMuQJXsC7I1MASDmerspEQqFC0cJLslQSxD0mu+ZBEc+rwnAS6
F4JgVpS4tIyDjc1FSiHTNugbGntEVzBLTDPZZLTj0e4l+I4S0Gooo9ey9sauwS/q
jt/nJ1cK4upBveARA64R
=jPWu
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
