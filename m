From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 09:19:07 -0600
Message-ID: <20141226151907.GD17430@saruman>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il>
 <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il>
 <20141224154948.GA423@saruman>
 <20141224190401.GN23854@atomide.com>
 <549BE333.9060709@compulab.co.il>
 <20141226044246.GB7661@saruman>
 <549D4CEA.6090009@compulab.co.il>
 <CABxcv=n+FSuZemxQb2=wFM8m6xmWUKACnrCWFG-LevToU_UVHg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49704 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaLZPT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Dec 2014 10:19:56 -0500
Content-Disposition: inline
In-Reply-To: <CABxcv=n+FSuZemxQb2=wFM8m6xmWUKACnrCWFG-LevToU_UVHg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 26, 2014 at 02:42:07PM +0100, Javier Martinez Canillas wrote:
> Hello all,
>=20
> On Fri, Dec 26, 2014 at 12:56 PM, Igor Grinberg <grinberg@compulab.co.il>=
 wrote:
> >>>>> Tony, your call.
> >>>>
> >>>> I think we should move omap2plus_defconfig to be mostly modular and
> >>>> usable for distros as a base. Most distros prefer to build almost
> >>>> everything as loadable modules. And my preference is that we should
> >>>> only keep the minimum rootfs for devices and serial support as
> >>>> built-in and rely on initramfs for most drivers. And slowly move
> >>>> also the remaining built-in drivers to be loadable modules.
> >>>>
> >>>> The reasons for having drivers as loadable modules are many. It
> >>>> allows distros to use the same kernel for all the devices without
> >>>> bloating the kernel. It makes developing drivers easier as just the
> >>>> module needs to be reloaded. And loadable modules protect us from
> >>>> cross-framework spaghetti calls in the kernel as the interfaces are
> >>>> clearly defined.
> >>>>
>=20
> I do agree with Tony and Felipe that we should try to build as much
> stuff as possible as a module instead of built-in to match what
> distros do and what has been done for x86 for years.
>=20
> However, if that's the case I wonder what's the point of having both
> an omap2plus_defconfig and a multi_v7_defconfig? Would it make sense

I wonder the same thing, but look at multi_v7_defconfig today. Almost
everything is built-in, which makes the kernel image enormous (5.5MiB).

> to get rid of the SoC specific configs then and just use the single
> ARMv7 defconfig for all SoCs with most of the options enabled as a
> module?

if people accept switching some of those as modules, sure. I don't mind
that at all. I'll still continue to maintain my out-of-tree defconfigs
for my boards anyway. It's also very good to have a generic defconfig
which will just work with everything I have.

> FYI, some time ago I posted a patch to enable SBS-compliant batteries
> support as a module for Exynos defconfig and was told to re-spin the
> patch and enabling it as built-in instead since the most popular use
> case for exynos_defconfig was development and people usually just copy
> the kernel binary and not the modules [0].

lol, that's the reason why I don't use multi_v7_defconfig.

> So it seems that each ARM SoC community has a different opinion about
> how things should be configured and do it differently.

I wouldn't be surprised.

> >> bullshit, you would never ship a product with omap2plus_defconfig. You=
'd
> >> build your own at which point you would switch SATA to built-in.
> >
>=20
> There are different opinions but let please try to keep the discussion
> constructive and use a polite tone.
>=20
> >>>
> >>> Right now, we tell our customers that they can use mainline with
> >>> omap2plus_defconfig.
> >>
> >> that's the worst thing you can do.
> >
>=20
> I'm confused, Felipe said that customers should not base their config
> from omap2plus_defconfig but AFAUI Tony's argument is exactly the
> opposite, that everything should be configured as a module so distros

basing on omap2plus_defconfig is never an issue. Claiming that you're
concerned about the extra KiBs for loading initramfs and then saying you
ship embedded products with omap2plus_defconfig is BS.

> can use omap2plus_defconfig as a base. So, is or is not expected that
> people will use omap2plus_defconfig as a base for their own config?

I never claimed that people should not use it as a *base*, rather it
should not be used to build a product's kernel/modules. Imagine you
shipping an embedded product based off of OMAP5 and you add CPSW, QSPI,
MUSB, a ton of touchscreen drivers you don't use, several PMIC drivers
built-in, etc. It's a waste of space and just bloats that product's
zImage.

> I think the problem is that there isn't an agreement about what is the
> purpose of the per SoC (e.g: oma2plus_defconfig) and the multi_v7
> defconfigs (or at least is not well documented since I could not find
> it). So, IMHO this concern should be raised to the ARM SoC maintainers
> and there should be an agreement in the ARM community as a whole about
> how things should be configured on each defconfig, and all SoCs should
> follow the agreed rule.

OTOH, the OMAP defconfig is part of the OMAP port and Tony will have the
final saying about it, right ?

> Otherwise it seems that the motivation for each kconfig symbol enabled
> is just to make the workflow of the developer posting the patches
> easier and wins whoever shouts louder.

it is just to make things easier. In fact, I only enabled AM437x SK's
drivers on o2+_dc because I got tired of people telling me that board
"doesn't work with mainline" and being completely reluctant to change
their defconfig. At that point I talked to Tony and he said "as long as
things are added as modules, I don't mind".

cheers

--=20
balbi

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUnXxrAAoJEIaOsuA1yqREl+sQALOOxg6tTpYQ2PC5WjyZNpin
vO4QDQdcK/iN8ekTFgvz7eAq818T+BwrbHD/n8996c2/UjGCyfdAyDAq2vY7/3Ex
dEFJghfqrqvb2xKjXAwmtarc4gL7Z3AIltSaDh7YPqFjTP4Fuv2U1CBxb/vGwfoV
MfT+OlnUvV60jIeksvvgzJ+4+ibcc94WbHPXoJ4gPxptfms40y7i15syU9MYpnUb
r3lAAl9CvPZuVXo5GmXIIADspiCWgDY1L55L1vAZZOx9HIkw9WuzexV7kg+fFrFF
hZqVVc4DK7olfP5InKVhQFBAyQfeIZ68zlsYDWo3rr0pLO5jywHToSReg1LTvwV3
vNVBbe32/NCzz1fR+PfuFdOF0cDqpvCPOqfIT5NEaGZUs2iP6kQHWak7awdhDaZy
xYtmnfHXyU5QRvx5hM7LDE9l1xT/i4ubqvhSsztUbeDKysecqjIxsDEMhR8mk3r6
kEUq9JSTAk2JA1uP+nwMtp6E5Sho4HzHdY6yUGlSu+Nj60kTiE4fRDSylwtF9Dt9
y1lSUm6r0tRcR717dyoRE04fLcsXdZx0kRxqlJqiVydBc/YdJvVCgNkrg8TQ0ptc
/huDCRxbBE8+6Xz8sA57fyD2VJeMF7Himbsq3oxXlTvYOtHiidWxykVs5v5/TF6r
BW8AFdQ62JjjC9UMMScj
=RtBf
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
