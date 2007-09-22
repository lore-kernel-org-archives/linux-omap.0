From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [RFC] To fix 3430 Compilation broken due to PRCM changes
Date: Sat, 22 Sep 2007 12:40:38 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0709221238440.27275@utopia.booyaka.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701D27E3A@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701D27E3A@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 22 Sep 2007, Syed Mohammed, Khasim wrote:

> Hi Paul,
>
> Due to the recent merges the OMAP3430 compilation breaks. To fix this for now:
>
> Option 1:
> =========
> +++ linux-omap/arch/arm/mach-omap2/prcm.c  2007-09-22
> void omap_prcm_arch_reset(char mode)
> {
>        u32 wkup;
> + #ifdef CONFIG_ARCH_OMAP2
>        omap2_clk_prepare_for_reboot();
> + #endif
>        wkup = prm_read_mod_reg(WKUP_MOD, RM_RSTCTRL) | OMAP_RST_DPLL3;
>
> Option 2:
> =========
> +++ linux-omap/arch/arm/mach-omap2/Makefile  2007-09-22 08:44:15.000000000 -0500
> @@ -13,6 +13,7 @@ obj-$(CONFIG_PM) += pm.o sleep.o
>
> # Clock framework
> obj-$(CONFIG_ARCH_OMAP2)               += clock24xx.o
> +obj-$(CONFIG_ARCH_OMAP3)               += clock24xx.o
>
> # DSP
> obj-$(CONFIG_OMAP_MMU_FWK)     += mmu_mach.o
>
> Let me know your preference, I can post a patch for the same.

Hi Khasim,

thanks for the catch - I would suggest option #1 for the time being - we 
will be able to drop it once the 3430 clock tree patches are merged.

- Paul
