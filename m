From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/4] ARM: OMAP2+ hwmod: Allow modules to disable
 HW_AUTO
Date: Thu, 23 Mar 2017 13:59:36 -0700
Message-ID: <20170323205935.GP10760@atomide.com>
References: <1489405996-10718-1-git-send-email-rogerq@ti.com>
 <1489405996-10718-3-git-send-email-rogerq@ti.com>
 <140ff227-f778-7715-93a3-9ff638d03f55@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <140ff227-f778-7715-93a3-9ff638d03f55@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: paul@pwsan.com, bcousson@baylibre.com, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [170317 02:00]:
> From fe0a37d5e53381c3f79c6b6cf7915e44789f516f Mon Sep 17 00:00:00 2001
> From: Roger Quadros <rogerq@ti.com>
> Date: Tue, 7 Feb 2017 16:52:57 +0530
> Subject: [PATCH 2/4] ARM: OMAP2+ hwmod: Allow modules to disable HW_AUTO
> 
> Introduce HWMOD_CLKDM_NOAUTO flag that allows the hwmod's
> clockdomain to be prevented from HW_AUTO while the hwmod is active.
> 
> This is needed to workaround some modules which don't function
> correctly with HW_AUTO. e.g. DCAN on DRA7.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> [nsekhar@ti.com: rebased to v4.9 kernel]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> v2:
> - add comment explaining why we don't call clkdm_deny_idle() in _idle()

Thanks for updating it, applying all four into omap-for-v4.12/soc.

Tony
