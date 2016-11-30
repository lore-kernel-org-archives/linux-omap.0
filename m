From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/12] usb: phy: tahvo: Replace the deprecated extcon API
Date: Wed, 30 Nov 2016 12:42:41 +0200
Message-ID: <87shq9meou.fsf@linux.intel.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com> <1480485460-2663-12-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480485460-2663-12-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Peter.Chen-3arQi8VN3Tc@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, chanwoo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> writes:
> This patch replaces the deprecated extcon API as following:
> - extcon_set_cable_state_() -> extcon_set_state_sync()
>
> Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Acked-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlg+rSEACgkQzL64meEa
mQYu4w/+O+zzVwXdA9Dnr8vT8b4IqP9TCXF3bY+HfyrSQL4EQWpM7TQVjxmLm0U1
auWGuqYGH3uMo3NVOv6iVEV8//hipl1VF5aSnvJqqCuT2HCqJ9IWIDG4r/OsTB9l
tkNVOz2WFr+m+DujvYninh0nKroWhJjU3c4AO0dIjv/ItibEGCRCIGSQfEuWgxf0
NrCoOr7tRl8J1EjdToCv8VFAzvcccUpSgrTEFqGxw/H3JCycWUyl4HEYrSS24mYI
83oEu4fPAFO0ak8cIHJrcbzdIhI3a7LJvZACVkHueTU09FfQRlO8giDyUim+djKh
ibSJOnZY3yKMHEpZbD2xrp5C2PBHfy3cNWxHc8c+TwRdV4SiD/HTx4787sdI9T1B
RaoKIjLj8YKsxgry1xj/dh/u6ZHgBZbIzJDXv4q5XruB89UkENLAABCv1ApduOl9
q2kmwAjutMHJgfndLoAEaDPqyw5xBHBpe1JwFeWUuuJxr0KhDdehzjUIfAhcCd+8
s/B4yHOpzL+TL5qZCvwwwdziTfpCCAdVS3uMUqeOo+90N48AW/HguVzba3oLAeL5
9uWV7q+WJESB3gnAsZqJtW6pSyVwJucI+R7ZwbIdnvt3uL1Vfw29padVkf0rSSuM
mXw/bzVw+VpQ+ALq3t/1zoDCS1z1+84fCARmdxafPSfbfyaAL0Y=
=0Y/E
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
