From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/8] ARM: dts: AM4372: Reorder the rtc compatible string
Date: Wed, 5 Aug 2015 11:14:45 -0500
Message-ID: <20150805161445.GF12328@saruman.tx.rr.com>
References: <1438771792-12604-1-git-send-email-j-keerthy@ti.com>
 <1438771792-12604-2-git-send-email-j-keerthy@ti.com>
 <20150805153148.GB12328@saruman.tx.rr.com>
 <55C230E9.9010309@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C230E9.9010309-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2015 at 09:21:05PM +0530, Keerthy wrote:
> Felipe,
>=20
> On Wednesday 05 August 2015 09:01 PM, Felipe Balbi wrote:
> >On Wed, Aug 05, 2015 at 04:19:45PM +0530, Keerthy wrote:
> >>Compared to da830-rtc compatibility am3352-rtc is more compatible to
> >>the one in am437x. Hence adding the am3352-rtc compatible to cover the
> >>entire feature set.
> >>
> >>The ti,am4372-rtc has no Documentation and not used even in the driver
> >>hence removing it.
> >
> >why don't you do the inverse ? Document am4372-rtc and make driver use
> >it ?
>=20
> am3352-rtc suffices for am4372 too. No need to add additional one for
> am4372.

Until we end up needing it, right ? :-)

Besides, it's already used in a DTS. What happens if someone branched
=66rom that DTS and ships that in a product. RTC will just stop working
for them. Sure, it wasn't documented, but that's a problem of commit
73456012734b80442b33916406cfd13bf1b73acb (ARM: dts: AM4372: add few
nodes) which, essentially, added that compatible flag without
documenting it.

BTW, this compatible has been in tree since August 2013, IMO it's unfar
to drop it just like that. Documenting it would be a better approach.

--=20
balbi

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwjZ1AAoJEIaOsuA1yqRE778P/2BiP4KKkyL27rHlWdXHCHSt
Mp8ZnyOEV4+NTHNCn0pPhTaU9e+d6rBlGnVRx4cIT7iB+AA95A3wVODj/3Q3hFNM
pE1XCvnvSInOSa5yQnym5/+KbwTXhFt16fiYF9pKkZi0gyHnjvGerK4ZShco+xh4
5LPmb5hnwmJTqtx3u2RvPcWIUbX8YTRfa9zDOGYike98mRwW5AtRotgAu/ZYMn/+
v8CpP6ALGcJ7H/zDr0KfaLT2o54uJp7GWVNFaVYxjOJ+1gOvQ0oMeEdITl/OAE54
IB5hCaqqYxjFlKJahrC+LLrIMkyE5oGh1JV/wTRFaw8LdGzDVZ2myNc/UPjBQOri
RJbdEcLMdSHBBb7bpaKVBxlAxLKPD1ErFR4smSV+LwYEE7OwFbypZfEgOabfNgTC
c3blsUwHpQHf2okunjJUSAhTH8b47V2BBHhZ7MIbYYNxjVC1yJ9Pg00iN6pSUltA
LjhO5QHOZm7PmQLvah9kj8GOtUaDXhGqeFe//ginpK5h+Pvwq/ikHBxJee5zs9ho
TRKJERnODLAkO2WYlHGAROzyPyBeWu4tW4fTEglLNl37DqPDenadoFtK8cM6tJ+2
rmJrR41vxE7s8FP4vRW/HkyRxi6zEhGKKpnynW+senVNaVm2dAmO3bZ8HdrxXY8U
1JDEZiSrFDN7q17AAYIe
=7w9Y
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
