From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP: CLK: CLKSRC: Add suspend resume hooks
Date: Wed, 23 May 2018 11:41:16 -0700
Message-ID: <20180523184116.GS98604@atomide.com>
References: <1527013340-8036-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1527013340-8036-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180522 11:24]:
> Add the save and restore for clksrc as part of suspend and resume
> so that it saves the counter value and restores. This is needed in
> modes like rtc+ddr in self-refresh not doing this stalls the time.

Can't we now do this all in drivers/clocksource/timer-ti-*.c?

> @@ -490,6 +513,15 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
>  	res = omap_dm_timer_init_one(&clksrc, fck_source, property,
>  				     &clocksource_gpt.name,
>  				     OMAP_TIMER_NONPOSTED);
> +
> +	if (soc_is_am43xx()) {
> +		clocksource_gpt.suspend = omap2_gptimer_clksrc_suspend;
> +		clocksource_gpt.resume = omap2_gptimer_clksrc_resume;
> +
> +		clocksource_gpt_hwmod =
> +			omap_hwmod_lookup(clocksource_gpt.name);
> +	}
> +

Then you can do this based on a quirk flag set by compatible.

Regards,

Tony
