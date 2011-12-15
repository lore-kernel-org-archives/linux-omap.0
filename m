From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] OMAP: convert I2C driver to PM QoS for latency constraints
Date: Wed, 14 Dec 2011 16:17:27 -0800
Message-ID: <87iplipu20.fsf@ti.com>
References: <1319034531-22964-1-git-send-email-j-pihet@ti.com>
	<1319034531-22964-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:60683 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755784Ab1LOARc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 19:17:32 -0500
Received: by mail-iy0-f175.google.com with SMTP id j38so2075258iad.6
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 16:17:31 -0800 (PST)
In-Reply-To: <1319034531-22964-2-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 19 Oct 2011 16:28:50 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
> API to the new PM QoS API.
> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATENCY
> class of PM QoS. The resulting MPU constraints are used by cpuidle to
> decide the next power state of the MPU subsystem.
>
> The I2C device latency timing is derived from the FIFO size and the
> clock speed and so is applicable to all OMAP SoCs.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Nice.

Acked-by: Kevin Hilman <khilman@ti.com>

I'll queue this with the other I2C changes I've queued once the QoS
series has been merged.

Kevin
