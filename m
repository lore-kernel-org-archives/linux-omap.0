From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 5/6] OMAP3: Serial: Made serial to work properly with
 PRCM chain handler
Date: Thu, 23 Jun 2011 01:21:50 -0700
Message-ID: <20110623082150.GX23145@atomide.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
 <1308760934-9757-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39051 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753078Ab1FWIVw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 04:21:52 -0400
Content-Disposition: inline
In-Reply-To: <1308760934-9757-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [110622 09:38]:
> @@ -550,6 +550,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  	ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
>  				   IRQF_SHARED, "serial idle", (void *)uart);
>  	WARN_ON(ret);
> +	ret = omap_prcm_register_pad_irq(uart->padconf, uart->irq);
> +	WARN_ON(ret);
>  }

Argh, looks like we still have direct mux register tinkering in serial.c:

$ grep "padconf = 0x" serial.c
                        padconf = 0x182;
                        padconf = 0x17a;
                        padconf = 0x19e;
                        padconf = 0x0d2;

By deducting 0x30 from the values above, these map into the following mux defines:

$ grep RX_OFFSET mux34xx.h
#define OMAP3_CONTROL_PADCONF_UART2_RX_OFFSET                   0x14a
#define OMAP3_CONTROL_PADCONF_UART1_RX_OFFSET                   0x152
#define OMAP3_CONTROL_PADCONF_UART3_RX_IRRX_OFFSET              0x16e

So you can make things more generic by getting rid of those and using
struct omap_mux_partition instead for omap_prcm_register_pad_irq.
The pins used are set already in serial.c with omap_hwmod_mux_init.

Otherwise we have to patch the hardcoded padconf values for every new omap.
And looks like we're already missing them for 44xx in serial.c.

Then access to the padconf registers should be done with
omap_mux_read/write instead. If you need to do something more complex
with them maybe consider adding some new functions to mux.c as needed.

Regards,

Tony
