From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
Date: Fri, 8 Apr 2016 12:06:00 +0200
Message-ID: <20160408100600.GI1668@linux-mips.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20160408003328.GA14441@codeaurora.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Greg Ungerer <gerg@uclinux.org>, Ryan Mallon <rmallon@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Simon Horman <horms@verge.net.au>, Wan ZongShun <mcuos.com@gmail.com>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, adi-buildroot-devel@lists.sourceforge.net, Russell King <linux@arm.linux.org.uk>, linux-m68k@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vg
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 07, 2016 at 05:33:28PM -0700, Stephen Boyd wrote:

> On 04/05, Masahiro Yamada wrote:
> > The clk_disable() in the common clock framework (drivers/clk/clk.c)
> > returns immediately if a given clk is NULL or an error pointer.  It
> > allows clock consumers to call clk_disable() without IS_ERR_OR_NULL
> > checking if drivers are only used with the common clock framework.
> > 
> > Unfortunately, NULL/error checking is missing from some of non-common
> > clk_disable() implementations.  This prevents us from completely
> > dropping NULL/error checking from callers.  Let's make it tree-wide
> > consistent by adding IS_ERR_OR_NULL(clk) to all callees.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Acked-by: Greg Ungerer <gerg@uclinux.org>
> > Acked-by: Wan Zongshun <mcuos.com@gmail.com>
> > ---
> > 
> > Stephen,
> > 
> > This patch has been unapplied for a long time.
> > 
> > Please let me know if there is something wrong with this patch.
> > 
> 
> I'm mostly confused why we wouldn't want to encourage people to
> call clk_disable or unprepare on a clk that's an error pointer.
> Typically an error pointer should be dealt with, instead of
> silently ignored, so why wasn't it dealt with by passing it up
> the probe() path?

While your argument makes perfect sense, Many clk_disable implementations
are already doing similar checks, for example:

arch/arm/mach-davinci/clock.c:

void clk_disable(struct clk *clk)
{
	unsigned long flags;

	if (clk == NULL || IS_ERR(clk))
		return;
[...]

arch/arm/mach-omap1/clock.c

void clk_disable(struct clk *clk)
{
        unsigned long flags;

        if (clk == NULL || IS_ERR(clk))
                return;
[...]

arch/avr32/mach-at32ap/clock.c

void clk_disable(struct clk *clk)
{
        unsigned long flags;

        if (IS_ERR_OR_NULL(clk))
                return;
[...]

arch/mips/lantiq/clk.c:

static inline int clk_good(struct clk *clk)
{
	return clk && !IS_ERR(clk);
}

[...]

void clk_disable(struct clk *clk)
{
	if (unlikely(!clk_good(clk)))
		return;

	if (clk->disable)
[...]

So should we go and weed out these checks?

  Ralf
