From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 15/17] memory: omap-gpmc: Support WAIT pin edge
 interrupts
Date: Mon, 11 Apr 2016 10:03:44 -0500
Message-ID: <20160411150344.GA3549@rob-hp-laptop>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
 <1460023715-19332-16-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460023715-19332-16-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 07, 2016 at 01:08:33PM +0300, Roger Quadros wrote:
> OMAPs can have 2 to 4 WAITPINs that can be used as edge triggered
> interrupts if not used for memory wait state insertion.
> 
> Support these interrupts via the gpmc IRQ domain.
> 
> The gpmc IRQ domain interrupt map is:
> 
> 0 - NAND_fifoevent
> 1 - NAND_termcount
> 2 - GPMC_WAIT0 edge
> 3 - GPMC_WAIT1 edge, and so on
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  .../bindings/memory-controllers/omap-gpmc.txt      |   5 +-

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/memory/omap-gpmc.c                         | 106 +++++++++++++++++----
>  2 files changed, 92 insertions(+), 19 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
