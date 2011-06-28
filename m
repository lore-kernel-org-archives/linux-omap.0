From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/7] OMAP4: hwmod data: TEMP: Do not idle MMC1 & MMC2 after boot
Date: Mon, 27 Jun 2011 17:17:45 -0700
Message-ID: <87boxi4xna.fsf@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
	<1309192391-12410-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:40682 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755490Ab1F1ARu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 20:17:50 -0400
Received: by mail-pz0-f48.google.com with SMTP id 10so4303095pzk.35
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 17:17:49 -0700 (PDT)
In-Reply-To: <1309192391-12410-4-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 27 Jun 2011 18:33:07 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

Benoit Cousson <b-cousson@ti.com> writes:

> Since the MMC driver is not pm_runtime adapted, do not put
> them in idle after boot.
> It will allow the driver to work as expected until the migration
> to pm_runtime.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Similar is needed for OMAP3 as well to boot this series.

Kevin




diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/om
index dec1a38..aaa3201 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3500,6 +3500,7 @@ static struct omap_hwmod omap3xxx_mmc1_hwmod = {
        .slaves_cnt     = ARRAY_SIZE(omap3xxx_mmc1_slaves),
        .class          = &omap34xx_mmc_class,
        .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+       .flags          = HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 };
 
 /* MMC/SD/SDIO2 */
@@ -3543,6 +3544,7 @@ static struct omap_hwmod omap3xxx_mmc2_hwmod = {
        .slaves_cnt     = ARRAY_SIZE(omap3xxx_mmc2_slaves),
        .class          = &omap34xx_mmc_class,
        .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+       .flags          = HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 };
 
