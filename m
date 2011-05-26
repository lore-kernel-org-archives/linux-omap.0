From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 2/8] OMAP2+: cpufreq: deny initialization if no mpudev
Date: Thu, 26 May 2011 10:34:11 -0700
Message-ID: <87y61te57w.fsf@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
	<1306366733-8439-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:58543 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753780Ab1EZReP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 13:34:15 -0400
Received: by pzk27 with SMTP id 27so661893pzk.27
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 10:34:14 -0700 (PDT)
In-Reply-To: <1306366733-8439-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 25 May 2011 16:38:47 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> if we do not have mpu_dev we normally fail in cpu_init. It is better
> to fail driver registration if the devices are not available.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, applied.

Kevin

