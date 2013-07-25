From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Thu, 25 Jul 2013 09:40:01 +0300
Message-ID: <51F0C841.8000900@ti.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com> <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724145237.GB21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="w2n0t4xNUe9MsN0Jf6TtxIFDbJOnWSq8X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59398 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854Ab3GYGku (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Jul 2013 02:40:50 -0400
In-Reply-To: <20130724145237.GB21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Will Deacon <will.deacon@arm.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--w2n0t4xNUe9MsN0Jf6TtxIFDbJOnWSq8X
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24/07/13 17:52, Russell King - ARM Linux wrote:

> I also continue to be disappointed by the lack of things working on the=

> 4430 - it's been a number of years now and _still_ the on-board LCDs do=

> not work.  People have tried to blame that on hardware faults and the
> like, but they're just being idiotic when they say stuff like that.  It=

> can't be hardware faults when the kernel supplied with the board is abl=
e
> to make them work to the extent that userspace can play back video on a=
ll
> three output devices simultaneously, without hiccup or any imperfection=
=2E
> I don't know whether it's just that the backlight support isn't working=

> or what - because any information on the 4430 seems to be a tightly
> controlled secret that only a few select people are permitted to know
> about.  As far as I'm concerned, much of the hardware is a black box to=

> me.

The 4430SDP's backlight hasn't been working in the mainline due to
missing support from the TWL driver. But we finally did get that in for
3.10 (or maybe 3.9), and booting 3.10 non-DT kernel brings up the
backlights. However, the BL doesn't work yet with DT boot, so again with
3.11, with no board files, the BL is out... Sigh.

The panel driver itself have been working as long as it has been in the
mainline kernel (for me). I think there was a mixup at some point with
pinmuxing due to TRM having wrong information, but for some reason my
board works fine with both right and wrong muxing. If I recall right,
your board did not. But that's also solved some kernel versions ago.

But even with the above fixed, you could observe that your panel doesn't
work. The reason is that the panels in the 4430SDP board were chosen a
bit oddly: they are so called manual update panels, meant to be
explicitly updated by the software only when required. The phones that
have such panels (which, I guess, is what 4430SDP is designed to
resemble) have software doing that, but obviously the standard linux
software does not.

There's a hack to enable a non-optimal automatic update for testing
purposes:

echo 1 > /sys/class/graphics/fb0/update_mode

This makes omapfb update the display 20 times per second. Or via a
module parameter: omapfb.auto_update=3Dy

We could implement a better auto-update system for manual-update panels,
but I have opted not to:

- It's not easy to implement efficiently and reliably (in fact, we did
have auto-update support at some point in the kernel, but it was removed
as it was rather troublesome to keep working).

- Manual-update panels are meant to be updated manually, only when
needed. That's the whole point of the manual-update feature. Doing
auto-update with a manual-update panel is inefficient. So such a feature
would only be useful for testing purposes.

- Manual-update panels are quite rare, and the trend to use them seems
to be coming even rarer.

> And yes, my 4430 has the projector module on it.  Never ever seen that
> work, and no idea how to make it work because there's no information
> available on the hardware.

I don't have that one. PicoDLP shares resources (DSS pins, at least, if
I recall right, and some power line) with the second LCD, and we don't
have support to manage sharing those resources. So the PicoDLP is left
disabled in the board file.

I don't have any clear idea how to implement management of those
resources, and no one has ever asked about PicoDLP from me, so it's
never been a very high priority.

So 4430SDP is a bit difficult on the display side: non-standard panels
and a pico projector that is mutually exclusive with the LCD2.

> And no, I don't want another Beagle board or Panda board or whatever, I=

> have those (I think I have one of each), and they've never been powered=
 up
> because they have no ethernet on them, and I have no USB to ethernet st=
ill,
> partly because I don't really do USB here *at* *all*, so I don't know w=
hat
> works well and what doesn't with Linux.  Even if I did provide them wit=
h a
> USB ethernet, I doubt they'd be able to boot a kernel via the network.

Beagle xM and Panda have ethernet. I boot Panda via the network (load
kernel and use nfsroot). But they don't have panels, so you need an
external display for those.

 Tomi



--w2n0t4xNUe9MsN0Jf6TtxIFDbJOnWSq8X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR8MhBAAoJEPo9qoy8lh71nWYQAKhYvtTZGiBw8c/efticTSkQ
n7UKuWTd/b9tRIyeArpMgb5fIHvm38Busjf6dQlI8iQK/0v0pQiu2RYZHYWFvf50
9UTclQwvLIsxPJ87ALYc10BEcYhn3FbS6OJfQ7ztgGVka3h+hOUpJ2lGYWtTebQ3
yE9K57zcDRjDFgiHos5WfvsciA1M4gCN55uwBsAoFkjsURoVXEClZFqqvw0v8QB3
AmuUe3DIEh75VLAxtujss0yVd0q2ncBwvY7AS81glBJIb80Mvw8X+nTlkwplpSIk
Rke6i06cgP4+NKdvuNLYR+wfcS1HhFwganUnzCqIyDkw0vDgmbxIBOgEbPl+udR9
5R3Dhnf4vQ7SojsQYUP69ZG9YXjp5CjWEVylMoIAzvR15zLc3vNnIEAni0Ke2s4D
mNkqTlra2xhw9/gX8+NcK/jEDYts1pSdT9NdClYl5evuFL7GtLz7nbYkc8jB2Bqf
FH2I3lOT5pM3W30pV/CFA4TNtr+/xdt+ct5l3k9rWTMS/lRZMJ8/DU9sVUUvrrWX
ZjhLLMM0Sigdu+QncPzKd8+MuJy/VuBiDLaesgM3gsJ0NJQRoJMciBJdLe83Qn1S
midTvxPXeGOWwgoe6NliRk1H7QA9Yiuc3KjkZcrLqgZpGzinfkjDsvKU/mtT91xj
2vZ76ueOKvlvatWycwl0
=9h5B
-----END PGP SIGNATURE-----

--w2n0t4xNUe9MsN0Jf6TtxIFDbJOnWSq8X--
