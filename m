From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap device tree changes for v4.2, part 1
Date: Fri, 29 May 2015 13:55:19 +0200
Message-ID: <3356447.2K9JD68FjR@wuerfel>
References: <20150522202028.GE10274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:52049 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbbE2Lza (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 07:55:30 -0400
In-Reply-To: <20150522202028.GE10274@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org

On Friday 22 May 2015 13:20:28 Tony Lindgren wrote:
> ----------------------------------------------------------------
> Device tree related changes for omaps:
> 
> - Configure MMC data lines 4..8 for 1.8V IO on boards that
>   are using them as GPIOs instead of MMC data lines
> 
> - Add support for Baltos IR5221
> 
> - Add device tree support for LogicPD Torpedo devkit
> 
> - Add 3717 core pinctrl region
> 
> - Add gta04 1w and GSM audio support
> 
> - Add wilink and ov2659 support for am437x-gp-evm
> 
> - Add am335x-evm bluetooth and mmc3 support
> 
> - Enable omap5-uevm uart wakeup interrupt
> 
> - Enable I2C2 on BeagleBone as it's used for the capes
> 
> - Use defines for LDP GPIO keys
> 
> 

Pulled into next/dt, thanks!

	Arnd
