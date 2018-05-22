From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/14] OMAP: CLK: CLKSRC: Add suspend resume hooks
Date: Tue, 22 May 2018 06:39:55 -0700
Message-ID: <20180522133955.GG98604@atomide.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-13-git-send-email-j-keerthy@ti.com>
 <20180412142714.GX5700@atomide.com>
 <038cc2cd-ff72-c9c9-257b-1c1cc09a66a8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <038cc2cd-ff72-c9c9-257b-1c1cc09a66a8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180522 07:59]:
> On Thursday 12 April 2018 07:57 PM, Tony Lindgren wrote:
> > * Keerthy <j-keerthy@ti.com> [180412 03:56]:
> >> Add the save and restore for clksrc as part of suspend and resume
> >> so that it saves the counter value and restores. This is needed in
> >> modes like rtc+ddr in self-refresh not doing this stalls the time.
> > 
> > I suspect this too should really happen with cpu_pm.
> 
> I believe going by the previous set of patches this fits better with
> suspend/resume?

Yes if you don't need it for cpuidle and other SoC variants
don't need it for cpuidle.

> > Probably no need to look up the hwmod every time? Especially if am437x
> > will start supporting deeper idle modes during runtime.
> 
> Like clockevent i will store the hwmod pointer for clocksource as well.

OK

Regards,

Tony
