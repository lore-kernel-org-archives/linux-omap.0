From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap2-beagle: Depend upon CONFIG_GPIO_TWL4030
Date: Tue, 18 Jan 2011 05:10:39 +0200
Message-ID: <20110118031038.GA2436@legolas.emea.dhcp.ti.com>
References: <1295299548-22839-1-git-send-email-bgamari.foss@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53862 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753534Ab1ARDKq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 22:10:46 -0500
Received: by gyg13 with SMTP id 13so2125867gyg.16
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 19:10:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295299548-22839-1-git-send-email-bgamari.foss@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Mon, Jan 17, 2011 at 04:25:48PM -0500, Ben Gamari wrote:
> Some very basic setup (i.e. MMC) is done in the beagleboard's setup
> callback for the TWL4030's gpio driver, causing a kernel without this
> support to fail to find its root filesystem. I can't imagine why one would
> want to build a kernel for this board without this driver, so I think
> it's worthwhile to explicitly depend on it.
> 
> Signed-Off-By: Ben Gamari <bgamari.foss@gmail.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index ab784bf..74173f1 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -120,6 +120,7 @@ config MACH_OMAP_2430SDP
>  config MACH_OMAP3_BEAGLE
>  	bool "OMAP3 BEAGLE board"
>  	depends on ARCH_OMAP3
> +	depends on GPIO_TWL4030
>  	default y
>  	select OMAP_PACKAGE_CBB

NAK. This is totally bogus. The board doesn't really depend on
GPIO_TWL4030, the MMC driver does.

-- 
balbi
