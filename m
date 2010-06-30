From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: ARM defconfig files
Date: Wed, 30 Jun 2010 12:40:43 +0200
Message-ID: <20100630104043.GG11746@pengutronix.de>
References: <20100603074548.GA12104@flint.arm.linux.org.uk> <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org> <20100603181010.GA25779@flint.arm.linux.org.uk> <1275589230.23384.19.camel@c-dwalke-linux.qualcomm.com> <alpine.LFD.2.00.1006031119440.8175@i5.linux-foundation.org> <20100614083214.GA2104@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100614083214.GA2104@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Walker <dwalker@codeaurora.org>, Russell King <rmk@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Eric Miao <eric.miao@canonical.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

I think my mail hit your inbox during your vacation.  As this is quite
important for the ARM people and there isn't much time left, can you
please comment?

Thanks in advance
Uwe

On Mon, Jun 14, 2010 at 10:32:14AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> [Added linux-arm-kernel ML to Cc, note that it's moderated for
> non-subscribers.]
>=20
> On Thu, Jun 03, 2010 at 11:21:59AM -0700, Linus Torvalds wrote:
> >=20
> >=20
> > On Thu, 3 Jun 2010, Daniel Walker wrote:
> > >=20
> > > I don't see how we can do without defconfigs altogether tho. I me=
an , if
> > > you want to run a Beagle board or a Nexus one we can't just give =
the
> > > users a slim ARM config and let them troll through 1000's of driv=
ers
> > > trying to find just those ones that work on their given board.
> >=20
> > Well, you also don't need the full defconfig's with the kernel.
> >=20
> > Right now they are just noise. They actually _hide_ things, because=
=20
> > diffstat (and dirstat) information becomes pointless, and the diffs=
 become=20
> > totally unreadable by any human (trust me - when the choice is betw=
een=20
> > "search for next relevant diff" or "blast it, I can't be bothered w=
ith=20
> > walking through this crap", quite often the choice is the latter).
> I wrote a script that throws out all unneeded lines in all arm
> defconfigs that don't influence the resulting .config for .34 and
> .35-rc1 and compared .34<->.35-rc with .34-reduced<->.35-rc1-reduced.
>=20
> Here are the results:
>=20
> 	$ git diff --dirstat v2.6.34 v2.6.35-rc1 arch/arm
> 	  11.8% arch/arm/configs/
> 	  10.0% arch/arm/mach-msm/
> 	  10.8% arch/arm/mach-omap2/
> 	   4.8% arch/arm/mach-pxa/
> 	   4.5% arch/arm/mach-s5pc100/
> 	   3.3% arch/arm/mach-s5pv210/
> 	   4.4% arch/arm/mach-spear3xx/
> 	   3.1% arch/arm/mach-ux500/
> 	   5.1% arch/arm/plat-s5pc1xx/
> 	   3.1% arch/arm/plat-samsung/
> 	  38.2% arch/arm/
>=20
> 	$ git diff --dirstat arm/defconfig/reduced-v2.6.34 arm/defconfig/red=
uced-v2.6.35-rc1 arch/arm
> 	   3.1% arch/arm/mach-davinci/
> 	  11.3% arch/arm/mach-msm/
> 	  12.2% arch/arm/mach-omap2/
> 	   5.4% arch/arm/mach-pxa/
> 	   5.1% arch/arm/mach-s5pc100/
> 	   3.7% arch/arm/mach-s5pv210/
> 	   5.0% arch/arm/mach-spear3xx/
> 	   3.5% arch/arm/mach-ux500/
> 	   5.8% arch/arm/plat-s5pc1xx/
> 	   3.5% arch/arm/plat-samsung/
> 	  40.9% arch/arm/
>=20
> 	$ git diff --dirstat=3D0 arm/defconfig/reduced-v2.6.34 arm/defconfig=
/reduced-v2.6.35-rc1 arch/arm | grep config
> 	   1.1% arch/arm/configs/
>=20
> 	$ git diff --shortstat v2.6.35-rc1 arm/defconfig/reduced-v2.6.35-rc1
> 	 177 files changed, 652 insertions(+), 194157 deletions(-)
>=20
> (The insertions above are only moved lines I think, I didn't check th=
em
> all.)
>=20
> The branches arm/defconfig/reduced-v2.6.34 and
> arm/defconfig/reduced-v2.6.35-rc1 are available at my repo at
> git://git.pengutronix.de/git/ukl/linux-2.6.git .  (There is a gitweb =
at
> http://git.pengutronix.de/?p=3Dukl/linux-2.6.git)
>=20
> So maintaining these minimal defconfigs would have reduced the defcon=
fig
> noise from 11.8% down to 1.1%.  And probably it could be considerably
> reduced further with constructs like:
>=20
> 	config HAVE_MTD_NAND_MXC
> 		bool
>=20
> 	config MTD_NAND_MXC
> 		tristate "MXC NAND support"
> 		...
> 		default m if HAVE_MTD_NAND_MXC
> 		help
> 		  ...
>=20
> 	...
> 	config MACH_MX27ADS
> 		...
> 		select HAVE_MTD_NAND_MXC
>=20
> .  Compared with selecting everything in Kconfig files this approach
> allows further tweaking of a config.  (E.g. "I have a mx27ads machine=
,
> but I don't need nand support.")  Compared with the SAT-Solver it's a=
n
> idea that works today.
>=20
> One downside of this approach (when done with my script only) is that
> too much is removed.  E.g. in mx3_defconfig CONFIG_ARCH_MX3 is remove=
d.
> This is OK from a logical POV but then changing the default of the
> corresponding choice (and I intend to do that in the near future) wou=
ld
> break this defconfig.
>=20
> I can share my script and I'm willing to support maintaining the
> minimality of the defconfig files if they are an acceptable (maybe
> intermediate) step for Linus.
>=20
> Together with the efforts to reduce the number of defconfigs as thoug=
ht
> about in other mails of this thread the situation should become quite
> better for Linus.  (I'm currently working on merging support for all
> Freescale SoCs into a single mach- directory and so merge mx1_defconf=
ig,
> mx21_defconfig, mx27_defconfig, mx31pdk_defconfig, mx3_defconfig and
> mx51_defconfig.)
>=20
> Linus: I would really appreciate if you wouldn't remove all (or nearl=
y
> all) defconfig files.  I think you would force a quicker solution to
> this problem, but during that time the ARM community would loose comp=
ile
> coverage.
>=20
> Thoughts on this?
>=20
> Best regards
> Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
