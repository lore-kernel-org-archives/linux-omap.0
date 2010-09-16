From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/6] TI816X: Update common omap platform files
Date: Thu, 16 Sep 2010 15:30:38 -0700
Message-ID: <20100916223037.GT29610@atomide.com>
References: <1281546658-11437-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55859 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676Ab0IPWan (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 18:30:43 -0400
Content-Disposition: inline
In-Reply-To: <1281546658-11437-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

* Hemant Pedanekar <hemantp@ti.com> [100811 10:03]:
> --- a/arch/arm/plat-omap/include/plat/serial.h
> +++ b/arch/arm/plat-omap/include/plat/serial.h
> @@ -51,6 +51,11 @@
>  #define OMAP4_UART3_BASE	0x48020000
>  #define OMAP4_UART4_BASE	0x4806e000
>  
> +/* TI816X serial ports */
> +#define TI816X_UART1_BASE	0x48020000
> +#define TI816X_UART2_BASE	0x48022000
> +#define TI816X_UART3_BASE	0x48024000
> +
>  /* External port on Zoom2/3 */
>  #define ZOOM_UART_BASE		0x10000000
>  #define ZOOM_UART_VIRT		0xfa400000

These defines should get added by the serial port patch
in the series, currently 6/6.

Tony
