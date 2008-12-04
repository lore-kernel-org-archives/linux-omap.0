From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Put in supportframework for PR785 board.
Date: Thu, 4 Dec 2008 10:10:30 -0800
Message-ID: <200812041010.31226.david-b@pacbell.net>
References: <1228386206-13513-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:31504 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751884AbYLDSKd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 13:10:33 -0500
In-Reply-To: <1228386206-13513-1-git-send-email-mani.pillai@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Thursday 04 December 2008, Manikandan Pillai wrote:
> +config PR785
> +=A0=A0=A0=A0=A0=A0=A0bool "A Texas Instruments TPS6235X based Power =
Module"
> +=A0=A0=A0=A0=A0=A0=A0depends on I2C=3Dy && MACH_OMAP3EVM=3Dy && GENE=
RIC_GPIO && (ARCH_OMAP

One more comment about that symbol:  as well as living in the
mach-omap2/Kconfig file, it should probably look more like=20

	config OMAP3EVM_PR785
	depends on MACH_OMAP3EVM

Having the module isn't a function of I2C, and the other dependencies
are implicit in OMAP3 EVM support.  The name "PR785" should be scoped;
in this usage it's specific to that EVM.  Another vendor might have a
board with the same name, let's not confuse things.  :)

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
