From: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
Date: Tue, 21 Jan 2020 09:37:55 +0000
Message-ID: <20200121093755.GA157387@google.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <20200117105437.GA211774@google.com>
 <40587d98-0e8d-cbac-dbf5-d26501d47a8c@arm.com>
 <20200120150918.GA164543@google.com>
 <8332c4ac-2a7d-1e2d-76e9-7c979a666257@arm.com>
 <b02da0ed-9e0b-36db-9813-daa334cbf2ba@arm.com>
 <c9910c74-ab47-0c78-a1c7-4f3978e1dd09@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46052 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgAUJiC (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2020 04:38:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so2298398wrj.12
        for <linux-omap@vger.kernel.org>; Tue, 21 Jan 2020 01:38:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c9910c74-ab47-0c78-a1c7-4f3978e1dd09@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-imx@nxp.com, Morten.Rasmussen@arm.com, Chris.Redpath@arm.com, ionela.voinescu@arm.com, javi.merino@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com, daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail

On Tuesday 21 Jan 2020 at 10:10:16 (+0100), Dietmar Eggemann wrote:
> True. But then we hard-code that a CPU device performance domain can
> only be a frequency domain (which is true today).
> 
> The task scheduler (build_perf_domains()) and thermal are already using
> cpufreq_cpu_get() to access the cpufreq policy. Now the EM framework
> would too for CPU devices. I assume that could work with a couple of
> adaptations in Documentation/power/energy-model.rst.

Agreed, and if one day we have a real use case where the pd mask and the
cpufreq policy mask need to be different, we'll do the necessary
changes. But until then I don't see a reason to object to Lukasz'
proposal. So +1 from me.

Thanks,
Quentin
