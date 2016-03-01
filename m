From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/11] ARM: DRA7: hwmod: Add data for eDMA tpcc, tptc0,
 tptc1
Date: Tue, 1 Mar 2016 08:55:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603010855210.14948@utopia.booyaka.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com> <1456411827-23962-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456411827-23962-3-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 25 Feb 2016, Peter Ujfalusi wrote:

> Add hwmod data for the eDMA blocks:
>  - TPCC: Third-party channel controller
>  - TPTC0: Third-party transfer controller 0
>  - TPTC1: Third-party transfer controller 1
> 
> The TPCC is following it's clock and power domain. This means that
> the hwmod can not control it's status.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

Thanks, queued.


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
