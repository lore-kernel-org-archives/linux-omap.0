From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am437x: pixcir_tangoc: use correct flags for
 irq types
Date: Wed, 27 Jan 2016 08:56:41 -0800
Message-ID: <20160127165641.GL19432@atomide.com>
References: <1451310759-29536-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1451310759-29536-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [151228 05:53]:
> Now IRQs for Pixcir Tangoc touchscreen are defined using
> IRQ_TYPE_NONE in am437x-gp-evm.dts and am43x-epos-evm.dts wich
> do not correspond HW.
> 
> Hence, update am437x-gp-evm.dts and am43x-epos-evm.dts files
> and use correct flag IRQ_TYPE_EDGE_FALLING for irq types.
> 
> While here, remove duplicated irq declaration for pixcir_ts@5c node
> in am437x-gp-evm.dts.

Applying into omap-for-v4.5/fixes thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
