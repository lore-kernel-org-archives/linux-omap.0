From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v7 1/3] Documentation: common clk API
Date: Sat, 17 Mar 2012 21:13:30 +0000
Message-ID: <201203172113.31122.arnd@arndb.de>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
	<CAJOA=zNVSWR6xZEfx4hioB-Q7M6PsrP9gdvJc1t+YN=QVE=83w@mail.gmail.com>
	<20120317202931.GN3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20120317202931.GN3852-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Saravana Kannan <skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jeremy Kerr <jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Saturday 17 March 2012, Sascha Hauer wrote:
> On Sat, Mar 17, 2012 at 11:02:11AM -0700, Turquette, Mike wrote:
> >
> > Much like experimental I'm not sure how needed this change is.  The
> > help section does say to leave it disabled by default, if unsure.  If
> > you merge it I won't object but this might be fixing an imaginary
> > problem.
> 
> Architectures without common clock support won't build with this option
> enabled (multiple definition of clk_enable etc), so I think this should
> not be user visible.

I've applied this patch now.

	Arnd

commit c173033d154e9792b1b5059783b802f82536d48f
Author: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Date:   Sat Mar 17 21:10:51 2012 +0000

    clk: make CONFIG_COMMON_CLK invisible
    
    All platforms that use the common clk infrastructure should select
    COMMON_CLK from platform code, and on all other platforms, it must
    not be enabled, so there is no point making the option visible to
    users, and when it is visible, we break randconfig builds.
    
    Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 2eaf17e..82bcfbd 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -10,18 +10,14 @@ config HAVE_MACH_CLKDEV
 	bool
 
 menuconfig COMMON_CLK
-	bool "Common Clock Framework"
+	bool
 	select HAVE_CLK_PREPARE
 	---help---
 	  The common clock framework is a single definition of struct
 	  clk, useful across many platforms, as well as an
 	  implementation of the clock API in include/linux/clk.h.
 	  Architectures utilizing the common struct clk should select
-	  this automatically, but it may be necessary to manually select
-	  this option for loadable modules requiring the common clock
-	  framework.
-
-	  If in doubt, say "N".
+	  this option.
 
 if COMMON_CLK
