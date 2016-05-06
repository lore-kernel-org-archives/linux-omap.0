From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/10] usb: musb: Fix idling after host mode by increasing autosuspend delay
Date: Fri, 06 May 2016 09:45:52 +0300
Message-ID: <87k2j7it0f.fsf@intel.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com> <1461864800-29979-3-git-send-email-tony@atomide.com> <20160505150159.GA25950@uda0271908> <20160505170439.GX5995@atomide.com> <20160505174742.GF22575@uda0271908>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160505174742.GF22575@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
>> Does the current 200 ms autosuspend timeout relate to anything real
>> other than what I found out with my measurements?
>
> Not sure, I didn't checkk where the 200ms comes from.

It was an arbitrary number from when runtime PM was first added by
Hema. I don't think it has any esoteric meaning ;-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXLD2gAAoJEIaOsuA1yqREA6kP/1brMIfKdimusoWykF1Hpt7N
1cnjUO6kDpmT7I/xjrLVFfl6+sajsK/Df/DPICDv4LNGX6uDYaKKYLWKtwHlRWv/
E8o6G9ideJ5x2RTQRrhdeY/G+S6Rx3HMXlFLMixosMnm69bVA5c8PzgHe1e21/VS
0BVVpOylceWmoLC3iCQMOi3ooHHhnDws8b0KIXKARr9evSbKT2IdP2sXR+kb1S6o
G+d/k+U89I3n2dQQMlFBm/vnrMDv3csiD8vpqeB2h/qR+BJDHXaz4+ztJOBImmdT
tnXCOMS9qqM6v4YjOJRTwyhZjmVSdQIiFPA/hN03VJlbm+AbqcrtVuP2o4cI4rG1
a/OqruE+uvDiyQlvtGW7KPOjcQf8ZgQm6s3eTB+E4x0NTpYMT7pI1MIVVwuQjtlb
ngRN2d59yQQxmzn2FubnKSy7D9VMlI92zOXSNQH7yX0r+1xeRzA9qxhWrI4msj26
3Vo5+A3iOaPDNjnaVXG9RKCVLGQYNe0eGV0XzLuOkRLxjBUP99xp6+pDXINk9tLi
utiCs6cofe6LGcvKoHYpUMv2mzRuYcsbanwMwVcmFu/MiclxMdEBEyG3Gn0g8Lvl
erWNU+a4ib9cQbOiHiCkd0GHJgA7gPRTU/KGcQ9cO1MjIbWHG75xqSMTrhW5YFZ3
LKwYPdWGqF2zgjtXTI+/
=W0+y
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
