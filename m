From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/10] usb: phy: cleanups to Kconfig and directories
Date: Fri, 8 Mar 2013 20:26:23 +0200
Message-ID: <20130308182623.GD900@arwen.pp.htv.fi>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
 <513904A4.7040101@wwwdotorg.org>
 <20130308071453.GD21589@arwen.pp.htv.fi>
 <513A1C63.9050704@wwwdotorg.org>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <513A1C63.9050704-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2013 at 10:14:11AM -0700, Stephen Warren wrote:
> On 03/08/2013 12:14 AM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Thu, Mar 07, 2013 at 02:20:36PM -0700, Stephen Warren wrote:
> >> On 03/07/2013 02:35 AM, Felipe Balbi wrote:
> >>> Hi folks,
> >>>=20
> >>> inspired by Paul's DWC2 patchset which added
> >>> usb_otg_state_string() (a copy of otg_state_string()) I have
> >>> now renamed otg_state_string() to usb_otg_state_string(), moved
> >>> it to usb-common, then moved all phy drivers to
> >>> drivers/usb/phy/ and completely deleted the otg directory.
> >>>=20
> >>> We're also removing CONFIG_USB_OTG_UTILS since that has lots
> >>> its meaning long ago.
> >>>=20
> >>> I have compiled all patches with allyes, allno and allmod
> >>> configs, but please make sure to test on your platforms to make
> >>> sure we're not leaking any more problems to mainline.
> >>=20
> >> What branch do the patches apply to? They didn't "git am" for me
> >> on either next-20130305, nor=20
> >> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
> >> next.
> >=20
> > they're on top of my testing branch.
>=20
> Ah, thanks. I took that whole branch, built ARM's tegra_defconfig, and
> see:
>=20
> > warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects USB_ULPI
> > which has unmet direct dependencies (USB_SUPPORT && USB_PHY &&
> > ARM) warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects
> > USB_ULPI_VIEWPORT which has unmet direct dependencies (USB_SUPPORT
> > && USB_PHY && USB_ULPI) warning: (ARCH_TEGRA_2x_SOC &&
> > ARCH_TEGRA_3x_SOC) selects USB_ULPI which has unmet direct
> > dependencies (USB_SUPPORT && USB_PHY && ARM) warning:
> > (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects USB_ULPI_VIEWPORT
> > which has unmet direct dependencies (USB_SUPPORT && USB_PHY &&
> > USB_ULPI)
>=20
> Manually enabling USB_PHY fixes this. However, this highlights an
> issue with your removal of all selects (as mentioned in your other
> email) - it will break perhaps any defconfig that has USB enabled.
>=20
> After enabling USB_PHY, the code builds and runs without issue.

fair enough, but then I'm just exposing the trouble. ARCH shouldn't
select USB_ULTI or any of the phy drivers, for that matter.

--=20
balbi

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJROi1PAAoJEIaOsuA1yqREeDoP92DL00bQXx0sFUkyCQORQJpZ
JgoucUJan75+d1khCqyl4B4KR2wBIyjBwdFBa96Kwo+FLLhxAWzt1IjJ7c1LWBmk
jlrhFV9qp/6d598i50G5GN/af4/bk9xvCzKCaTQ/mSe40qZDLbMwF7j3jAJGTvbA
xXtLp/mzomj7uFUO69DqNNRjxg1j4HZGngjR1dg6EjbFAMjeZq03aM+IQIClDw3w
lXHMCkCBlTWkwN4CXWNHRbULMAuzC/BG5u8UmUT6UqpdVjtZjcdgyJqTA3yiXxJl
aKvfm51hls2k13wVK8afJop8X1k+SPUCC35O3yeDsW29SvfMl2XMAvbld76zWSg+
7XJz5ZUmeVuMXu3H+EVXYnRaiWNK9UtbWc0vCp9tSvBcTH/xZ0MQWE08quMRTy8J
hzF1swyGmlzEziV3uJfa0iUoha2CQkI+h0TlZ5mB0i0l5SYui093knE7KoaSNvSn
4unxYqH5AW/CLkKmWnShDJgY2RM+UOvX12LmJLQpFOVRYU9NhGuyvKzFdMk6DCPa
GoD94Z5TyeEYp5unH+YyM+l0e+4+NqObogHkkgh5WyKIFlcEuMCULYDAOhGA0RSY
ff/YuUyFy09rVJUpZwxG910A/c5kfE44jDpVvfN+ORqhR/PzjDLoX9JVsjMHr3dr
d58vcbhVBKdjnOzupd8=
=keih
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
