From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
Date: Mon, 20 Jan 2020 15:53:35 +0100
Message-ID: <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116152032.11301-2-lukasz.luba@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: lukasz.luba@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-imx@nxp.com
Cc: Morten.Rasmussen@arm.com, Chris.Redpath@arm.com, ionela.voinescu@arm.com, javi.merino@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com, daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org, qperret@google.com, bsegall@google.com, mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org, matthias.bgg@gmail.com, steven.price@arm.com, tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffw
List-Id: linux-omap@vger.kernel.org

On 16/01/2020 16:20, lukasz.luba@arm.com wrote:
> From: Lukasz Luba <lukasz.luba@arm.com>
> 
> Add support of other devices into the Energy Model framework not only the
> CPUs. Change the interface to be more unified which can handle other
> devices as well.

[...]

> -The source of the information about the power consumed by CPUs can vary greatly
> +The source of the information about the power consumed by devices can vary greatly
>  from one platform to another. These power costs can be estimated using
>  devicetree data in some cases. In others, the firmware will know better.
>  Alternatively, userspace might be best positioned. And so on. In order to avoid
> @@ -26,7 +28,7 @@ framework, and interested clients reading the data from it::
>         | Thermal (IPA) |  | Scheduler (EAS) |  |     Other     |
>         +---------------+  +-----------------+  +---------------+
>                 |                   | em_pd_energy()    |
> -               |                   | em_cpu_get()      |
> +               |  em_dev_get()     | em_cpu_get()      |

Looked really hard but can't find a em_dev_get() in the code? You mean
em_get_pd() ? And why em_get_pd() and not em_pd_get()?

>                 +---------+         |         +---------+
>                           |         |         |
>                           v         v         v
> @@ -47,12 +49,12 @@ framework, and interested clients reading the data from it::
>          | Device Tree  |   |   Firmware    |  |      ?       |
>          +--------------+   +---------------+  +--------------+

[...]

> +There is two API functions which provide the access to the energy model:
> +em_cpu_get() which takes CPU id as an argument and em_dev_get() with device
> +pointer as an argument. It depends on the subsystem which interface it is
> +going to use.

Would be really nice if this wouldn't be required. We should really aim
for 1 framework == 1 set of interfaces.

What happens if someone calls em_get_pd() on a CPU EM?

E.g:

 static struct perf_domain *pd_init(int cpu)
 {
-       struct em_perf_domain *obj = em_cpu_get(cpu);
+       struct device *dev = get_cpu_device(cpu);
+       struct em_perf_domain *obj = em_pd_get(dev);
        struct perf_domain *pd;

Two versions of one functionality will confuse API user from the
beginning ...

[...]

> +enum em_type {
> +	EM_SIMPLE,
> +	EM_CPU,
> +};

s/EM_SIMPLE/EM_DEV ?

Right now I only see energy models and _one_ specific type (the CPU EM).
So a tag 'is a CPU EM' would suffice. No need for EM_SIMPE ...

[...]
