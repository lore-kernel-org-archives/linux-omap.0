From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v7 1/3] Documentation: common clk API
Date: Sat, 17 Mar 2012 21:29:31 +0100
Message-ID: <20120317202931.GN3852@pengutronix.de>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
	<alpine.DEB.2.00.1203161509470.4395@utopia.booyaka.com>
	<CAJOA=zPmy7Dwzw8EOCW_+cvy2Dv=w0TPUq7Zg_s=Y0rs+v+u2w@mail.gmail.com>
	<201203170905.33191.arnd@arndb.de>
	<CAJOA=zNVSWR6xZEfx4hioB-Q7M6PsrP9gdvJc1t+YN=QVE=83w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJOA=zNVSWR6xZEfx4hioB-Q7M6PsrP9gdvJc1t+YN=QVE=83w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: "Turquette, Mike" <mturquette-l0cyMroinI0@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Saravana Kannan <skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jeremy Kerr <jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 17, 2012 at 11:02:11AM -0700, Turquette, Mike wrote:
> On Sat, Mar 17, 2012 at 2:05 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > On Friday 16 March 2012, Turquette, Mike wrote:
> >> On Fri, Mar 16, 2012 at 3:21 PM, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org> wrote:
> >> > From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> >> > Date: Fri, 16 Mar 2012 16:06:30 -0600
> >> > Subject: [PATCH] clk: mark the common clk code as EXPERIMENTAL for n=
ow
> >> >
> >> > Mark the common clk code as depending on CONFIG_EXPERIMENTAL. =A0The=
 API
> >> > is not well-defined and both it and the underlying mechanics are lik=
ely
> >> > to need significant changes to support non-trivial uses of the rate
> >> > changing code, such as DVFS with external I/O devices. =A0So any pla=
tforms
> >> > that switch their implementation over to this may need to revise much
> >> > of their driver code and revalidate their implementations until the
> >> > behavior of the code is better-defined.
> >> >
> >> > A good time for removing this EXPERIMENTAL designation would be afte=
r at
> >> > least two platforms that do DVFS on groups of external I/O devices h=
ave
> >> > ported their clock implementations over to the common clk code.
> >> >
> >> > Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> >> > Cc: Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>
> >>
> >> ACK. =A0This will set some reasonable expectations while things are in=
 flux.
> >>
> >> Arnd are you willing to take this in?
> >
> > I think it's rather pointless, because the option is not going to
> > be user selectable but will get selected by the platform unless I'm
> > mistaken. The platform maintainers that care already know the state
> > of the framework. Also, there are no user space interfaces that we
> > have to warn users about not being stable, because the framework
> > is internal to the kernel.
> =

> The consensus seems to be to not set experimental.
> =

> > However, I wonder whether we need the patch below to prevent
> > users from accidentally enabling COMMON_CLK on platforms that
> > already provide their own implementation.
> >
> > =A0 =A0 =A0 =A0Arnd
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 2eaf17e..a0a83de 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -12,7 +12,7 @@ config HAVE_MACH_CLKDEV
> >
> > =A0menuconfig COMMON_CLK
> > - =A0 =A0 =A0 bool "Common Clock Framework"
> > + =A0 =A0 =A0 bool
> > =A0 =A0 =A0 =A0select HAVE_CLK_PREPARE
> > =A0 =A0 =A0 =A0---help---
> > =A0 =A0 =A0 =A0 =A0The common clock framework is a single definition of=
 struct
> > =A0 =A0 =A0 =A0 =A0clk, useful across many platforms, as well as an
> =

> Much like experimental I'm not sure how needed this change is.  The
> help section does say to leave it disabled by default, if unsure.  If
> you merge it I won't object but this might be fixing an imaginary
> problem.

Architectures without common clock support won't build with this option
enabled (multiple definition of clk_enable etc), so I think this should
not be user visible.

Sascha

-- =

Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
