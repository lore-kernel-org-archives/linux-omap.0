From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 07/12] ARM: OMAP3: mmc-twl4030 add MMC3 support
Date: Sun, 15 Mar 2009 16:04:26 +0000
Message-ID: <20090315160426.GE10786@n2100.arm.linux.org.uk>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211000.16425.62205.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42478 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbZCOQEg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 12:04:36 -0400
Content-Disposition: inline
In-Reply-To: <20090310211000.16425.62205.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

On Tue, Mar 10, 2009 at 02:10:00PM -0700, Tony Lindgren wrote:
> ... Array size for hsmmc[] is specified
> because hsmmc[2].name is needed for MMC3 name.

I see nothing in this patch which requires that.

> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> index 6399874..042035c 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -62,7 +62,7 @@ static struct twl_mmc_controller {
>  	u8		twl_vmmc_dev_grp;
>  	u8		twl_mmc_dedicated;
>  	char		name[HSMMC_NAME_LEN + 1];
> -} hsmmc[] = {
> +} hsmmc[OMAP34XX_NR_MMC] = {

so this change looks like it can be omitted.
