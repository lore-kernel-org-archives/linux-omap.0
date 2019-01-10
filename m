From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] PM/runtime: Fix autosuspend_delay on 32bits arch
Date: Thu, 10 Jan 2019 08:44:31 -0800
Message-ID: <20190110164431.GA5544@atomide.com>
References: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, ladis@linux-mips.org
List-Id: linux-omap@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [190110 09:00]:
> Cast autosuspend_delay in u64 to make sure that the full computation of
> expires or slack will be done in u64, even on 32bits arch.
> Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
> is used when moving delay from msec to nsec
> 
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> Change since v1:
> - add u64 cast for slack computation

Still works for me.

Thanks,

Tony
