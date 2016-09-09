From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [v2] musb: omap2430: do not assume balanced enable()/disable()
Date: Fri, 09 Sep 2016 23:21:50 +0300
Message-ID: <1538976.gm2HNISj8k@avalon>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info> <1946895.vi37Pmm05X@avalon> <20160909200803.4cngkfhgkki4e7o3@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909200803.4cngkfhgkki4e7o3@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Friday 09 Sep 2016 13:08:03 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [160909 12:27]:
> > On Wednesday 03 Aug 2016 17:38:51 Andreas Kemnade wrote:
> >> The code assumes that omap2430_musb_enable() and
> >> omap2430_musb_disable() are called in a balanced way.
> >> That fact is broken by the fact that musb_init_controller() calls
> >> musb_platform_disable() to switch from unknown state to off state
> >> on initialisation.
> >> 
> >> That means that phy_power_off() is called first so that
> >> phy->power_count gets -1 and the phy is not enabled on phy_power_on().
> >> So when usb gadget is started the phy is not powered on.
> >> Depending on the phy used that caused various problems.
> >> Besides of causing usb problems, that can also have side effects.
> >> 
> >> In the case of using the phy_twl4030, that prevents also charging
> >> the battery via usb (using twl4030_charger) and so makes further
> >> kernel debugging hard.
> >> The problem was seen with 4.7 on an openphoenux gta04. It has a DM3730
> >> SoC and a TPS65950 companion.  phy->power never became 1
> >> and so the usb did get powered on.
> >> 
> >> The patch prevents phy_power_off() from being called when
> >> it is already off.
> >> 
> >> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > 
> > This fixes USB gadget operation on the Panda board.
> > 
> > Fixes: a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling for
> > 2430 glue layer")
> > Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> This patch has a side effect of fixing the issue by breaking PM
> runtime, not a good fix as discussed.

How exactly is it worse breaking runtime PM than breaking USB gadget 
completely ? :-)

The issue here is that the .disable() platform operation is called by musb 
with the PHY already powered off, leading to the PHY power reference count 
becoming negative. The next call to the .enable() operation restores the 
reference count to 0 without enabling the PHY.

Feel free to send me a better fix and I will test it.

-- 
Regards,

Laurent Pinchart
