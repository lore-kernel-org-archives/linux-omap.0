From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH v4 1/4] OMAP2+: cpufreq: dont support !freq_table
Date: Thu, 02 Jun 2011 15:11:49 -0700
Message-ID: <87oc2frihm.fsf@ti.com>
References: <1306463960-27340-1-git-send-email-nm@ti.com>
	<1306463960-27340-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:35213 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755049Ab1FBWLx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 18:11:53 -0400
Received: by pwj8 with SMTP id 8so1150210pwj.27
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 15:11:51 -0700 (PDT)
In-Reply-To: <1306463960-27340-2-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 26 May 2011 19:39:17 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> OMAP2+ all have frequency tables, hence the hacks we had for older
> silicon do not need to be carried forward. As part of this change,
> use cpufreq_frequency_table_target to find the best match for
> frequency requested.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, applied.

Kevin
