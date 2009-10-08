From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: X-loader / U-Boot query
Date: Thu, 8 Oct 2009 10:14:20 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012A6FC720@dlee02.ent.ti.com>
References: <4ACDE1DF.1010303@mlbassoc.com>
 <4ACDFB52.2080100@astc-design.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42126 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932634AbZJHPPC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 11:15:02 -0400
In-Reply-To: <4ACDFB52.2080100@astc-design.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adam Machalek <adam.machalek@astc-design.com>, Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Adam Machalek
> Sent: Thursday, October 08, 2009 9:47 AM
> To: Gary Thomas
> Cc: linux-omap@vger.kernel.org
> Subject: Re: X-loader / U-Boot query
> 
> The problem is located in u-boot/cpu/arm_cortexa8/omap3/mem.c
> 
> Function do_sdrc_init()
> 
> There is an assumption that the RAM size on each CS is maximum of 128M.
> See this line:
> 
> writel(RASWIDTH_13BITS | CASWIDTH_10BITS | ADDRMUXLEGACY |
>       RAMSIZE_128 | BANKALLOCATION | B32NOT16 | B32NOT16 |
>       DEEPPD | DDR_SDRAM, &sdrc_base->cs[cs].mcfg);
> 
This discussion should really be taken to u-boot mailing list. Yes, any additional patches would be good to have..

Regards,
Nishanth Menon

