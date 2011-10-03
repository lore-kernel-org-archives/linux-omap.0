From: Kevin Hilman <khilman@ti.com>
Subject: Re: cpufreq-info doesn't work in linux-3.0 on DM3730
Date: Mon, 03 Oct 2011 15:28:02 -0700
Message-ID: <87ipo5n219.fsf@ti.com>
References: <4E874EA3.6060903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34084 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752185Ab1JCW2H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 18:28:07 -0400
Received: by mail-yw0-f47.google.com with SMTP id 7so4582604ywf.20
        for <linux-omap@vger.kernel.org>; Mon, 03 Oct 2011 15:28:05 -0700 (PDT)
In-Reply-To: <4E874EA3.6060903@gmail.com> (Peter Barada's message of "Sat, 01
	Oct 2011 13:32:19 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Peter,

Peter Barada <peter.barada@gmail.com> writes:

> I'm trying to get frequency scaling working in linux-3.0, and it after
> digging into why cpufreq-info works in 2.6.32 and doesn't in 3.0, I've
> found that omap_cpu_init() returs -ENOENT due to clk_get(NULL,
> "virt_prcm_set") failing.
>
> In the older 2.6.32 kernel it used "arm_fck" for MPU_CLK instead of
> "virt_prcm_set", but that option isn't in the linux-3.0 source (or the
> current source in tony's tree on github.com).  I tried reverting to
> "arm_fck", but on a DM3730 cpupfreq-info only shows 600Mhz as a
> possibility, and none of the other operating points.
>
> Does anyone have CPU frequency scaling working in linux-3.0 and have
> any suggestions on what I'm doing wrong?

I recently posted[1] an updated CPUfreq driver that is proposed for merge
in v3.2.

It's also availble in the 'for_3.2/omap-cpufreq' branch of my github
repo: git://github.com/khilman/linux-omap-pm.git

Kevin

[1] http://marc.info/?l=linux-omap&m=131672565712833&w=2
