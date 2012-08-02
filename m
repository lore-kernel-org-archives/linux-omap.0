From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Fri, 03 Aug 2012 00:08:43 +0200
Message-ID: <501AFA6B.4010005@gmail.com>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343909574-15633-1-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Ravi,

On 02.08.2012 14:12, Ravi Babu wrote:
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

I would like to test these patches on a custom AM33xx board, but I'm
having trouble applying them. I am based on Linus' master tree, and "git
am" fails for drivers/usb/musb/musb_dsps.c. The commits I got for that
file are:

ded017ee6 usb: phy: fix return value check of usb_get_phy
662dca54c usb: otg: support for multiple transceivers by a single controller
721002ec1 usb: otg: utils: rename function name in OTG utils
9ecb88752 usb: musb: Add support for ti81xx platform

I wonder which branch you are based on and which tree those patches
should go thru eventually.


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
