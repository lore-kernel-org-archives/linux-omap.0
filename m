From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2+: CPUfreq: Allow the CPU scaling when secondary CPUs are offline.
Date: Thu, 02 Jun 2011 16:10:24 -0700
Message-ID: <87ei3bomn3.fsf@ti.com>
References: <1307026270-313-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39502 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755131Ab1FBXK1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 19:10:27 -0400
Received: by mail-px0-f169.google.com with SMTP id 9so797099pxi.14
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 16:10:27 -0700 (PDT)
In-Reply-To: <1307026270-313-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Thu, 2 Jun 2011 20:21:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Current OMAP2PLUS CPUfreq tagret() functions returns when all
> the CPU's are not online. This will break DVFS when secondary
> CPUs are offlined.
>
> The intention of that check was just avoid CPU frequency change
> during the window when CPU becomes online but it's cpufreq_init is
> not done yet.
>
> Fix the check accordingly.
>
> Thanks for Nishant Menon <nm@ti.com> for reporting it.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reported-by: Nishanth Menon <nm@ti.com>
> Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
> There were some question of making the variable atomic etc
> in an internal discussion. After some thinking, I realised
> there is no need of that since this is just a counter which
> maintains the count for online_cpus = cpufreq_init_cpus. 

Since this is init-time only check, the check for every call to
->target() seems excessive.

How about leaving the ->target callback empty until all the CPUs are
online.

Also, how will this handle an SMP kernel booted with maxcpus=1 on the
cmdline?

Kevin
