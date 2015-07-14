From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH - resend for 4.2-rc2] ARM: DTS: dra7x: Integrate sDMA
 crossbar
Date: Tue, 14 Jul 2015 04:15:57 -0700
Message-ID: <20150714111557.GT17550@atomide.com>
References: <1435755149-10328-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435755149-10328-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [150701 05:54]:
> The sDMA requests are routed through the DMA crossbar and without the
> crossbar only peripherals using DMA request 0-127 can be used.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> ---
> Hi Tony,
> 
> as you have suggested: http://permalink.gmane.org/gmane.linux.ports.arm.omap/125999
> the DTS change has not been taken by Vinod.
> Now that the dmaengine pull request is in for 4.2 it would be great if you could
> pick up the DTS part of the series and send it for -rc2.

Thanks, looks like I also had the original patch still tagged.
Applying this one instead although they look the same.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
