From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] updated mach-types file
Date: Thu, 22 Oct 2009 13:54:05 -0700
Message-ID: <20091022205405.GU16230@atomide.com>
References: <1256173554-20196-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52022 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbZJVUyD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 16:54:03 -0400
Content-Disposition: inline
In-Reply-To: <1256173554-20196-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org

* Vikram Pandita <vikram.pandita@ti.com> [091021 18:07]:
> this patch updates the auto-generated mach-types file
> to enable addition of 3630 boards:
> 1) zoom3
> 2) sdp3630
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
> Tony:
> Could you Temporarily host this patch on linux-omap tree till
> rmk pulls in mach-types.
> This would allow us to add 3630 board files

How about only add the lines needed? I can put it into omap-testing
branch then.

Tony
 
>  arch/arm/tools/mach-types |   54 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 53 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 94be7bb..0160378 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -12,7 +12,7 @@
>  #
>  #   http://www.arm.linux.org.uk/developer/machines/?action=new
>  #
> -# Last update: Fri Sep 18 21:42:00 2009
> +# Last update: Wed Oct 21 15:33:08 2009
>  #
>  # machine_is_xxx	CONFIG_xxxx		MACH_TYPE_xxx		number
>  #
> @@ -2421,3 +2421,55 @@ liberty			MACH_LIBERTY		LIBERTY			2434
>  mh355			MACH_MH355		MH355			2435
>  pc7802			MACH_PC7802		PC7802			2436
>  gnet_sgc		MACH_GNET_SGC		GNET_SGC		2437
> +einstein15		MACH_EINSTEIN15		EINSTEIN15		2438
> +cmpd			MACH_CMPD		CMPD			2439
> +davinci_hase1		MACH_DAVINCI_HASE1	DAVINCI_HASE1		2440
> +lgeincitephone		MACH_LGEINCITEPHONE	LGEINCITEPHONE		2441
> +ea313x			MACH_EA313X		EA313X			2442
> +fwbd_39064		MACH_FWBD_39064		FWBD_39064		2443
> +fwbd_390128		MACH_FWBD_390128	FWBD_390128		2444
> +pelco_moe		MACH_PELCO_MOE		PELCO_MOE		2445
> +minimix27		MACH_MINIMIX27		MINIMIX27		2446
> +omap3_thunder		MACH_OMAP3_THUNDER	OMAP3_THUNDER		2447
> +passionc		MACH_PASSIONC		PASSIONC		2448
> +mx27amata		MACH_MX27AMATA		MX27AMATA		2449
> +bgat1			MACH_BGAT1		BGAT1			2450
> +buzz			MACH_BUZZ		BUZZ			2451
> +mb9g20			MACH_MB9G20		MB9G20			2452
> +yushan			MACH_YUSHAN		YUSHAN			2453
> +lizard			MACH_LIZARD		LIZARD			2454
> +omap3polycom		MACH_OMAP3POLYCOM	OMAP3POLYCOM		2455
> +smdkv210		MACH_SMDKV210		SMDKV210		2456
> +bravo			MACH_BRAVO		BRAVO			2457
> +siogentoo1		MACH_SIOGENTOO1		SIOGENTOO1		2458
> +siogentoo2		MACH_SIOGENTOO2		SIOGENTOO2		2459
> +sm3k			MACH_SM3K		SM3K			2460
> +acer_tempo_f900		MACH_ACER_TEMPO_F900	ACER_TEMPO_F900		2461
> +sst61vc010_dev		MACH_SST61VC010_DEV	SST61VC010_DEV		2462
> +glittertind		MACH_GLITTERTIND	GLITTERTIND		2463
> +omap_zoom3		MACH_OMAP_ZOOM3		OMAP_ZOOM3		2464
> +omap_3630sdp		MACH_OMAP_3630SDP	OMAP_3630SDP		2465
> +cybook2440		MACH_CYBOOK2440		CYBOOK2440		2466
> +torino_s		MACH_TORINO_S		TORINO_S		2467
> +havana			MACH_HAVANA		HAVANA			2468
> +beaumont_11		MACH_BEAUMONT_11	BEAUMONT_11		2469
> +vanguard		MACH_VANGUARD		VANGUARD		2470
> +s5pc110_draco		MACH_S5PC110_DRACO	S5PC110_DRACO		2471
> +cartesio_two		MACH_CARTESIO_TWO	CARTESIO_TWO		2472
> +aster			MACH_ASTER		ASTER			2473
> +voguesv210		MACH_VOGUESV210		VOGUESV210		2474
> +acm500x			MACH_ACM500X		ACM500X			2475
> +km9260			MACH_KM9260		KM9260			2476
> +nideflexg1		MACH_NIDEFLEXG1		NIDEFLEXG1		2477
> +ctera_plug_io		MACH_CTERA_PLUG_IO	CTERA_PLUG_IO		2478
> +smartq7			MACH_SMARTQ7		SMARTQ7			2479
> +at91sam9g10ek2		MACH_AT91SAM9G10EK2	AT91SAM9G10EK2		2480
> +asusp527		MACH_ASUSP527		ASUSP527		2481
> +at91sam9g20mpm2		MACH_AT91SAM9G20MPM2	AT91SAM9G20MPM2		2482
> +topasa900		MACH_TOPASA900		TOPASA900		2483
> +electrum_100		MACH_ELECTRUM_100	ELECTRUM_100		2484
> +mx51grb			MACH_MX51GRB		MX51GRB			2485
> +xea300			MACH_XEA300		XEA300			2486
> +htcstartrek		MACH_HTCSTARTREK	HTCSTARTREK		2487
> +lima			MACH_LIMA		LIMA			2488
> +csb740			MACH_CSB740		CSB740			2489
> -- 
> 1.6.5.rc1.19.g8426
> 
