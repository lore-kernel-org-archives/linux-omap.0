From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am4372: fix irq type for arm twd and global
 timer
Date: Wed, 27 Jan 2016 08:47:37 -0800
Message-ID: <20160127164737.GK19432@atomide.com>
References: <1451310724-29454-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1451310724-29454-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [151228 05:52]:
> As per ARM documentation
> PPI(0) ID27 - global timer interrupt is rising-edge sensitive.
> PPI(2) ID29 - twd interrupt is rising-edge sensitive.
> 
> and the same is proved by GIC distributor register value
> GIC_DIST_CONFIG(0xC04) = 0x7DC00000.
> 
> Hence, set IRQ triggering type to IRQ_TYPE_EDGE_RISING
> for ARM TWD and Global timers.

Applying into omap-for-v4.5/fixes thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
