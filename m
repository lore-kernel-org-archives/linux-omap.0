From: Christopher Harvey <charvey-S5bRKkedoTbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Wed, 15 Aug 2012 10:39:05 -0400
Message-ID: <20120815143905.GA14088@harvey-pc.matrox.com>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1343909574-15633-1-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 02, 2012 at 05:42:43PM +0530, Ravi Babu wrote:
> This series of patches adds,
> a) Multi instances support in musb driver
> b) DT support for musb_dsps glue layer
> c) DT support for NOP transceiver
> 
> AM33xx and TI81xx has dual musb controller and has two usb PHY of same type.
> This patch series uses 'phandle' based API devm_usb_get_phy_by_phandle() to
> get the PHY of same type. This API support is being added by Kishon's patch
> discussed at [1]
> 
> The series applies to linux-omap (master branch)
> 	+ Vaibhav baseport patches on his tree at [3]
> 	+ Kishon's multi phy patches on Felipe's branch 'xceiv'
> 	+ Kishon's patch on phandle at [1]
> 	+ AM33xx musb glue compile and bugfix patches at [4], [5], [6] and [7]
> 	+ Damodar's recent patch at [2] 
> 
> and have been tested on Beaglebone board.

Any hints as to if or when this will be applied to the following
repository?

http://arago-project.org/git/projects/linux-omap3.git?p=projects/linux-omap3.git;a=summary

thanks,
Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
