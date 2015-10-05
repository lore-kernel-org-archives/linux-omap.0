From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 03/11] arm: omap2: timer: remove __omap_gptimer_init()
Date: Mon, 5 Oct 2015 04:01:45 -0700
Message-ID: <20151005110144.GW23801@atomide.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443559446-26969-4-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, daniel.lezcano@linaro.org, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150929 13:48]:
> since now we can reuse __omap_sync32k_timer_init()
> for OMAP3-like devices, we can safely remove
> __omap_gptimer_init().

There are tons of boards out there that need to use the
high frequency ocillator source with gptimer because of the
beagleboard B4 and earlier issue #7. So we need to provide
both options for the boards. Using the high frequency
oscillator source blocks deeper idle states in hardware
so those devices are usable.

Regads,

Tony
