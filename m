From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] thermal: devfreq_cooling: Refactor code and switch
 to use Energy Model
Date: Tue, 21 Jan 2020 12:11:24 -0500
Message-ID: <20200121121124.1a1f3175@gandalf.local.home>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
        <20200116152032.11301-4-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgAURLa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 21 Jan 2020 12:11:30 -0500
In-Reply-To: <20200116152032.11301-4-lukasz.luba@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-imx@nxp.com, Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com, Chris.Redpath@arm.com, ionela.voinescu@arm.com, javi.merino@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com, daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, qperret@google.com, bsegall@google.com, mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.c

On Thu, 16 Jan 2020 15:20:31 +0000
lukasz.luba@arm.com wrote:

> diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
> index 135e5421f003..8a5f04888abd 100644
> --- a/include/trace/events/thermal.h
> +++ b/include/trace/events/thermal.h
> @@ -153,31 +153,30 @@ TRACE_EVENT(thermal_power_cpu_limit,
>  TRACE_EVENT(thermal_power_devfreq_get_power,
>  	TP_PROTO(struct thermal_cooling_device *cdev,
>  		 struct devfreq_dev_status *status, unsigned long freq,
> -		u32 dynamic_power, u32 static_power, u32 power),
> +		u32 power),
>  
> -	TP_ARGS(cdev, status,  freq, dynamic_power, static_power, power),
> +	TP_ARGS(cdev, status,  freq, power),
>  
>  	TP_STRUCT__entry(
>  		__string(type,         cdev->type    )
>  		__field(unsigned long, freq          )
> -		__field(u32,           load          )
> -		__field(u32,           dynamic_power )
> -		__field(u32,           static_power  )
> +		__field(u32,           busy_time)
> +		__field(u32,           total_time)
>  		__field(u32,           power)
>  	),
>  
>  	TP_fast_assign(
>  		__assign_str(type, cdev->type);
>  		__entry->freq = freq;
> -		__entry->load = (100 * status->busy_time) / status->total_time;
> -		__entry->dynamic_power = dynamic_power;
> -		__entry->static_power = static_power;
> +		__entry->busy_time = status->busy_time;
> +		__entry->total_time = status->total_time;
>  		__entry->power = power;
>  	),
>  
> -	TP_printk("type=%s freq=%lu load=%u dynamic_power=%u static_power=%u power=%u",
> +	TP_printk("type=%s freq=%lu load=%u power=%u",
>  		__get_str(type), __entry->freq,
> -		__entry->load, __entry->dynamic_power, __entry->static_power,
> +		__entry->total_time == 0 ? 0 :
> +			(100 * __entry->busy_time) / __entry->total_time,
>  		__entry->power)
>  );
>  

Tracing updates look fine to me. Having the division on the output
makes more sense.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org> # for tracing code

-- Steve
