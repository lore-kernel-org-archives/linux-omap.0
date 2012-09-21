From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: hwmod: partially un-reset hwmods might
 not be properly enabled
Date: Fri, 21 Sep 2012 00:44:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209210042370.6888@utopia.booyaka.com>
References: <1345614150-25723-1-git-send-email-omar.luna@linaro.org> <1345614150-25723-2-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345614150-25723-2-git-send-email-omar.luna@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Omar

On Wed, 22 Aug 2012, Omar Ramirez Luna wrote:

> Some IP blocks might not be using/controlling more than one
> reset line, this check loosens the restriction to fully use
> hwmod framework for those drivers.
> 
> E.g.: ipu has reset lines: mmu_cache, cpu0 and cpu1.
> - As of now cpu1 is not used and hence (with previous check) the
>   IP block isn't fully enabled by hwmod code.
> - Usually ipu and dsp processors configure their mmu module first
>   and then enable the processors, this involves:
>     * Deasserting mmu reset line, and enabling the module.
>     * Deasserting cpu0 reset line, and enabling the processor.
>   The ones portrayed in this example are controlled through
>   rproc_fw_boot in drivers/remoteproc/remoteproc_core.c
> 
> While at it, prevent _omap4_module_disable if all the hardreset
> lines on an IP block are not under reset.
> 
> This will allow the driver to:
>   a. Deassert the reset line.
>   b. Enable the hwmod through runtime PM default callbacks.
>   c. Do its usecase.
>   d. Disable hwmod through runtime PM.
>   e. Assert the reset line.
> 
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>

Well, I don't think this is the right long-term solution, but I'd like to 
see this moving forward.  So this one has been queued for 3.7.  Hopefully 
we can figure out the right thing once the PRM driver is ready (which will 
handle the low-level hard resets).


- Paul
