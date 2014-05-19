From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 3/4] ARM: dts: dra7: add support for parallel NAND
 flash
Date: Mon, 19 May 2014 15:12:26 -0700
Message-ID: <20140519221225.GG11945@atomide.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
 <1400490948-11571-4-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42658 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751253AbaESWMb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 18:12:31 -0400
Content-Disposition: inline
In-Reply-To: <1400490948-11571-4-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Minal Shah <minalkshah@gmail.com>

* Pekon Gupta <pekon@ti.com> [140519 02:16]:
> From: Minal Shah <minalkshah@gmail.com>
> 
> DRA7xx platform has in-build GPMC and ELM h/w engines which can be used
> for accessing externel NAND flash device. This patch:
> - adds generic DT binding in dra7.dtsi for enabling GPMC and ELM h/w engines
> - adds DT binding for Micron NAND Flash (MT29F2G16AADWP) present on dra7-evm
> *Important*
> 	On DRA7 EVM, GPMC_WPN and NAND_BOOTn are controlled by DIP switch
> 	So following board settings are required for NAND device detection:
> 	SW5.9 (GPMC_WPN) = LOW
> 	SW5.1 (NAND_BOOTn) = HIGH
> 
> Signed-off-by: Minal Shah <minalkshah@gmail.com>
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

Thanks applying this into omap-for-v3.16/dt.

Tony
