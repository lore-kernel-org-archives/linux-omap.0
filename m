From: Tony Lindgren <tony@atomide.com>
Subject: Re: [v2] musb: omap2430: do not assume balanced enable()/disable()
Date: Fri, 9 Sep 2016 13:51:04 -0700
Message-ID: <20160909205103.sqonsprxbb7i6zth@atomide.com>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
 <1946895.vi37Pmm05X@avalon>
 <20160909200803.4cngkfhgkki4e7o3@atomide.com>
 <1538976.gm2HNISj8k@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538976.gm2HNISj8k@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [160909 13:21]:
> On Friday 09 Sep 2016 13:08:03 Tony Lindgren wrote:
> > This patch has a side effect of fixing the issue by breaking PM
> > runtime, not a good fix as discussed.
> 
> How exactly is it worse breaking runtime PM than breaking USB gadget 
> completely ? :-)

Yeah sorry to break it, I obviously did not test it on all platforms :(
I'm mostly using omap3 with the 2430 glue layer and am335x for the
dsps glue layer and did not know that omap4 is broken. I guess I've
recently just used the EHCI ports on panda.

> The issue here is that the .disable() platform operation is called by musb 
> with the PHY already powered off, leading to the PHY power reference count 
> becoming negative. The next call to the .enable() operation restores the 
> reference count to 0 without enabling the PHY.

Well for the phy-twl4030-usb.c, AFAIK the right fix is to fix the PHY
driver as done in "[PATCH v2] phy-twl4030-usb: initialize charging-related
stuff via pm_runtime". I suspect something similar is happening here
also with the omap4 legacy phy.

> Feel free to send me a better fix and I will test it.

Yeah will do, hang on.

Tony
