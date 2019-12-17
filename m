From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] soc: ti: wkup_m3_ipc: Fix race condition with rproc_boot
Date: Tue, 17 Dec 2019 10:35:48 -0800
Message-ID: <20191217183548.GE35479@atomide.com>
References: <20191212040314.14753-1-d-gerlach@ti.com>
 <20191217182534.GD35479@atomide.com>
 <05b9f0ff-bbc2-d8a7-3261-54c03a149db8@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <05b9f0ff-bbc2-d8a7-3261-54c03a149db8@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: santosh.shilimkar@oracle.com
Cc: Dave Gerlach <d-gerlach@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

* santosh.shilimkar@oracle.com <santosh.shilimkar@oracle.com> [191217 18:33]:
> On 12/17/19 10:25 AM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Dave Gerlach <d-gerlach@ti.com> [191211 20:02]:
> > > Any user of wkup_m3_ipc calls wkup_m3_ipc_get to get a handle and this
> > > checks the value of the static variable m3_ipc_state to see if the
> > > wkup_m3 is ready. Currently this is populated during probe before
> > > rproc_boot has been called, meaning there is a window of time that
> > > wkup_m3_ipc_get can return a valid handle but the wkup_m3 itself is not
> > > ready, leading to invalid IPC calls to the wkup_m3 and system
> > > instability.
> > > 
> > > To avoid this, move the population of the m3_ipc_state variable until
> > > after rproc_boot has succeeded to guarantee a valid and usable handle
> > > is always returned.
> > 
> > Santosh, do you want me to pick this one into my fixes branch?
> > 
> Sure, go ahead.
> 
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

OK thanks applying into fixes.

Tony
