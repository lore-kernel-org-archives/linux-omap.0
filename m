From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/14] ARM: OMAP2: Add functions to save and restore
 pinctrl context.
Date: Thu, 12 Apr 2018 07:16:39 -0700
Message-ID: <20180412141639.GV5700@atomide.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-9-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523505239-16229-9-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com, Russ Dill <Russ.Dill@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Keerthy <j-keerthy@ti.com> [180412 03:56]:
> From: Russ Dill <Russ.Dill@gmail.com>
> 
> This adds a pair of context save/restore functions to save/restore the
> state of a set of pinctrl registers. This simplifies some of the AM33XX
> PM code as some of the pinctrl registers are lost when the per power
> domain loses power. The pincrtl code can perform the necessary
> save/restore.

So where's the patch adding callers to this code?

If this cannot be done from regular driver suspend/resume calls,
this probably should be done from cpu_pm notifiers CPU_PM_ENTER and
CPU_PM_EXIT. We should also do the same for GPIO BTW.

BTW, the subject line is wrong here, it should be "pinctrl" :)

Regards,

Tony
