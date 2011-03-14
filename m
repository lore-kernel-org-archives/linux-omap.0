From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/3] omap2plus: clock: Add an alias cpu_ck to be used in
 common cpufreq driver
Date: Mon, 14 Mar 2011 14:49:15 +0530
Message-ID: <ddb27b28063c84f3b2366012e6b9b3ed@mail.gmail.com>
References: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com><1298614239-32196-2-git-send-email-santosh.shilimkar@ti.com>
 <87zkp2hbee.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:56275 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754351Ab1CNJTT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 05:19:19 -0400
Received: by qwi4 with SMTP id 4so1981836qwi.1
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 02:19:17 -0700 (PDT)
In-Reply-To: <87zkp2hbee.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Friday, March 11, 2011 3:43 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; vishwanath.bs@ti.com
> Subject: Re: [PATCH 1/3] omap2plus: clock: Add an alias cpu_ck to be
> used in common cpufreq driver
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > Add an alias clock node for cpu clock control on all OMAP2PLUS
> devices.
> > The intention is avoid cpu_is_xxxx() checks in the common cpufreq
> driver.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Rather than having hard-coded clkdev nodes, Since CPUfreq will be
> the
> only user of these clocks, it might make sense to just use cpu_is_*
> in the CPUfreq init and do clk_add_alias().
>

Since we are ok to have cpu_is_*() in CPUfreq init, we don't even
need to clk_add_alias().

We just the correct clock node handle based on SOC.

Regards,
Santosh
