From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/2] OMAP1/2/3/4: DEBUG_LL run time detection
Date: Sat, 19 Sep 2009 11:05:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BABA34A4@dbde02.ent.ti.com>
References: <1253320780-19396-1-git-send-email-vikram.pandita@ti.com>
 <1253320780-19396-2-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48946 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbZISFgK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Sep 2009 01:36:10 -0400
In-Reply-To: <1253320780-19396-2-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>

Vikram,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> Sent: Saturday, September 19, 2009 6:10 AM
> To: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Cc: Pandita, Vikram; Russell King; Kevin Hilman
> Subject: [PATCH 1/2] OMAP1/2/3/4: DEBUG_LL run time detection


> +u32 get_uart_base(void)
> +{
> +	static u32  omap_uart_debug_ll_phy_addr;
> +
> +	if (omap_uart_debug_ll_phy_addr)
> +		return omap_uart_debug_ll_phy_addr;
> +
> +	/* Add logic here for new platforms, using __machine_arch_type */
> +
> +	/* TODO: REVISIT -- Check Completeness
> +	 * DEFINE PHY ADDRESS for EACH BOARD HERE: omap1/2/3/4 */
> +#if defined(CONFIG_ARCH_OMAP1)
> +	switch (__machine_arch_type) {
> +	case MACH_TYPE_OMAP_PALMTT:
> +	case MACH_TYPE_SX1:
> +		/* UART2 */
> +		omap_uart_debug_ll_phy_addr = (u32 *)0xfffb0800;
> +	break;
> +	default:
> +			/* UART1 */
> +		omap_uart_debug_ll_phy_addr = (u32 *)0xfffb0000;
> +	break;
> +	}
> +#endif
> +
> +#if defined(CONFIG_ARCH_OMAP2)
> +	switch (__machine_arch_type) {
> +	case MACH_TYPE_NOKIA_N800:
> +	case MACH_TYPE_NOKIA_N810:
> +	case MACH_TYPE_NOKIA_N810_WIMAX:
> +		/* UART3 */
> +		omap_uart_debug_ll_phy_addr = (u32 *)0x4806e000;
> +	break;
> +	default:
> +		/* UART1 */
> +		omap_uart_debug_ll_phy_addr = (u32 *)0x4806a000;
> +	break;
> +	}
> +#endif
> +
> +#if defined(CONFIG_ARCH_OMAP3)
> +	switch (__machine_arch_type) {
> +	case MACH_TYPE_OMAP_LDP:
> +	case MACH_TYPE_OVERO:
> +	case MACH_TYPE_OMAP3_PANDORA:
> +	case MACH_TYPE_NOKIA_RX51:
> +	case MACH_TYPE_OMAP3_BEAGLE:
> +		/* UART3 */
> +		omap_uart_debug_ll_phy_addr = 0x49020000;
> +	break;
> +	case MACH_TYPE_OMAP_ZOOM2:
> +		/* EXTERNEL UART */
> +		omap_uart_debug_ll_phy_addr = 0x10000000;
> +	break;
> +	default:
> +		/* UART1 */
> +		omap_uart_debug_ll_phy_addr = 0x4806a000;
> +	break;
> +	}
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP4
> +	switch (__machine_arch_type) {
> +	/* OMAP3: UART1 */
> +	case MACH_TYPE_OMAP_4430SDP:
> +	default:
> +		omap_uart_debug_ll_phy_addr = (u32 *)0x4806a000;
> +	break;
> +	}
> +#endif
> +
> +	return omap_uart_debug_ll_phy_addr;
> +}
This makes only UART1 as a DEBUG_LL option for OMAP4. Will we not have options any more to select rest of the UARTs for DEBUG_LL as it was supported with previous Russell's implementation?


Regards,
Santosh
