From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap clean-up for v3.1 merge window
Date: Thu, 30 Jun 2011 13:25:02 +0200
Message-ID: <201106301325.02204.arnd@arndb.de>
References: <20110630091019.GJ23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110630091019.GJ23145@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

On Thursday 30 June 2011, Tony Lindgren wrote:
> Hi Arnd & Nico,
> 
> Please pull omap clean-up patches from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-cleanup
> 
> This branch contains little bit more of omap code shrinkage
> for regulators and PM debug.
> 
> It also contains cleanup of irq and timer init code, and some
> fixes.

Hi Tony,

The cleanups all look great, with one exception (see below). In the
future, I'd prefer to get separate pull requests for cleanups and
bug fixes, but no need to worry about it this time.

> I have not added this into linux next assuming that you will
> do it. If not, please let me know and I will add it.

Right, I'll ask Stephen to add the master branch of the arm-soc
tree to linux-next soon, after I've made sure that there are no
conflicts with existing branches that get merged there.

For our upstream submission, my preference would be to send them
piecemeal to Linus and group them across the branches as
appropriate.

>       omap: Set separate timer init functions to avoid cpu_is_omap tests

This commit causes a build regression for me in some configurations.
If you agree, I'd apply this patch on top:

8<-------
omap2+: fix build regression

board-generic.c now contains a reference to omap3_timer, but depends only
on ARCH_OMAP2, not on ARCH_OMAP3, which controls that symbol.
omap2_timer seems to be more appropriate anyway, so use that instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -72,5 +72,5 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
        .init_early     = omap_generic_init_early,
        .init_irq       = omap2_init_irq,
        .init_machine   = omap_generic_init,
-       .timer          = &omap3_timer,
+       .timer          = &omap2_timer,
 MACHINE_END
