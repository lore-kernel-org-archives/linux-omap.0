From: "Kyungmin Park" <kmpark@infradead.org>
Subject: Re: [RFC][PATCH] ARM: OMAP: Always enable the R/W access to all
	initiators in sram
Date: Tue, 27 Nov 2007 15:35:46 +0900
Message-ID: <9c9fda240711262235y22d45576n8469fa24790fc028@mail.gmail.com>
References: <20071126020738.GA32424@party>
	<Pine.LNX.4.64.0711260348500.2694@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <Pine.LNX.4.64.0711260348500.2694@utopia.booyaka.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@booyaka.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Yes, we should read the OMAP24XX_CONTROL_STATUS instead of
CONTROL_STATUS. and also we must fix following line.

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index dd8dc04..71d953f 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -92,9 +92,9 @@ static int is_sram_locked(void)
 {
        int type = 0;

-#if defined(CONFIG_ARCH_OMAP242X)
+#if defined(CONFIG_ARCH_OMAP24XX)
        if (cpu_is_omap242x())
-               type = ctrl_read_reg(CONTROL_STATUS) & TYPE_MASK;
+               type = ctrl_read_reg(OMAP24XX_CONTROL_STATUS) & TYPE_MASK;
 #endif

        if (type == GP_DEVICE) {

There's no configuration ARCH_OMAP242X. :)
I'm not sure is it thre right to check cpu_is_omap242x()? or cpu_is_omap24xx()?

After your patch commits, I will send the patch.

Thank you,
Kyungmin Park


On 11/26/07, Paul Walmsley <paul@booyaka.com> wrote:
> Hello Kyungmin,
>
> On Mon, 26 Nov 2007, Kyungmin Park wrote:
>
> > With recent runtime constatns patches, we can't boot the board if the sram is locked.
> > I'm not sure it's the proper patch enables R/W access to all omap242x.
> > But without this patch, it gives the following messages and abort on linefecth
>
> I am puzzled.
>
> You have definitely found a bug.  It seems that TI, for some unknown
> reason, moved some SCM registers, including CONTROL_STATUS, for 34xx,
> breaking forward compatibility.  And as you point out, the offset for
> CONTROL_STATUS in the recent patch is not right for 242x.  (It's the
> 34xx offset.)
>
> I would think this would prevent 242x from booting.  Indeed, you report
> that your setup doesn't boot.  But when I boot current git on N800 here,
> which is 2420-based, it boots fine.  Puzzling evidence.
>
> Anyway, a test patch is below, for the CONTROL_STATUS register issue.
> (Not for git consumption - just for testing.)  Could you try it to see if
> it fixes the problems that you're seeing?  If not, perhaps something else
> is wrong.
>
> Regards,
>
> - Paul
>
>
> ---
>  arch/arm/mach-omap2/board-h4.c      |    2 +-
>  arch/arm/mach-omap2/id.c            |   10 +++++++++-
>  arch/arm/plat-omap/sram.c           |    2 +-
>  include/asm-arm/arch-omap/control.h |    3 ++-
>  4 files changed, 13 insertions(+), 4 deletions(-)
>
> Index: linux-omap/arch/arm/mach-omap2/board-h4.c
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/board-h4.c      2007-11-26 03:13:50.000000000 -0700
> +++ linux-omap/arch/arm/mach-omap2/board-h4.c   2007-11-26 03:28:30.000000000 -0700
> @@ -272,7 +272,7 @@
>  /* 2420 Sysboot setup (2430 is different) */
>  static u32 get_sysboot_value(void)
>  {
> -       return (ctrl_read_reg(CONTROL_STATUS) & 0xFFF);
> +       return (ctrl_read_reg(OMAP24XX_CONTROL_STATUS) & 0xFFF);
>  }
>
>  /* FIXME: This function should be moved to some other file, gpmc.c? */
> Index: linux-omap/arch/arm/mach-omap2/id.c
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/id.c    2007-11-26 03:13:50.000000000 -0700
> +++ linux-omap/arch/arm/mach-omap2/id.c 2007-11-26 03:35:27.000000000 -0700
> @@ -162,7 +162,15 @@
>        /* Embedding the ES revision info in type field */
>        system_rev = omap_ids[j].type;
>
> -       ctrl_status = ctrl_read_reg(CONTROL_STATUS);
> +       if (cpu_is_omap24xx()) {
> +               i = OMAP24XX_CONTROL_STATUS;
> +       } else if (cpu_is_omap343x()) {
> +               i = OMAP343X_CONTROL_STATUS;
> +       } else {
> +               printk(KERN_ERR "id: unknown CPU type\n");
> +               BUG();
> +       }
> +       ctrl_status = ctrl_read_reg(i);
>        system_rev |= (ctrl_status & 0x3f);
>        system_rev |= (ctrl_status & 0x700);
>
> Index: linux-omap/include/asm-arm/arch-omap/control.h
> ===================================================================
> --- linux-omap.orig/include/asm-arm/arch-omap/control.h 2007-11-26 03:13:50.000000000 -0700
> +++ linux-omap/include/asm-arm/arch-omap/control.h      2007-11-26 03:28:30.000000000 -0700
> @@ -37,7 +37,8 @@
>
>  #define CONTROL_DEVCONF0               (CONTROL_GENERAL + 0x04)
>  #define CONTROL_DEVCONF1               (CONTROL_GENERAL + 0x68) /* > 242x */
> -#define CONTROL_STATUS                 (CONTROL_GENERAL + 0x80)
> +#define OMAP343X_CONTROL_STATUS                (CONTROL_GENERAL + 0x80)
> +#define OMAP24XX_CONTROL_STATUS                (CONTROL_GENERAL + 0x88)
>
>
>  /*
> Index: linux-omap/arch/arm/plat-omap/sram.c
> ===================================================================
> --- linux-omap.orig/arch/arm/plat-omap/sram.c   2007-11-26 03:13:50.000000000 -0700
> +++ linux-omap/arch/arm/plat-omap/sram.c        2007-11-26 03:28:30.000000000 -0700
> @@ -94,7 +94,7 @@
>
>  #if defined(CONFIG_ARCH_OMAP242X)
>        if (cpu_is_omap242x())
> -               type = ctrl_read_reg(CONTROL_STATUS) & TYPE_MASK;
> +               type = ctrl_read_reg(OMAP24XX_CONTROL_STATUS) & TYPE_MASK;
>  #endif
>
>        if (type == GP_DEVICE) {
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
