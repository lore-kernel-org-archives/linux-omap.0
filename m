From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: type casts update_sched_clock cyc_to_sched_clock
 cyc_to_fixed_sched_clock
Date: Tue, 5 Apr 2011 10:31:44 +0200
Message-ID: <20110405083144.GN13963@pengutronix.de>
References: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de>
 <20110405075622.GB4699@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48699 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab1DEIcH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 04:32:07 -0400
Content-Disposition: inline
In-Reply-To: <20110405075622.GB4699@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jan Weitzel <j.weitzel@phytec.de>, kaloz@openwrt.org, khc@pm.waw.pl, tony@atomide.com, eric.y.miao@gmail.com, kernel@pengutronix.de, rubini@unipv.it, STEricsson_nomadik_linux@list.st.com, ben-linux@fluff.org, kgene.kim@samsung.com, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, trivial@kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Apr 05, 2011 at 08:56:22AM +0100, Russell King - ARM Linux wrot=
e:
> On Tue, Apr 05, 2011 at 09:43:21AM +0200, Jan Weitzel wrote:
> > parameter "u32 mask" type cast befor inversion
s/befor/before/

> Nak.  I want a 32-bit all ones quantity.
>=20
> unsigned long long vali =3D (unsigned short)~0;
> unsigned long long vall =3D ~(unsigned short)0;
>=20
BTW, the definiton of vall is equivalent to=20

	unsigned long long valu =3D ~(unsigned int)0;

because ~ converts the unsigned short to unsigned int.

> compiles to:
>=20
> vali:
>         .word   65535
>         .word   0
>=20
> vall:
>         .word   -1
>         .word   -1
I really wonder about that. If I take a value of 0xffffffff (i.e. a 32
bit wide int =3D=3D ~0U) and assign that to an 64-bit unsigned long lon=
g I'd
expect it to get the value 0x00000000ffffffffULL, not
0xffffffffffffffffULL. What's wrong?

> So moving the ~ to be evaluated after the cast has the effect of maki=
ng
> the cast pointless, and produces wrong values.  (u32)~0 does the 32-b=
it
My C-Book tells that using ~ on a signed it produces implementation
defined behaviour. That's what I pointed out to Jan and I guess that's
the reason why he created the patch.

> cast _after_ the inversion which ensures that its always truncated to
> a 32-bit value.
>=20
> As the function is declared as taking a u32, the cast isn't needed.  =
If
> the function gets changed to take a u64, the casts will need to be
> re-added.  So, (u32)~0 makes the fact that we want a 32-bit all-ones
> mask explicit.
Actually this only results in a 32-bit all-ones value if int is at leas=
t
32 bits long, so technically using ~(u32)0 is better. (Obviously this i=
s
given on ARM and I guess even on all platforms that Linux runs on.)

Best regards
Uwe

PS: this mail is not about trolling.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
