From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/8] OMAP: convert I2C driver to PM QoS for latency constraints
Date: Thu, 15 Sep 2011 15:46:26 -0700
Message-ID: <87aaa5whj1.fsf@ti.com>
References: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
	<1314969204-21704-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38210 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935230Ab1IOWqc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 18:46:32 -0400
Received: by mail-yw0-f41.google.com with SMTP id 9so2981932ywe.0
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 15:46:31 -0700 (PDT)
In-Reply-To: <1314969204-21704-2-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Fri, 2 Sep 2011 15:13:17 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi Jean,

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
> API to the new PM QoS API.
> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATENCY
> class of PM QoS. The resulting MPU constraints are used by cpuidle to
> decide the next power state of the MPU subsystem.
>
> Currently only OMAP3 is placing constraints on the MPU.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

[...]

> @@ -648,8 +648,16 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	if (r < 0)
>  		goto out;
>  
> -	if (dev->set_mpu_wkup_lat != NULL)
> -		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
> +	/*
> +	 * When waiting for completion of a i2c transfer, we need to
> +	 * set a wake up latency constraint for the MPU. This is to
> +	 * ensure quick enough wakeup from idle, when transfer
> +	 * completes.
> +	 * Used on OMAP3 Only
> +	 */
> +	if (cpu_is_omap34xx())

We don't want any cpu_is_* checking  in drivers.

If this is only done on certain SoCs, then a flag should be passed from
device init code via pdata.

That being said, I don't see why this shouldn't be set for all SoCs
since it's using the FIFO size to determine the latency.

Kevin

