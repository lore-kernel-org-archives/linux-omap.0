From: "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Fri, 3 Aug 2012 00:54:24 +0000
Message-ID: <6C6B28D4DC342643927BEAFCE8707BF63E9DB6AE@DBDE01.ent.ti.com>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com>
 <501AFA6B.4010005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <501AFA6B.4010005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi

> 
> On 02.08.2012 14:12, Ravi Babu wrote:
> > This series of patches adds,
> > a) Multi instances support in musb driver
> > b) DT support for musb_dsps glue layer
> > c) DT support for NOP transceiver
> > 
> > AM33xx and TI81xx has dual musb controller and has two usb 
> PHY of same type.
> > This patch series uses 'phandle' based API 
> > devm_usb_get_phy_by_phandle() to get the PHY of same type. This API 
> > support is being added by Kishon's patch discussed at [1]
> > 
> > The series applies to linux-omap (master branch)
> > 	+ Vaibhav baseport patches on his tree at [3]
> > 	+ Kishon's multi phy patches on Felipe's branch 'xceiv'
> > 	+ Kishon's patch on phandle at [1]
> > 	+ AM33xx musb glue compile and bugfix patches at [4], 
> [5], [6] and [7]
> > 	+ Damodar's recent patch at [2]
> > 
> > and have been tested on Beaglebone board.

Have you applied the above patches before applying these patches.

Ravi Babu

> 
> I would like to test these patches on a custom AM33xx board, 
> but I'm having trouble applying them. I am based on Linus' 
> master tree, and "git am" fails for 
> drivers/usb/musb/musb_dsps.c. The commits I got for that file are:
> 
> ded017ee6 usb: phy: fix return value check of usb_get_phy 
> 662dca54c usb: otg: support for multiple transceivers by a 
> single controller
> 721002ec1 usb: otg: utils: rename function name in OTG utils
> 9ecb88752 usb: musb: Add support for ti81xx platform
> 
> I wonder which branch you are based on and which tree those 
> patches should go thru eventually.
> 
> 
> Thanks,
> Daniel
> 
> --
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
