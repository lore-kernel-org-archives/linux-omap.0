From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 1/4] ARM: OMAP4+: PM: Consolidate MPU subsystem PM
 code for re-use
Date: Fri, 5 Apr 2013 16:19:36 +0300
Message-ID: <20130405131935.GM11464@arwen.pp.htv.fi>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-2-git-send-email-santosh.shilimkar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3275562027651593574=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365166743-5940-2-git-send-email-santosh.shilimkar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3275562027651593574==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b1ERR0FXR0PvNIRE"
Content-Disposition: inline

--b1ERR0FXR0PvNIRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2013 at 06:29:00PM +0530, Santosh Shilimkar wrote:
> OMAP5 and future OMAP based SOCs has backward compatible MPUSS
> IP block with OMAP4. It's programming model is mostly similar.

s/It's/Its/
s/mostly //

(similar already expands to 'almost the same' :-)

> @@ -355,6 +389,12 @@ int __init omap4_mpuss_init(void)
> =20
>  	save_l2x0_context();
> =20
> +	if (cpu_is_omap44xx()) {
> +		omap_pm_ops.finish_suspend =3D omap4_finish_suspend;
> +		omap_pm_ops.resume =3D omap4_cpu_resume;
> +		omap_pm_ops.scu_prepare =3D scu_pwrst_prepare;
> +	}

why don't you just rename omap4_* into omap_* and add cpu-based checks
there in order to handle differences between omap4 and omap5?

If implementation will be almost the same for both, you might be able to
save on some more duplication, no ?

--=20
balbi

--b1ERR0FXR0PvNIRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXs9nAAoJEIaOsuA1yqREQ+sP/0Q0YmiX+6HQd0wNjD/fkmJR
7Bb1LICwTv024fxaU43ICyPhjYcybqZkqwFZz9lveW6KkSZ0nRrT8DK9JA/fqGgn
34R4HcuXHmIWUvw1wgsv1FBTFi6EDHBlCrsbuDBu/uxf8XSk4g6XraXb/O9RI/7h
g7Z8gKf1gD05/qhtlrfsSwbV8pgruEwzkbp26HGP1adlUTO0ajuIVqkkz/Z3v10y
nwJGxzUdmgyb+vV42NUWljUR3cnfbhwvl6kqQ0k+X3vRIU2F/KUfwcS9jVA5j33R
pedcds+mR+TYdtyf6jzYR8kzRPYtd6HrNgLsRLNVoWKHDwbKdMYP3NQQILkd4TSe
GG6q2fAAD+IDV0cg7n592ZjBnWtNHQGAId22L/auRjCjrny52ti+Ma+xKld7FfrV
XzBLUSeeAcgJDHzJaStP7wPS8nba99unfIiNYvohkdRUdOozPxnnhAgjYeWC8Ki0
FpAvXR/rTA2BjngiRcm//GcK6fuBg3lIDV/yEGMrvXUi8FURrnzoIv8ebLu1jnp2
WD6+sVbcUBy/bmrPSZZDA4I+7dcMcugEAvUBImV0aCoAguqW4dtWP7A0j4+KCpw7
8y9U1XWOczNE7ZAQGgALTHIoOAbSX1KO1FX9EQY4UYUxUs8MLFDVgUSdNjHnZrra
dkdZnTRClAkF5MFH7xGR
=1CXl
-----END PGP SIGNATURE-----

--b1ERR0FXR0PvNIRE--


--===============3275562027651593574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3275562027651593574==--
