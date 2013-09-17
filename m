From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP2: Make MACH_OMAP3EVM select NOP_USB_XCEIV
Date: Tue, 17 Sep 2013 16:40:22 -0700
Message-ID: <20130917234021.GO9994@atomide.com>
References: <20130904133850.GC12834@hansolo.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130904133850.GC12834@hansolo.jdub.homelinux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Boyer <jwboyer@redhat.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Josh Boyer <jwboyer@redhat.com> [130904 06:46]:
> The board-omap3evm.c file unconditionally calls usb_nop_xceiv_register but
> doesn't ensure this is built-in.  This can lead to build failures like:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap3_evm_init':
> linux-3.12.0-0.rc0.git2.1.fc21.armv7hl/arch/arm/mach-omap2/board-omap3evm.c:686: undefined reference to `usb_nop_xceiv_register'
> make: *** [vmlinux] Error 1
> 
> Make MACH_OMAP3EVM select NOP_USB_XCEIV to avoid this.
> 
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> ---
>  arch/arm/mach-omap2/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 3eed000..3350389 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -258,6 +258,7 @@ config MACH_OMAP3EVM
>  	depends on ARCH_OMAP3
>  	default y
>  	select OMAP_PACKAGE_CBB
> +	select NOP_USB_XCEIV
>  
>  config MACH_OMAP3517EVM
>  	bool "OMAP3517/ AM3517 EVM board"

I think we should rather have the code in board-omap3evm.c
to be ifdef CONFIG_NOP_USB_XCEIV as it's a selectable option.

Regards,

Tony
