From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] USB: Generalize usb initialization for omap hw
Date: Thu, 24 Apr 2008 12:07:43 -0700
Message-ID: <200804241207.43593.david-b@pacbell.net>
References: <200804241129.28213.david-b@pacbell.net> <1209063112-30352-1-git-send-email-felipe.balbi@nokia.com> <1209063112-30352-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:33475 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757775AbYDXTHp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2008 15:07:45 -0400
In-Reply-To: <1209063112-30352-2-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Looks better to me, but:

On Thursday 24 April 2008, Felipe Balbi wrote:
> +static void setup_ehci_io_mux(void)
> +{
> +#ifdef CONFIG_OMAP_EHCI_PHY_MODE

This PHY_MODE thing should probably be provided by the board
data not Kconfig, and

> +=A0=A0=A0=A0=A0=A0=A0/* PHY mode of operation for board: 750-2083-00=
1
> +=A0=A0=A0=A0=A0=A0=A0 * ISP1504 connected to Port1 and Port2
> +=A0=A0=A0=A0=A0=A0=A0 * Do Func Mux setting for 12-pin ULPI PHY mode
> +=A0=A0=A0=A0=A0=A0=A0 */
> +
> +=A0=A0=A0=A0=A0=A0=A0/* Port1 */
> +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y9_3430_USB1HS_PHY_STP);
> +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK);
> 	...

All those MUX options should be driven by the board data too.

Unless it's for some reason not possible to configure only one
of the three EHCI ports at a time...

This patch being cleanup-only, I don't suggest you fix that
at this time.

- Dave



> +
> +#else
> +=A0=A0=A0=A0=A0=A0=A0/* Set Func mux for :
> +=A0=A0=A0=A0=A0=A0=A0 * TLL mode of operation
> +=A0=A0=A0=A0=A0=A0=A0 * 12-pin ULPI SDR TLL mode for Port1/2/3
> +=A0=A0=A0=A0=A0=A0=A0 */
> +
> +=A0=A0=A0=A0=A0=A0=A0/* Port1 */
> +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y9_3430_USB1HS_TLL_STP);
> +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y8_3430_USB1HS_TLL_CLK);
> +=A0=A0=A0=A0=A0=A0=A0	...
> +#endif /* CONFIG_OMAP_EHCI_PHY_MODE */
> +
> +=A0=A0=A0=A0=A0=A0=A0return;
> +}


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
