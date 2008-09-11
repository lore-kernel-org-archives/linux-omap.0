From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.27-rc6-omap1] mach-omap2:  fix more arch_initcall()
	breakage
Date: Thu, 11 Sep 2008 11:23:32 -0700
Message-ID: <20080911182331.GL21163@atomide.com>
References: <200809102301.25422.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63566 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbYIKSXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 14:23:36 -0400
Content-Disposition: inline
In-Reply-To: <200809102301.25422.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080910 23:01]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Remove more bogus arch_initcall() logic in mach-omap2/board-xyx.c files.
> They broke a multi-OMAP build I did, at *RUN TIME* not build time, since
> it tried to do the i2c init for every board linked in the kernel.
> 
> Remember, init_machine() entries run at arch_initcall() time; that's
> where any board-specific init logic should normally go.  Any initcalls
> in the mach-*/*c files should normally be guarded by tests to make sure
> they only run on the relevant hardware (board, cpu).  Better yet, get
> rid of the initcalls; init_machine() can *explicitly* call the right
> version of that code, and pass in board-specific config data; and there
> are hooks that can handle cpu-specific stuff too.
> 
> A quick glance suggests most of the remaining initcall logic in the
> mach-omap2 directory is similarly broken... this patch gets rid of
> one frequently-cloned idiom, it should help.

Thanks, one step closer to getting the multi-omap properly working
for mach-omap2. Will push today.

Tony

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c  |    4 ++--
>  arch/arm/mach-omap2/board-3430sdp.c  |    2 +-
>  arch/arm/mach-omap2/board-ldp.c      |    2 +-
>  arch/arm/mach-omap2/board-omap2evm.c |    4 ++--
>  arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -392,6 +392,8 @@ static int __init omap2430_i2c_init(void
>  
>  static void __init omap_2430sdp_init(void)
>  {
> +	omap2430_i2c_init();
> +
>  	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
>  	omap_board_config = sdp2430_config;
>  	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
> @@ -416,8 +418,6 @@ static void __init omap_2430sdp_map_io(v
>  	omap2_map_common_io();
>  }
>  
> -arch_initcall(omap2430_i2c_init);
> -
>  MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
>  	/* Maintainer: Syed Khasim - Texas Instruments Inc */
>  	.phys_io	= 0x48000000,
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -354,6 +354,7 @@ extern void __init sdp3430_flash_init(vo
>  
>  static void __init omap_3430sdp_init(void)
>  {
> +	omap3430_i2c_init();
>  	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
>  	omap_board_config = sdp3430_config;
>  	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
> @@ -378,7 +379,6 @@ static void __init omap_3430sdp_map_io(v
>  	omap2_set_globals_343x();
>  	omap2_map_common_io();
>  }
> -arch_initcall(omap3430_i2c_init);
>  
>  MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
>  	/* Maintainer: Syed Khasim - Texas Instruments Inc */
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -223,6 +223,7 @@ static int __init omap_i2c_init(void)
>  
>  static void __init omap_ldp_init(void)
>  {
> +	omap_i2c_init();
>  	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
>  	omap_board_config = ldp_config;
>  	omap_board_config_size = ARRAY_SIZE(ldp_config);
> @@ -242,7 +243,6 @@ static void __init omap_ldp_map_io(void)
>  	omap2_set_globals_343x();
>  	omap2_map_common_io();
>  }
> -arch_initcall(omap_i2c_init);
>  
>  MACHINE_START(OMAP_LDP, "OMAP LDP board")
>  	.phys_io	= 0x48000000,
> --- a/arch/arm/mach-omap2/board-omap2evm.c
> +++ b/arch/arm/mach-omap2/board-omap2evm.c
> @@ -261,6 +261,8 @@ static struct platform_device *omap2_evm
>  
>  static void __init omap2_evm_init(void)
>  {
> +	omap2_evm_i2c_init();
> +
>  	platform_add_devices(omap2_evm_devices, ARRAY_SIZE(omap2_evm_devices));
>  	omap_board_config = omap2_evm_config;
>  	omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
> @@ -275,8 +277,6 @@ static void __init omap2_evm_map_io(void
>  	omap2_map_common_io();
>  }
>  
> -arch_initcall(omap2_evm_i2c_init);
> -
>  MACHINE_START(OMAP2EVM, "OMAP2EVM Board")
>  	/* Maintainer:  Arun KS <arunks@mistralsolutions.com> */
>  	.phys_io	= 0x48000000,
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -223,6 +223,8 @@ static struct platform_device *omap3_evm
>  
>  static void __init omap3_evm_init(void)
>  {
> +	omap3_evm_i2c_init();
> +
>  	platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
>  	omap_board_config = omap3_evm_config;
>  	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
> @@ -238,8 +240,6 @@ static void __init omap3_evm_init(void)
>  	ads7846_dev_init();
>  }
>  
> -arch_initcall(omap3_evm_i2c_init);
> -
>  static void __init omap3_evm_map_io(void)
>  {
>  	omap2_set_globals_343x();
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
