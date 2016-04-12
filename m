From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 00/13] ARM: dts: OMAP2+: Enable gpio controller for GPMC
 and add NAND ready pin
Date: Tue, 12 Apr 2016 14:28:56 -0700
Message-ID: <20160412212856.GJ5995@atomide.com>
References: <1460024740-19716-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460024740-19716-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [160407 03:26]:
> Hi Tony,
> 
> We will be adding gpio controller support to GPMC in [1].
> The GPIO controller can also be used to provide the Read/Busy#
> pin status to the OMAP2+ nand driver.
> 
> These patches enable the gpio controller in the gpmc nodes
> and add ready pin information to the NAND nodes.

Thanks applying all into omap-for-v4.7/dt.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
