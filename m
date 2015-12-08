From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
Date: Mon, 7 Dec 2015 16:19:43 -0800
Message-ID: <20151208001943.GT23396@atomide.com>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449225915-28879-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [151204 02:46]:
> +
> +			ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
> +				   <&edma_tptc2 0>;
> +
> +			ti,edma-memcpy-channels = /bits/ 16 <20 21>;

Is this safe to change to just ti,edma-memcpy-channels = <20 21> as
suggested by Arnd?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
