From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 16:11:58 +0000
Message-ID: <201203191611.59064.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <201203191406.35064.arnd@arndb.de> <20120319153334.GF16389@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64968 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758123Ab2CSQMY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 12:12:24 -0400
In-Reply-To: <20120319153334.GF16389@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Thomas Abraham <thomas.abraham@linaro.org>

On Monday 19 March 2012, Russell King - ARM Linux wrote:
> Firstly, define what you mean by "the DMA parameters".  Things like burst
> size, register width, register address?  That should all be known by the
> peripheral driver and not be encoded into DT in any way - and this
> information should be passed to the DMA engine driver for the well defined
> API for that purpose.

This seems to be different for each controller, I tried to use
a generic term here. In case of stedma40 (which is probably the most
complex one today), it would be this structure:

struct stedma40_chan_cfg {
        enum stedma40_xfer_dir                   dir;
        bool                                     high_priority;
        bool                                     realtime;
        enum stedma40_mode                       mode;
        enum stedma40_mode_opt                   mode_opt;
        int                                      src_dev_type;
        int                                      dst_dev_type;
        struct stedma40_half_channel_info        src_info;
        struct stedma40_half_channel_info        dst_info;

        bool                                     use_fixed_channel; 
        int                                      phy_channel;
};

All these fields are set up by the platform code today, not by
the device driver, so it would be logical to have them represented
in the device tree, though some of the fields might turn out to
be in the wrong place already.

> Secondly, there are platforms (Samsung) where peripherals are connected
> to more than one DMA controller, and either DMA controller can be used -
> I'm told by Jassi that there's reasons why you'd want to select one or
> other as the target at runtime.

How common is that? If there are only a few drivers that have this
requirement, we could have this represented in the driver binding, by
listing multiple channels and giving the device the choice.

A possible way to deal with this is to list all the alternatives
in the device tree and using the dma-names property to name them,
giving the same name to those that we need to pick one of.

> I think instead, rather than trying to fix this now, we persist with what
> we have, but organize an effort to clean up and restructure the DMA engine
> code so that:
> 
> (a) things like the Samsung, and ARM board oddities can be easily dealt
>  with in a driver independent manner.
> (b) get rid of all the duplicated functionality between each different
>  DMA engine implementation, separating this out into core code, and
>  simplifying the drivers.

At that point, we definitely need to involve the dmaenigne maintainers
who have unfortunately not been on Cc for the whole discussion so
far.

I actually hope that a lot of the issues go away if we come up with
good device tree bindings that can cover the existing corner cases
while providing a simple interface for device drivers to use.

> The big problem I see is that if we try to represent the existing
> solution in DT, we're going to get locked into that way of doing things
> and then any major restructuring of the DMA engine stuff will become an
> impossibility - especially if we start specifying things by DMA request
> signal numbers on DMA engines.

Note that Thomas Abraham has already introduced a DT support for
pl330, which is sadly seems to be anything but generic.

	Arnd
