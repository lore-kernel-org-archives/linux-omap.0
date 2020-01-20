From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
Date: Mon, 20 Jan 2020 16:11:21 +0100
Message-ID: <d0b90b97-3604-d4f4-b873-3879a9221532@arm.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:33464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATPL3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 20 Jan 2020 10:11:29 -0500
In-Reply-To: <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lukasz.luba@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-imx@nxp.com
Cc: Morten.Rasmussen@arm.com, Chris.Redpath@arm.com, ionela.voinescu@arm.com, javi.merino@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com, daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org, qperret@google.com, bsegall@google.com, mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org, matthias.bgg@gmail.com, steven.price@arm.com, tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffw

On 20/01/2020 15:53, Dietmar Eggemann wrote:
> On 16/01/2020 16:20, lukasz.luba@arm.com wrote:
>> From: Lukasz Luba <lukasz.luba@arm.com>

[...]

>> +enum em_type {
>> +	EM_SIMPLE,
>> +	EM_CPU,
>> +};
> 
> s/EM_SIMPLE/EM_DEV ?
> 
> Right now I only see energy models and _one_ specific type (the CPU EM).
> So a tag 'is a CPU EM' would suffice. No need for EM_SIMPE ...

Wait, you even have

struct em_device {
        struct em_perf_domain *em_pd;
        struct device *dev;
        ...
}

static bool _is_cpu_device(struct device *dev)

Shouldn't this be enough to distinguish between EM and special CPU EM
under the API? Even when required to use container_of() to get from
em_perf_domain to device.
