From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH]Add 3430 SDP board level support for HSMMC2
Date: Wed, 13 Aug 2008 01:54:33 -0700
Message-ID: <20080813085433.D5C2F363253@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <33259.192.168.10.89.1218608332.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:31326 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757420AbYHMIst (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Aug 2008 04:48:49 -0400
In-Reply-To: <33259.192.168.10.89.1218608332.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, madhu.cr@ti.com
Cc: linux-omap@vger.kernel.org

>  arch/arm/mach-omap2/board-3430sdp.c |    4
>  arch/arm/mach-omap2/hsmmc.c         |  185 ++++++++++++++++++++++++++++++++

hsmmc.c is used by Beagle too, yet ...


>  void __init hsmmc_init(void)
>  {
>  	omap_set_mmc_info(1, &hsmmc_data);
> +	omap_set_mmc_info(2, &hsmmc2_data);
>  }

... MMC2 is rarely enabled on Beagle, so this is incorrect.


A better way to do this would be to let the boards say exactly
what the hardware configuration is, rather than requiring all
OMAP3 boards to be set up exactly like the SDP...

- Dave

