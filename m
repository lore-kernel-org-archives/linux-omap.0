From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 00/62] Add definition for GPIO direction
Date: Tue, 5 Nov 2019 14:36:04 +0100
Message-ID: <20191105133604.d2xcasxw7pwzwvh7@pengutronix.de>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
 <20191105122042.GO32742@smile.fi.intel.com>
 <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
 <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
 <938a5ec7b41ae9ce7b0de83764d6b774cfdaa781.camel@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <938a5ec7b41ae9ce7b0de83764d6b774cfdaa781.camel@fi.rohmeurope.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc: "semi.malinen@ge.com" <semi.malinen@ge.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "david.daney@cavium.com" <david.daney@cavium.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "ptyser@xes-inc.com" <ptyser@xes-inc.com>, "t.scherer@eckelmann.de" <t.scherer@eckelmann.de>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "marek.behun@nic.cz" <marek.behu>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 05, 2019 at 01:30:20PM +0000, Vaittinen, Matti wrote:
> On Tue, 2019-11-05 at 14:10 +0100, Uwe Kleine-K=F6nig wrote:
> > Hello,
> > =

> > On Tue, Nov 05, 2019 at 12:54:55PM +0000, Vaittinen, Matti wrote:
> > > On Tue, 2019-11-05 at 14:20 +0200, Andy Shevchenko wrote:
> > > > I would also like to see bloat-o-meter statistics before and
> > > > after
> > > > your patch.
> > > > My guts tell me that the result will be not in the favour of
> > > > yours
> > > > solution.
> > > =

> > > Can you please tell me what type of stats you hope to see? I can
> > > try
> > > generating what you are after. The cover letter contained typical
> > > +/-
> > > change stats from git and summary:
> > > =

> > > 62 files changed, 228 insertions(+), 104 deletions(-)
> > =

> > I guess he wants to see
> > =

> > 	scripts/bloat-o-meter vmlinuz.old vmlinuz
> > =

> > . I would expect a 0 there. I didn't look in detail, but in general I
> > like the idea to give 0 and 1 a symbolic name.
> =

> Thanks Uwe. This far I have only cross-compiled the series for arm
> which I use for developing the ROHM PMICs. scripts/bloat-o-meter /
> tools it uses does not seem to recognize the image format (not a big
> surprize as my host is x86_64).

It works for me, I guess that's because my binutils support several
architectures:

	$ nm --help
	...
	nm: supported targets: elf64-x86-64 elf32-i386 elf32-iamcu elf32-x86-64
	pei-i386 pei-x86-64 elf64-l1om elf64-k1om elf64-little elf64-big
	elf32-little elf32-big elf64-littleaarch64 elf64-bigaarch64
	elf32-littleaarch64 elf32-bigaarch64 elf32-littlearm elf32-bigarm
	elf64-alpha ecoff-littlealpha elf32-littlearm-fdpic elf32-bigarm-fdpic
	elf32-hppa-linux elf32-hppa elf64-ia64-little elf64-ia64-big pei-ia64
	elf32-m32r-linux elf32-m32rle-linux elf32-m68k elf32-tradbigmips
	elf32-tradlittlemips ecoff-bigmips ecoff-littlemips elf32-ntradbigmips
	elf64-tradbigmips elf32-ntradlittlemips elf64-tradlittlemips
	elf32-powerpc aixcoff-rs6000 elf32-powerpcle ppcboot elf64-powerpc
	elf64-powerpcle aixcoff64-rs6000 aix5coff64-rs6000 elf64-littleriscv
	elf32-littleriscv elf32-s390 elf64-s390 elf32-sh-linux elf32-shbig-linux
	elf32-sh-fdpic elf32-shbig-fdpic elf32-sparc elf64-sparc pe-x86-64
	pe-bigobj-x86-64 pe-i386 plugin srec symbolsrec verilog tekhex binary
	ihex

(added line breaks for easier reading). I got this by installing
binutils-multiarch (on Debian).

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
