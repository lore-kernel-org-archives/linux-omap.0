From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 3/5] clk: introduce the common clock framework
Date: Thu, 1 Dec 2011 14:42:05 +0000
Message-ID: <20111201144205.GA2103@sirena.org.uk>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-4-git-send-email-mturquette@linaro.org>
 <alpine.DEB.2.00.1111291619110.6289@utopia.booyaka.com>
 <CAJOA=zM4vcyTt_RBEVm6JxmzW-Dna0gpuWda7ytq_mqFSuXw9g@mail.gmail.com>
 <alpine.DEB.2.00.1111302308280.6289@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1111302308280.6289@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Turquette, Mike" <mturquette@ti.com>, linux@arm.linux.org.uk, linus.walleij@stericsson.com, patches@linaro.org, shawn.guo@freescale.com, magnus.damm@gmail.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, richard.zhao@linaro.org, grant.likely@secretlab.ca, dsaxena@linaro.org, eric.miao@linaro.org, sboyd@quicinc.com, skannan@quicinc.com, linaro-dev@lists.linaro.org, jeremy.kerr@canonical.com, linux-omap@vger.kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, arnd.bergmann@linaro.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 30, 2011 at 11:39:59PM -0700, Paul Walmsley wrote:

> Clock rate/parent-change notifiers are requirements for DVFS use-cases, 
> and they must be paired with something like the 
> clk_{allow,block}_rate_change() functions to work efficiently.  I intend 
> to comment on this later; it's not a simple problem.  It might be worth 
> noting that Tero and I implemented a simplified version of this for the 
> N900.

I'm thinking that if we're going to have clk_{allow,block}_rate_change()
we may as well make that the main interface to enable rate changes - if
a device wants to change the clock rate it allows rate changes using
that interface rather than by disabling the clocks.  I've got devices
which can do glitch free updates of active clocks so having to disable
would be a real restriction, and cpufreq would have issues with actually
disabling the clock too I expect.
