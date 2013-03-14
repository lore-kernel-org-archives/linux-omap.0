From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/10] usb: phy: cleanups to Kconfig and directories
Date: Thu, 14 Mar 2013 13:01:29 +0200
Message-ID: <20130314110129.GI32369@arwen.pp.htv.fi>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
 <513904A4.7040101@wwwdotorg.org>
 <20130308071453.GD21589@arwen.pp.htv.fi>
 <513A1C63.9050704@wwwdotorg.org>
 <20130308182623.GD900@arwen.pp.htv.fi>
 <513A2FDD.2040800@wwwdotorg.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42945 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756980Ab3CNLBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 07:01:46 -0400
Content-Disposition: inline
In-Reply-To: <513A2FDD.2040800@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: balbi@ti.com, Linux USB Mailing List <linux-usb@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, cbou@mail.ru, dwmw2@infradead.org, stern@rowland.harvard.edu, arnd@arndb.de, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org

--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2013 at 11:37:17AM -0700, Stephen Warren wrote:
> On 03/08/2013 11:26 AM, Felipe Balbi wrote:
> > On Fri, Mar 08, 2013 at 10:14:11AM -0700, Stephen Warren wrote:
> >> On 03/08/2013 12:14 AM, Felipe Balbi wrote:
> >>> Hi,
> >>>=20
> >>> On Thu, Mar 07, 2013 at 02:20:36PM -0700, Stephen Warren
> >>> wrote:
> >>>> On 03/07/2013 02:35 AM, Felipe Balbi wrote:
> >>>>> Hi folks,
> >>>>>=20
> >>>>> inspired by Paul's DWC2 patchset which added=20
> >>>>> usb_otg_state_string() (a copy of otg_state_string()) I
> >>>>> have now renamed otg_state_string() to
> >>>>> usb_otg_state_string(), moved it to usb-common, then moved
> >>>>> all phy drivers to drivers/usb/phy/ and completely deleted
> >>>>> the otg directory.
> >>>>>=20
> >>>>> We're also removing CONFIG_USB_OTG_UTILS since that has
> >>>>> lots its meaning long ago.
> >>>>>=20
> >>>>> I have compiled all patches with allyes, allno and allmod=20
> >>>>> configs, but please make sure to test on your platforms to
> >>>>> make sure we're not leaking any more problems to mainline.
> >>>>=20
> >>>> What branch do the patches apply to? They didn't "git am" for
> >>>> me on either next-20130305, nor=20
> >>>> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git=20
> >>>> next.
> >>>=20
> >>> they're on top of my testing branch.
> >>=20
> >> Ah, thanks. I took that whole branch, built ARM's
> >> tegra_defconfig, and see:
> >>=20
> >>> warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects
> >>> USB_ULPI which has unmet direct dependencies (USB_SUPPORT &&
> >>> USB_PHY && ARM) warning: (ARCH_TEGRA_2x_SOC &&
> >>> ARCH_TEGRA_3x_SOC) selects USB_ULPI_VIEWPORT which has unmet
> >>> direct dependencies (USB_SUPPORT && USB_PHY && USB_ULPI)
> >>> warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects
> >>> USB_ULPI which has unmet direct dependencies (USB_SUPPORT &&
> >>> USB_PHY && ARM) warning: (ARCH_TEGRA_2x_SOC &&
> >>> ARCH_TEGRA_3x_SOC) selects USB_ULPI_VIEWPORT which has unmet
> >>> direct dependencies (USB_SUPPORT && USB_PHY && USB_ULPI)
> >>=20
> >> Manually enabling USB_PHY fixes this. However, this highlights
> >> an issue with your removal of all selects (as mentioned in your
> >> other email) - it will break perhaps any defconfig that has USB
> >> enabled.
> >>=20
> >> After enabling USB_PHY, the code builds and runs without issue.
> >=20
> > fair enough, but then I'm just exposing the trouble. ARCH
> > shouldn't select USB_ULTI or any of the phy drivers, for that
> > matter.
>=20
> Yes, I think it should instead work like:
>=20
> ARCH_TEGRA* selects nothing in particular related to USB.
>=20
> The Tegra EHCI controller Kconfig depends on ARCH_TEGRA so it doesn't
> show up for other builds. I hope it's OK for the EHCI controller to
> select USB_ARCH_HAS_EHCI?

that's something the ARCH should select but it has very little value. I
guess there has been some discussions about dropping that and I support
it.

> The Tegra EHCI controller Kconfig selects everything needed for it to
> be useful, i.e. PHY support and the Tegra PHY, and I guess the ULPI
> viewport options.

should it ? I don't know... There's no way to select something as
module, but there's no eas\(y\|ier\) way to make sure PHY is enabled
when building EHCI-tegra.

> The Tegra PHY Kconfig probably shouldn't be user-visible (relying on
> being selected by the Tegra EHCI controller) and itself selects
> anything it relies on.

That I really don't like. I think the driver should be selectable and
build in anything architecture. That's the easier way to:

a) build test a driver when applying patches; and
b) make sure drivers won't include <mach/*> or <asm/*>.

--=20
balbi

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQa4JAAoJEIaOsuA1yqRE0D0P/j9gZFkUQ67By7yXPikKaFpK
bdgPh6r08s4jYCe7/qqwBH7PdeXw5BP62FZ3gI86RpoWVxMjyKSNpNQHp9Ew8R2d
sNn9juenE1mQUOX8bUNc4CPRVDKyS3kRUtJGZXel7tRGpfIutjlhjshW0m7hqqmP
MMSlEC/zsMNWl81YMc86WVsahKGFu4Vc2qpJpLhkMeZAW89zhiqL3Ehke89ARWtY
8GsXIna21hmdmNbwb1rWpe9twgvwF6OOsJyfI0QiitBTLjaRJZ9DlDEm7zmSVhr2
NzBpPsxSNMWsYJPg+YS8QgahVd5tGZxJpyOg7PKScde3Gy4EU1cv1LQC/5RY214o
mDCW5NlhIN/EU4JARANBmiG3HLxf5n44mrfslXQThbzqj1SrvggONbsiN6EaZSYq
/k1bl1tgaUsn9Wc/IXaF2g4BqR2kgOqey6XCV/ZcIKiP9WcJV6ir4EnDOxwn3hp7
B1DZc8L169gZ6npsht4MqoY1NUJdGAca992MC4zH0z95CbfCRCeXcrhzY/uCT/l+
4S670M+OsFQGiHy7dxSNALOimWjvQJLfiFYoluew6dPptVyuO5OLyBlV4u2BogTU
Z492nCKt+EylyZhoLsMyS5yrFqPDijIYLEJtBkkf3xX5FDUtP+tVbNEXGQfouoYj
xy7Sti/cHa72PMWolPW/
=b1gv
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--
