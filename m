From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: voltagedomain data: remove temporary OMAP4
 voltage data
Date: Tue, 25 Jun 2013 19:58:54 -0400
Message-ID: <51CA2EBE.6020107@ti.com>
References: <1372204560-1304-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60340 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304Ab3FYX7B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jun 2013 19:59:01 -0400
In-Reply-To: <1372204560-1304-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tuesday 25 June 2013 07:56 PM, Nishanth Menon wrote:
> commit 20d49e9ccfece526db755940721aa13e331936d4
> (ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data)
> 
> Introduced dummy volt data for OMAP5 with OMAP4460 voltage information.
> 
> However with the fixes introduced in later patches
> 
> commit cd8abed1da91a3250aa4b3857479613a2b446f84
> (ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm
>  associated to a pwrdm)
> 
> We are no longer restricted in that respect. Further, OPP voltage
> information is supposed to be provided by dts information. This needs
> to be added in future patches as various voltage modules are converted
> to dts.
> 
> This also fixes the build breakage for voltagedomains54xx_data.c when just
> OMAP5 SoC is enabled: https://patchwork.kernel.org/patch/2764191/
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> ---
> 
Thanks Nishant for the patch.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

