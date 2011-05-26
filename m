From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 0/6 V3] Cleanups for cpufreq
Date: Thu, 26 May 2011 11:10:27 -0700
Message-ID: <87ipsxcoz0.fsf@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:38210 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758143Ab1EZSKb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 14:10:31 -0400
Received: by mail-pz0-f52.google.com with SMTP id 35so617570pzk.39
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 11:10:30 -0700 (PDT)
In-Reply-To: <1306366733-8439-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 25 May 2011 16:38:45 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

So here's a dumb question, being rather ignorant of CPUfreq on SMP.

Should we be running a CPUfreq instance on both CPUs when they cannot be
scaled independently?

What is being scaled here is actually the cluster (the MPU SS via
dpll_mpu_ck), not an individual CPU.  So to me, it only makes sense to
have a an instance of the driver per scalable device, which in this case
is a single MPU SS.

What am I missing?

Kevin

