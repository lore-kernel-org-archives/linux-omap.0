From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 3/3] arm: dts: omap3-gta04: Add handling for tv output
Date: Tue, 13 Jan 2015 12:11:15 +0200
Message-ID: <54B4EF43.50300@ti.com>
References: <1417642402-20538-1-git-send-email-marek@goldelico.com> <1417642402-20538-4-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="FsKh27OBDuG4WVkpv3ap5Q76vqlvrDUU5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417642402-20538-4-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--FsKh27OBDuG4WVkpv3ap5Q76vqlvrDUU5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/12/14 23:33, Marek Belisko wrote:
> Add handling for gta04 tv out chain:
> venc -> opa362 -> svideo
>=20
> Use invert-polarity in venc node because opa362
> is doing polarity inversion also.
>=20
> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 49 ++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 49 insertions(+)

Looks fine to me.

Tony, do you want to pick this up? I can take the first two patches via
fbdev.

 Tomi



--FsKh27OBDuG4WVkpv3ap5Q76vqlvrDUU5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtO9DAAoJEPo9qoy8lh71qwgP/0WaNBxbpL5Z0jyxf2NkpKHJ
C5bKasUpileQUe4LxHe0VZzwiOrKDC4RcpdYRoo2c5+MrEmVRCuPEYWx64h2Yvvq
kLc+aJH+vmSBfej/CNgieRvElDaPy7ESzBxSIZT1znAkWYvzeyWclp1SX98cgJgg
GnB/bVSN3xHWuKfYDIp/+yyiwxSHLuKTsjPCQ/fEmovdXL35vZSePmeQEO6vzvol
AltR1EC/Nvgd2Yz/fiZtStwT8rKrsDV15QufnLQf+b5maIFzO4Erd564pbLIOu2c
xOoG3Gwc5lWlRqBiZxL7Q6wJEOGO+IBOnmw+btiJbemeWOuLmUl0Owp/npz6c4pr
wq5jJ0SHxe5XksFq9FKmqoBK03WFmv8syRtrBZgFlI8vidJGUw/4fpPMx70c5lmB
tLoe6prLlCTxebqamCTjwwtROWBkQg9CRljzR5yRjUPWQUoleMZkvdSjMJWedfGH
/Nm51fnpzWE59uRMd5hnrmlVG3t7dN6YDKvlrUFDIP8Gvv9Ep6s16I0VIbf4huo/
Yj7jyl47LMpewUCzhragJ2anvpTjJJFNcWdgLYxTT7mokgA5+YTsPge94HQ8Sfzk
urxnggTsg+3tEQ9qOn9HPPcfs0YsPIXJyjl3so091pgLHwyneOLAwCgQ5JOeskoc
97Z7hmnsaRcjHVnc0Pl8
=sNxd
-----END PGP SIGNATURE-----

--FsKh27OBDuG4WVkpv3ap5Q76vqlvrDUU5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
