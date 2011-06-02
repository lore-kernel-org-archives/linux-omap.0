From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH v4 3/4] OMAP2+: cpufreq: put clk if cpu_init failed
Date: Thu, 02 Jun 2011 15:12:01 -0700
Message-ID: <87k4d3riha.fsf@ti.com>
References: <1306463960-27340-1-git-send-email-nm@ti.com>
	<1306463960-27340-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55423 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755041Ab1FBWMH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 18:12:07 -0400
Received: by mail-pv0-f173.google.com with SMTP id 3so741220pvg.18
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 15:12:03 -0700 (PDT)
In-Reply-To: <1306463960-27340-4-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 26 May 2011 19:39:19 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Release the mpu_clk in fail paths.
>
> Reported-by: Todd Poynor <toddpoynor@google.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, applied.

Kevin
