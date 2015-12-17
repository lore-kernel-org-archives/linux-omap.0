From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v02 0/2] ARM: DTS: am33xx/am437x: Use the new eDMA
 bindings
Date: Thu, 17 Dec 2015 09:48:44 -0800
Message-ID: <20151217174844.GT23396@atomide.com>
References: <1450359217-3038-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450359217-3038-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: arnd-r2nGTMty4D4@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [151217 05:33]:
> Hi,
> 
> Changes since v1:
> - Updated to use the non 16bit arrays [1]
> - send the two patch as a series
> 
> [1]
> As it has been discussed earlier:
> https://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg122117.html
> 
> the DT bindings has been changes compared to what we had in 4.4-rc1: the arrays
> now don't have the 16bit type.
> The changes are now merged to mainline and Vinod provided us a branch:
> 
> git://git.infradead.org/users/vkoul/slave-dma.git fix/edma
> 
> Which is based on 4.4-rc1 and only contains the two patch for changing the eDMA
> bindings.

Great, I'll merge the fix/edma also into omap-for-v4.5/dt and apply
your two patches.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
