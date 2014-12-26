From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 09:09:00 -0600
Message-ID: <20141226150900.GC17430@saruman>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il>
 <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il>
 <20141224154948.GA423@saruman>
 <20141224190401.GN23854@atomide.com>
 <549BE333.9060709@compulab.co.il>
 <20141226044246.GB7661@saruman>
 <549D4CEA.6090009@compulab.co.il>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50267 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbaLZPJs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Dec 2014 10:09:48 -0500
Content-Disposition: inline
In-Reply-To: <549D4CEA.6090009@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 26, 2014 at 01:56:26PM +0200, Igor Grinberg wrote:
> >>>> Tony, your call.
> >>>
> >>> I think we should move omap2plus_defconfig to be mostly modular and
> >>> usable for distros as a base. Most distros prefer to build almost
> >>> everything as loadable modules. And my preference is that we should
> >>> only keep the minimum rootfs for devices and serial support as
> >>> built-in and rely on initramfs for most drivers. And slowly move
> >>> also the remaining built-in drivers to be loadable modules.
> >>>
> >>> The reasons for having drivers as loadable modules are many. It
> >>> allows distros to use the same kernel for all the devices without
> >>> bloating the kernel. It makes developing drivers easier as just the
> >>> module needs to be reloaded. And loadable modules protect us from
> >>> cross-framework spaghetti calls in the kernel as the interfaces are=
=20
> >>> clearly defined.
> >>>
> >>> Are there people really using SATA as rootfs right now on omaps?
> >>
> >> Yes. That is exactly my point.
> >=20
> > read your email, you said it *CAN* have rootfs on SATA.
>=20
> yep, it also *CAN* have rootfs on MMC and NFS and ...

those we *know* people are using as rootfs. We know of several users who
are actually using it :-)

> >>> If it's only something that will be more widely used in the future,
> >>> then I suggest we make it into a loadable module, and presume
> >>> initramfs and loadable module also for any new devices. The same
> >>> way x86 has been doing with distros for years.
> >>
> >> The difference from x86 is that we're in embedded here and
> >=20
> > bullshit, you would never ship a product with omap2plus_defconfig. You'd
> > build your own at which point you would switch SATA to built-in.
>=20
> Yep, that is one of the options indeed, but I'm not asking you to
> deal with my problems, right?
> I'm feeling like you are trying to insult me.
> Are you angry with me? Why?
> Is it because I have a different opinion?

heh, cute :-)

> >> although initramfs is a kind of option, but it means, you need to
> >> load even more data during the boot process... it is annoying and
> >> I would not want to use it on embedded.
> >=20
> > make your own defconfig.
>=20
> This sounds like: mind your own business...
> Is that what you want to say?

nope, not really. Just saying that if you're really concerned about
being embedded and that initramfs takes that much more time to load,
you'd just make your own defconfig and maintain it out-of-tree.

RMK does that for quite a few boards, I do it for my boards and also for
my x86 desktops/laptops.

It's not really rocket science.

> >> (BTW, x86_64_defconfig has it compiled in...)
> >>
> >> We can also, split the defconfig as it was some time ago... but I
> >> would not want to go that direction...
> >>
> >> If we go the initramfs way, then why not also load MMC from it?
> >> That will also reduce kernel size... (but add initramfs size)
> >=20
> > I'm fine with that. The difference is that people have been relying on
> > MMC built-in for the past 10+ years, since the old OMAP1 MMC driver,
> > changing that now is likely to cause some "my board won't boot anymore"
> > bug reports.
>=20
> Yep. So there are exceptions, right?

never claimed the contrary.

> >> I'm sure you will find making the MMC a loadable module inconvenient.
> >> That how I find making the SATA a loadable module...
> >>
> >> Right now, we tell our customers that they can use mainline with
> >> omap2plus_defconfig.
> >=20
> > that's the worst thing you can do.
>=20
> Hmmm... Interesting, so people should not use mainline.

now you're reading what you want to read ;-) Using my statements out of
context.

It's clear (actually s/rootfs/defconfig below) that I meant defconfig.

> > You should at a minimum provide your
> > customers with a more minimal rootfs. Why would you have your customers

oh wait, not rootfs, defconfig.

> > build MUSB on an OMAP5 board ? Why would they build 5 different
> > network device drivers ? Why would they build almost every single PMIC
> > we ever used ? The list goes on and on.
>=20
> That is their decision to make. I'm just saying that they can use it.

right, and they can switch SATA to built-in if they want to ship an
initramfs-less product, don't you think ?

Or they can append initramfs to the kernel image and not even have a
root filesystem anywhere (been there, done that), but that's not
relevant to this discussion.

Anyway, I'll leave it to Tony.

--=20
balbi

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUnXoMAAoJEIaOsuA1yqREFr8P/iNdvinjVJwgnjZN3S4q7Rp1
EQecLNn6vlAzlm4peQ3Eu4Ea75QH2MPibp0KFe0RSL24JMCpIRnW5V3eUfyotN3T
TygDBfO4OToXI38fdBS3cy5+duV4MijtngYcOuVBxLfeYaFscYJrLjS0yk7Ry1Fq
7eZVQhH+ZJS6J6QCYGezn/WlxSJKZIPtjGh0OWMBcervhGKhIHF9zKLx0fM+Ra3p
Mr5vvcGafVl7Rclsa/DFmSUPm74J6BUqdIHsbwe5ZH1x/MNML0+Ljhn3cYCdrnQJ
gXucm5Il06eqFQISHVJNunN6DMwYS9/sTz1cDB3AOJpEQ+UXtjTkDS9GBS/+v9lB
bLhPCCQqFxAf8WxbAK+h/16lxSfLoourztuEQO1ZHP/LU9laipYhCd0toWy2O3Q4
2nIcX4mgX4CPcimOh3Wbg/GlmiUWVKCcEJmClUaqK3GvOowkoeW6it0s5EdVc4Wj
dIcCFhIFq/od0xF2sJf8w3qP70k5PfX5J/OXeYBsEg7g/hkkvuVNzPeyy6uSXJwB
WgRg/GU/y6kVTr7z0BzPXTZdt0Zq+76PkJoZQnjl9ySUWT2FVmHsEp/R0who2TPX
c4L3RqioFvIo6BEQCwK+v9hbgH64lj/mCiEO/PyHj6Hmc5yHZpaCWH1Tr60ZuTOD
e7XO/A316J3NY6oWijvY
=Jrci
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
