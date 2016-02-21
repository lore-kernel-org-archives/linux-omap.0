From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap3-n900: Allow gpio keys to be disabled
Date: Sun, 21 Feb 2016 20:18:18 +0100
Message-ID: <20160221191818.GB15242@earth>
References: <1452447990-22775-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160212215326.GD19432@atomide.com>
 <56C9F8AA.9080503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56C9F8AA.9080503-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ivo,

On Sun, Feb 21, 2016 at 07:49:30PM +0200, Ivaylo Dimitrov wrote:
> On 12.02.2016 23:53, Tony Lindgren wrote:
> >Looks like this no longer applies because of linux,can-disable
> >to wakeup-source changes. Can you please update against v4.5-rc
> >series and repost?
>=20
> Could you elaborate on that? As I don't really understand what needs to be
> updated and what are "wakeup-source changes".

Due to changes in the kernel source  (each gpio key in omap3-n900.dts
gained a "wakeup-source" property) the patch can no longer be applied
using "git am". Just rebase your patch to current 4.5-rc and resend it.

-- Sebastian

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWyg16AAoJENju1/PIO/qaqx8P/jni96O9wIEiEwm/NokY8fFs
GkVfxrISVWbArPT83PfYyOKndO9tMnby7HhOg8BXXx1haF61FA3Gf+LYvd2Uijw5
egk0+VtSu1LzxF629zMRjFQcj85YNs/GT9cbd48Lcn4YTQ7EvYPD7/ygI2ccBi6L
k0C+9NrjaRMnnkkDnO6+R8ZJLLSrAsZ6mPTL9+TDZodMR49F8KaN4Zg/fFqLktiA
PUPQy/6VCFfHWyQI7RvYF6DVa8usNpgXD/5troBpVPOzWGYSND+s6YUYWzF5tDjn
Y+zjSGfdy6F+jtYPxC9+D03W5IWtu0fHZC0RYXpnNtDbWPdr5auCo3XrXtEANw2T
Z/vou3HulCo1YboJmij/R4iOXcuJHaY9Ac7GSIwftnidOAMi1XXsMdbKkptlj0hL
gYkvmgdkRd/tMQL7bA3N2WdtG6bO/ircQPAb221yAWIwGcGaVUfj0Paq7lYiTVVM
UQxqMGgZYybPNOLbfF2+dbDNvra0gmPHVipStbz6APJi7rrXZyDlIVF6d9vf992s
a4mEh30nF5DPBSYbCHxTaGFjHKXMqV/2cuaaUyplQ9lI6byksQr0vjpwD907utyi
XjBqxiJ+oH3z4IeFvcaRLxVvQD2X3gh2A9L0Ygcn/JxaLyzbMVNi4RCX4Sxlf/Qd
dLRvH5/E9EwnavS5CpJS
=iSM8
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
