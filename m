From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap-usb-host: clean up pin mux setup code
Date: Wed, 8 May 2013 16:52:32 -0700
Message-ID: <20130508235232.GW32546@atomide.com>
References: <1366624673-2684-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366624673-2684-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [130422 03:02]:
> The USB host pins are named quite differently between OMAP3 and
> OMAP4+ SoCs. To make this managable in code, we create a pin mapping
> table (pin_names) that maps pin function to pin name.
> 
> This pin mapping table is populated at runtime based on a pin
> name template. Templates are provided for OMAP3 and 4 SoCs.
> 
> The setup_io_mux() function uses the pin mapping table to
> setup the pin mux.
> 
> The resulting code is a lot more clean, manageable and scalable.

I'm planning to drop all the omap4 pdata soonish. Will post some
patches after -rc1 to do that. Do you still need this patch
considering that?

Regards,

Tony
