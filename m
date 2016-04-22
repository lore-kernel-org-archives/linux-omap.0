From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap3: Fix ISP syscon register offset
Date: Fri, 22 Apr 2016 15:16:26 +0200
Message-ID: <20160422131626.GA7534@earth>
References: <1460787628-17316-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <5719A9E3.1000902@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5719A9E3.1000902-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Apr 22, 2016 at 07:34:43AM +0300, Ivaylo Dimitrov wrote:
> On 16.04.2016 09:20, Ivaylo Dimitrov wrote:
> >According to the TRM, SCM CONTROL_CSIRXFE register is on offset 0x6c
> >
> >Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >---
> >  arch/arm/boot/dts/omap34xx.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
> >index 5cdba1f..e446562 100644
> >--- a/arch/arm/boot/dts/omap34xx.dtsi
> >+++ b/arch/arm/boot/dts/omap34xx.dtsi
> >@@ -46,7 +46,7 @@
> >  			       0x480bd800 0x017c>;
> >  			interrupts = <24>;
> >  			iommus = <&mmu_isp>;
> >-			syscon = <&scm_conf 0xdc>;
> >+			syscon = <&scm_conf 0x6c>;
> >  			ti,phy-type = <OMAP3ISP_PHY_TYPE_COMPLEX_IO>;
> >  			#clock-cells = <1>;
> >  			ports {
> >

You may want to add the hint, that 0xdc (the old, wrong "offset")
represents the last few bits of the register address. I guess
somebody didn't notice, that scm_conf does not start at a register
address ending with 00 (like most other modules).

Reviewed-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXGiQoAAoJENju1/PIO/qaCR8P/2DNGzfpEEXHqisI4qTIwlyT
qq7hKdGNPB9hOkYesUg/9ihURBGaqlPdQA2DUSgtCQtv4DoLxumBOlvIfVNXk4Zn
fcbI003qZ0jBV+QVArdGOSVFMLDdOgm1hVanu4nCH1tlcjmGV7TAM+u3eEtEyfeX
dvXgUo0+VpLBvEJKh4dmWkYih3/ey/c0TTq/BF/OhcVs05zBJtc+YZid3Nu6Bugl
rzG6UDg3EPibmPN0fzRa1TLVe+7zTO21aPBfGdsHHyWgHi/C0Yd5YPWlzExbeKIg
suUlmZGYDWfuVTkZQAedrSnMXMuC5HcopLhsSvVu2sdN0Nuz9D9z9PGAQ7AynguD
YAayeA4w+GFx0sQw0Fkrg5oWO8vdZFRsgrivIHbffu2OMxiEPEFlCgBbYmINIXw9
ac/h1W1WK0UKL5MpgQIg7Qv/OabgdUyOZwRlOqnu1jl1BStzCRmYHgqNk5YNtyFi
GBQ1B7wcCETs5/vR+CNHNV59Ww8R7WruGSybISPPomZ167OsqJzsqB3rBhP0m+47
bPnWOauzEVNXXjFMDyy8zOtD+JiJ3j28Sj3d5yvNXNCN5urVwzhpfk12DI4XlgFe
kYGNdcszwKoGLZILfVF2uub+Sllb9o5VUJSZV3NWNWapVYT97J18lxV0p8TTcJD9
2xbLlvGmViWjB0Mim2zz
=ufB+
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
