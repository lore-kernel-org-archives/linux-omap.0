From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] clk: ti: fix dual-registration of uart4_ick
Date: Thu, 1 Oct 2015 17:15:39 -0700
Message-ID: <20151002001539.GA12338@codeaurora.org>
References: <1443535268-22586-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443535268-22586-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: stable-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, stable@vger.kernel.org, mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On 09/29, Ben Dooks wrote:
> On the OMAP AM3517 platform the uart4_ick gets registered
> twice, causing any power managment to /dev/ttyO3 to fail
> when trying to wake the device up.
> 
> This solves the following oops:
> 
> [] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa09e008
> [] PC is at serial_omap_pm+0x48/0x15c
> [] LR is at _raw_spin_unlock_irqrestore+0x30/0x5c
> 
> Cc: stable@vger.kernel.org
> Cc: mturquette@baylibre.com
> Cc: sboyd@codeaurora.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: t-kristo@ti.com
> Cc: linux-kernel@lists.codethink.co.uk
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Which patch broke this? Adding a Fixes: line will help us figure
out where to backport this.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
