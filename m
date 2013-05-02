From: Felipe Balbi <balbi@ti.com>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Thu, 2 May 2013 21:06:27 +0300
Message-ID: <20130502180627.GA10672@arwen.pp.htv.fi>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <20130502082218.GA21614@n2100.arm.linux.org.uk>
 <20130502153834.GR28721@atomide.com>
 <51829D65.7040109@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47647 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759287Ab3EBSHI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 May 2013 14:07:08 -0400
Content-Disposition: inline
In-Reply-To: <51829D65.7040109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Neil Brown <neilb@suse.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Durgadoss R <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 02, 2013 at 01:07:49PM -0400, Eduardo Valentin wrote:
> Arnd, Tony,
>=20
> On 02-05-2013 11:38, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [130502 01:27]:
> >> On Tue, Apr 30, 2013 at 09:17:39AM +0100, Russell King - ARM Linux wro=
te:
> >>> Latest nightly build of 3.9+my for-next+arm-soc's for-next results in=
 a
> >>> great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
> >>> arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the bigge=
st
> >>> source of errors.
> >>>
> >>> OMAP stuff needs a serious look at too - much Kconfig madness there
> >>> caused by over-use of select, which then goes on to cause build errors
> >>> because it assumes some stuff is always enabled.
> >>>
> >>> There's also warnings about of_device_id from include/linux/of_platfo=
rm.h
> >>> via from arch/arm/kernel/setup.c which feature in all the non-OF buil=
ds
> >>> too which need addressing.
> >>>
> >>> See todays http://www.arm.linux.org.uk/developer/build/ results for a=
ll
> >>> the details and configs.  Not pushing my tree until some of this stuff
> >>> gets fixed.
> >>
> >> And now we have a new bunch of warnings from OMAP stuff which weren't
> >> previously there...
> >>
> >> arch/arm/mach-omap2/omap_device.c: In function 'omap_device_get_by_hwm=
od_name':
> >> arch/arm/mach-omap2/omap_device.c:821:3: warning: return makes pointer=
 from integer without a cast
> >> arch/arm/mach-omap2/omap_device.c:826:3: warning: return makes pointer=
 from integer without a cast
> >=20
> > Hmm these I already fixed earlier along with a merge resolution, and
> > I'm not seeing them in next/master or arm-soc/for-next. What do you
> > have merged into your current tree?
> >=20
> >> drivers/power/twl4030_charger.c: In function 'twl4030_charger_enable_u=
sb':
> >> drivers/power/twl4030_charger.c:192:20: warning: ignoring return value=
 of 'regulator_enable', declared with attribute warn_unused_result
> >=20
> > Neil, care to provide a fix for this? It's from your commit ab37813
> > (twl4030_charger: Allow charger to control the regulator that feeds it).
> >=20
> >> include/linux/thermal.h:254:12: warning: 'thermal_generate_netlink_eve=
nt' defined but not used
> >=20
> > Eduardo, can you fix that one? It seems to be from your commit 8ab3e6a
> > (thermal: Use thermal zone device id in netlink messages).
>=20
> Yeah sure I can fix it. As simple as the following:
> From c04244c87312f5bfc61d9e12ba3fbaa0fdd81adb Mon Sep 17 00:00:00 2001
> From: Eduardo Valentin <eduardo.valentin@ti.com>
> Date: Thu, 2 May 2013 12:58:20 -0400
> Subject: [PATCH 1/1] thermal: remove stub for thermal_generate_netlink_ev=
ent
>=20
> This patch removes the stub for thermal_generate_netlink_event
> because this function is not used anywhere inside the kernel.
>=20
> In case CONFIG_NET is not set we get:
> include/linux/thermal.h:254:12: warning:
> 'thermal_generate_netlink_event' defined but not used
>=20
> Thus removing it.
>=20
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  include/linux/thermal.h | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index e3c0ae9..e3f3cba 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -250,12 +250,6 @@ void thermal_unregister_governor(struct
> thermal_governor *);
>  #ifdef CONFIG_NET
>  extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>  						enum events event);
> -#else
> -static int thermal_generate_netlink_event(struct thermal_zone_device *tz,

just adding 'inline' would be an easier patch and lets you compile fine
on !CONFIG_NET when you starting using thermal_generate_netlink_event().

--=20
balbi

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRgqsjAAoJEIaOsuA1yqRE8hAP+wWoBI9+UNXyV2nguYTbeZ62
7NagS+pcZMAnI7xJq3qQusIchTNh5eEq5y9TOK9w5VfGvihlizestAzG0SrpGdY2
pTtUFdkkSrVWeeuVqlJnMiDjFaogdCDm9/jK0h0hnrwN/RzpeV/EmbbqV3jsu0tu
MI0HrsBuf0bugkiTwLuRrnwBuMLI/qCg05+nB0ZmsP0L2u42ClgWUZPn76EOUawe
susSkBA4BefoN2oHEptPYWvKeAlRQzjggJX15FUAxOlk9lQMu+aJspDzjy0D18Qh
/6bb9vqy/3JRUWqwyR4s6qRX40YTmhOBbbI0Z6A1s7eDy4WL6641mI0hzEpuiEnt
bG1hwFBRUq5TFsPAYW+6iWPmOqz3vgXxRsHFvHDrshtXEkoFsOVwusZ3EMTZsizu
yvmrqR5wLNxVVBmZpvBdTn+1T1B63ixJTJg60MHbY7W6wKjiY9JYnMP9kIqHXqqd
ZwOmhWG/MSAQoUNAeRWVe+9Plzo2ZQOgdAlQ3qeQxroCfxZRTxdUgWghlcqf/Nvm
NNgTgJKQF1WHVEVgcvy5tylbPTlYe+tm0yPp3fCtlHGvnaEmMoCsmR4O+c80WvBt
GI6pimEFkAqmZg2PNKlPfWiE3ZcNpe4Lo0FmhC34J9WlpPEX7w+KvfUO7CA6CcYQ
rXm7XdV1Usrf/qmHRHfw
=rNqs
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
