From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/5 v3] OMAP3630: PM: Erratum i608: disable RTA
Date: Mon, 13 Dec 2010 19:28:23 -0800
Message-ID: <87r5dl119k.fsf@deeprootsystems.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com>
	<1291395818-8639-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51339 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab0LND22 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 22:28:28 -0500
Received: by pva4 with SMTP id 4so27468pva.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 19:28:27 -0800 (PST)
In-Reply-To: <1291395818-8639-4-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 3 Dec 2010 11:03:36 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ambresh K <ambresh@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Erratum id: i608
> RTA (Retention Till Access) feature is not supported and leads to device
> stability issues when enabled. This impacts modules with embedded memories
> on OMAP3630
>
> Workaround is to disable RTA on boot and coming out of core off.
> For disabling rta coming out of off mode, we do this by overriding the
> restore pointer for 3630 to allow us restore handler as the first point of
> entry before caches are touched and is common for GP and HS devices.
> to disable earlier than this could be possible by modifying the ppa for HS
> devices, but not for GP devices.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
>
> [ambresh@ti.com: co-developer]
> Signed-off-by: Ambresh K <ambresh@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

[...]

> @@ -1045,6 +1057,15 @@ static int __init omap3_pm_init(void)
>  	pm_idle = omap3_pm_idle;
>  	omap3_idle_init();
>  
> +	/*
> +	 * RTA is disabled during initialization as per erratum i608
> +	 * it is safer to disable rta by the bootloader, but we would like
> +	 * to be doubly sure here and prevent any mishaps.
> +	 */
> +	if (IS_PM34XX_ERRATUM(RTA_ERRATUM_i608))
> +		omap_ctrl_writel(OMAP36XX_RTA_DISABLE,
> +			OMAP36XX_CONTROL_MEM_RTA_CTRL);
> +

Minor nit: we've been trying to clean up control module access.  So,
rather than directly writing control module registers, could you create
an API for this like was done for omap3_ctrl_write_boot_mode().

Thanks,

Kevin

