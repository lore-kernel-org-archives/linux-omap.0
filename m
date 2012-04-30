From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: PM: remove the latency related functions from the API
Date: Mon, 30 Apr 2012 16:08:58 -0700
Message-ID: <87lilclsvp.fsf@ti.com>
References: <1334757314-29325-1-git-send-email-j-pihet@ti.com>
	<1334757314-29325-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:40490 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756924Ab2D3XJB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 19:09:01 -0400
Received: by daev18 with SMTP id v18so5628488dae.6
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 16:09:00 -0700 (PDT)
In-Reply-To: <1334757314-29325-3-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 18 Apr 2012 15:55:14 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Remove the following functions from the OMAP PM API:
>  omap_pm_set_max_mpu_wakeup_lat
>  omap_pm_set_max_dev_wakeup_lat
>  omap_pm_set_max_sdma_lat
> and updated the kernel Documentation accordingly.
>
> The generic per-device PM QoS functions shall be used instead of the
> OMAP PM API, cf. include/linux/pm_qos.h and
> Documentation/power/pm_qos_interface.txt.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

