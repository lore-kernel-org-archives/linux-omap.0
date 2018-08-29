From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP
 flag for non-am43 SoCs
Date: Wed, 29 Aug 2018 17:17:38 +0200
Message-ID: <f9d76b45-99c4-577a-64ff-7d4a0183af37@linaro.org>
References: <1533734099-1398-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533734099-1398-1-git-send-email-j-keerthy@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, tglx@linutronix.de
Cc: lokeshvutla@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, baolin.wang@linaro.org, d-gerlach@ti.com, tony@atomide.com, grygorii.strashko@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On 08/08/2018 15:14, Keerthy wrote:
> The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
> add the flag for all the other SoCs.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---

Applied for 4.19-rc2

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
