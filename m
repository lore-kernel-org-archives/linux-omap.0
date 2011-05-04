From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH 1/4] omap: consolidate touch screen initialization among different boards
Date: Tue, 3 May 2011 23:10:29 -0400
Message-ID: <D9D18474-D2A3-468B-88B3-2D18537E70D2@linuxhacker.ru>
References: <cover.1303682352.git.mike@compulab.co.il> <1738251a50b70224f124d4a54c157cc5e3c6db77.1303682352.git.mike@compulab.co.il>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:33762 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360Ab1EDDKy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 23:10:54 -0400
In-Reply-To: <1738251a50b70224f124d4a54c157cc5e3c6db77.1303682352.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello!

This patch breaks compile for me.

On Apr 24, 2011, at 6:09 PM, Mike Rapoport wrote:

> --- /dev/null
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -0,0 +1,85 @@
> 
> +void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
> +			      struct ads7846_platform_data *board_pdata)
> +{
> ...

> +}
> diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
> new file mode 100644
> index 0000000..75f9248d
> --- /dev/null
> +++ b/arch/arm/mach-omap2/common-board-devices.h
> @@ -0,0 +1,18 @@
> +#ifndef __OMAP_COMMON_BOARD_DEVICES__
> +#define __OMAP_COMMON_BOARD_DEVICES__
> +
> +#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
> +	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
> +struct ads7846_platform_data;
> +
> +void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
> +		       struct ads7846_platform_data *board_pdata);
> +#else


arch/arm/mach-omap2/common-board-devices.c:80: error: redefinition of 'omap_ads7846_init'
arch/arm/mach-omap2/common-board-devices.h:36: note: previous definition of 'omap_ads7846_init' was here

Of course I don't have the CONFIG_TOUCHSCREEN_ADS7846 defined.

Bye,
    Oleg