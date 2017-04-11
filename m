From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: omap-usb-tll: Fix inverted bit use for USB TLL mode
Date: Tue, 11 Apr 2017 08:18:49 -0700
Message-ID: <20170411151849.GI5339@atomide.com>
References: <20170411001543.1338-1-tony@atomide.com>
 <4cd82ba4-435e-cffa-d152-98860716f38b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4cd82ba4-435e-cffa-d152-98860716f38b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [170411 00:31]:
> Hi Tony,
> 
> On 11/04/17 03:15, Tony Lindgren wrote:
> > Commit 16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")
> > added support for USB TLL, but uses OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
> > bit the wrong way. The comments in the code are mostly correct, but the
> > inverted use of OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF causes the register
> > to be enabled instead of disabled like the comments say. And the
> > idle mode should be only disabled for UTMIAUTOIDLE while ULPIAUTOIDLE
> > can be enabled.
> > 
> > This matches the TLL_CHANNEL_CONF_i register configuration for ehci-tll
> > in the Motorola Linux kernel tree for Wrigley 3G LTE modem on droid 4.
> > Without this patch the modem can only be pinged few times before it
> > stops responding. Also lsub -v output shows errors without this patch.
> 
> This patch does 2 things.
> - Fixes the bad commit by correctly disabling Bitstuffing
> - Enables ULPI Autoidle.
> 
> Is enabling ULPI autoidle required to fix the LTE modem issue? If not I'd put it
> in a separate patch.

No but it presumably saves some power. I'll resend as to patches.

Regards,

Tony
