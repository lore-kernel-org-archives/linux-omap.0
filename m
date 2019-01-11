From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM/runtime: Fix autosuspend_delay on 32bits arch
Date: Fri, 11 Jan 2019 11:39:34 +0100
Message-ID: <6922521.G0BVNVQKqm@aspire.rjw.lan>
References: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org> <20190110164431.GA5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110164431.GA5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ulf.hansson@linaro.org, ladis@linux-mips.org
List-Id: linux-omap@vger.kernel.org

On Thursday, January 10, 2019 5:44:31 PM CET Tony Lindgren wrote:
> * Vincent Guittot <vincent.guittot@linaro.org> [190110 09:00]:
> > Cast autosuspend_delay in u64 to make sure that the full computation of
> > expires or slack will be done in u64, even on 32bits arch.
> > Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
> > is used when moving delay from msec to nsec
> > 
> > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > Reported-by: Tony Lindgren <tony@atomide.com>
> > Tested-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> > 
> > Change since v1:
> > - add u64 cast for slack computation
> 
> Still works for me.

Applied, thanks!
