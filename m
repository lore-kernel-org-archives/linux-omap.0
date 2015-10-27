From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 00/14] dmaenigne: edma/ti-crossbar: fixes, new bindings
Date: Tue, 27 Oct 2015 10:24:53 +0900
Message-ID: <20151027012452.GB11691@vkoul-mobl.iind.intel.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 16, 2015 at 10:17:58AM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Comments in the memcpy optimization patch extended
> - The crossbar patch has been improved:
>  - debug prints changed
>  - fallback xbar parameters now type specific as the fallback values for DRA7
>    are not valid for AM33xx crossbar.
> - New patch for Kconfig to select the crossbar in case the eDMA is used on OMAP
>   platforms
> 
I am applying this series and Please note that this has ARM patches which i
have not heard any objections so applying :)

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
