From: Seth Forshee <seth.forshee@gmail.com>
Subject: Re: [PATCH 1/1] PLAT: OMAP: Add device configuration to support second HSMMC slot on OMAP 2430 and 3430 boards.
Date: Thu, 20 Mar 2008 19:44:02 -0500
Message-ID: <20080321004401.GA8667@ubuntu-workstation>
References: <47E273BD.9080705@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:2920 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbYCUAph (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 20:45:37 -0400
Received: by py-out-1112.google.com with SMTP id u52so1621809pyb.10
        for <linux-omap@vger.kernel.org>; Thu, 20 Mar 2008 17:45:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <47E273BD.9080705@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, Mar 20, 2008 at 10:25:01AM -0400, Carlos Aguiar wrote:
>  	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> -		if (mmc->enabled)
> +		mmc = &mmc_conf->mmc[1];
> +		if (mmc->enabled) {
>  			(void) platform_device_register(&mmc_omap_device1);
> +			(void) platform_device_register(&mmc_omap_device2);
> +		}

Shouldn't you only register each device if enabled in the corresponding
configuration, i.e.:

	if (mmc_conf->mmc[1].enabled)
		(void) platform_device_register(&mmc_omap_device1);
	if (mmc_conf->mmc[2].enabled)
		(void) platform_device_register(&mmc_omap_device2);

It looks to me like, with this patch applied, no MMC devices will be
registered with the current board-2430sdp.c.

Otherwise I'd say this looks like an improvement over what I worked up (I
overlooked the section quoted above, which would have saved me the trouble of
working out the muxings).

Cheers,
Seth
