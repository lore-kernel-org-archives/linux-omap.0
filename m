From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] OMAP: PM: remove the latency related functions from the API
Date: Wed, 14 Dec 2011 16:19:23 -0800
Message-ID: <87boraptys.fsf@ti.com>
References: <1319034531-22964-1-git-send-email-j-pihet@ti.com>
	<1319034531-22964-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42872 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753150Ab1LOAT0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 19:19:26 -0500
Received: by mail-iy0-f172.google.com with SMTP id k3so2361129iae.31
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 16:19:25 -0800 (PST)
In-Reply-To: <1319034531-22964-3-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 19 Oct 2011 16:28:51 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Remove the following functions from the API:
>  omap_pm_set_max_mpu_wakeup_lat
>  omap_pm_set_max_dev_wakeup_lat
>  omap_pm_set_max_sdma_lat
>
> The generic per-device PM QoS functions shall be used instead, cf.
> include/linux/pm_qos.h.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Paul can pick this up once the QoS changes have merged and the I2C
driver (and any other in-tree users) have been converted.

Kevin
