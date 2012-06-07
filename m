From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Thu, 7 Jun 2012 11:14:02 +0300
Message-ID: <20120607081400.GJ16342@arwen.pp.htv.fi>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk>
 <20120607073112.GX12766@atomide.com>
 <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com>
 <20120607075158.GZ12766@atomide.com>
 <20120607075541.GF16342@arwen.pp.htv.fi>
 <4FD0602B.9070704@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9aCKuHbn5v2q3RVc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:51143 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754463Ab2FGIPx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 04:15:53 -0400
Received: by lbgc1 with SMTP id c1so324829lbg.15
        for <linux-omap@vger.kernel.org>; Thu, 07 Jun 2012 01:15:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FD0602B.9070704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>


--9aCKuHbn5v2q3RVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2012 at 10:02:51AM +0200, Cousson, Benoit wrote:
> On 6/7/2012 9:55 AM, Felipe Balbi wrote:
> >On Thu, Jun 07, 2012 at 12:51:58AM -0700, Tony Lindgren wrote:
> >>* Paul Walmsley<paul@pwsan.com>  [120607 00:44]:
> >>>On Thu, 7 Jun 2012, Tony Lindgren wrote:
> >>>
> >>>>Here too I think driver like features like this should live in the
> >>>>driver init for omap OHCI driver. In the likely case that FS OHCI is
> >>>>not in use on the board, the OHCI glue can just reset it.
> >>>
> >>>What if the driver is not compiled into the kernel, but instead is bui=
lt
> >>>as a loadable module?
> >>
> >>You can still have a core piece of the driver that's always built in, s=
uch
> >>as omap-ohci-common. But it should live under drivers, not in the bus l=
evel
> >>code. Or you can insmod/rmmod it to reset things properly.
> >
> >that's such a hack... both solutions are quite hacky. The only problem
> >here is because some bootloaders are leaving controller in an unknown
> >state and I guess to be completely safe, resets should be done before
> >any driver kicks in.
> >
> >But, driver will probably reset again the IP block during probe...
>=20
> Ideally it should be done only in the probe if needed. In the case of
> the DSS, the bootloader can init it with a splash screen and we do
> not want to blindly reset it and thus produce some ugly artifact on
> the screen.
>=20
> In fact we should delay the reset to the very last moment and
> potentially reset the IPs not under driver control later after a
> couple of second for example.
> It will avoid reseting every IP that will be handled properly by drivers.

you could have a late_initcall() that will iterate over hwmods and reset
the ones which aren't used. That would mean adding some extra code to
omap_device_build_ss() which would set a flag on each hwmod, or
something similar.

--=20
balbi

--9aCKuHbn5v2q3RVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0GLIAAoJEIaOsuA1yqREIeAP/RZM5eCRTpuuxHkJQ/TXCuQ5
akpOSyoWaiHQFZRYtO23FUEwcVe3Dyn4fA8BSqjIPbjdsWcAVXh4OLvn35VRA2Et
K7IgpbTy/MEFCFqwfqf9CRVHv1UCGaHIsLksVrmrxBb5qAG87a7xcCOqG9gj5RLB
jM/dQWviPTDG00CCma6MUFmv88lGoi6o/umedHpQkd3MoS8XZsNiZm+uRMyg5B+5
cBGm+TUYN+0wu6L4nc9A4bmZeVZEtCjWC3Lti1h+mpvW6FyirxB9det0zcheKYz0
6RL2+oNJJXLxGrLlYxtCKK2YdAwSgQOtIFEVXYOhM9m6k1JAAe8noqv0ENVpEI4f
hUqeVJz2E7Awq7bHUply8RyCdDpnlUHi/9evVK1BMl9Neu6ZiwIcHQW13Z0VNq7c
E4YfMFVlDXFCIhxNHSNHg9ySx0WqzlhpbmkgGzkLTUy93d/4uOATrfe6+MohvsTl
ptNVnuowxyd4gBxXx0VkGS9og6JGkc8YHTl1z+/ACZH0QBQOw9hquY0AEgGk60je
ZpLZEaTFIQdVhE8mh0z/gKeMPrPgrLla4nX4hi7xEPVgcBrDi3a1PcJXVDJxIiO0
+xvfyqakr7Y8FoN4add1JBWz6eUW5+FLFgoW/37Hjokiifro654Eqnij8ukGGwAb
eHCxAHv1GiiZ8lHa+gky
=UVDy
-----END PGP SIGNATURE-----

--9aCKuHbn5v2q3RVc--
