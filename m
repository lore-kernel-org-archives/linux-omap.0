From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while arch_iommu is in use
Date: Mon, 26 Sep 2011 18:19:17 +0200
Message-ID: <201109261819.18442.laurent.pinchart@ideasonboard.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com> <201103291732.52620.laurent.pinchart@ideasonboard.com> <CAGDS+nkceS-qmdNyYmOLjEQY_SiMWodZx7SMqqWOLHzkN0xGeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46717 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab1IZQTN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 12:19:13 -0400
In-Reply-To: <CAGDS+nkceS-qmdNyYmOLjEQY_SiMWodZx7SMqqWOLHzkN0xGeQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Cohen David Abraham <david.cohen@nokia.com>

Hi Steve,

On Saturday 24 September 2011 15:44:52 Steve Sakoman wrote:
> On Tue, Mar 29, 2011 at 8:32 AM, Laurent Pinchart
> 
> <laurent.pinchart@ideasonboard.com> wrote:
> > I think that Sakari's patches correcty fix the problems he noticed.
> > However, they won't fix one basic issue, which is that the iommu2 module
> > won't be automatically pulled in when the omap3isp module is loaded. The
> > omap3isp driver will then fail to probe the device. That's better than
> > crashing though.
> > 
> > One possible solution for that is to turn the tristate option for iommu2
> > into a bool option. I've also read a couple of times that the kernel
> > provides a standard iommu API. Maybe switching to it would help.
> 
> I'm attempting to get support for the Gumstix Caspa image sensor
> (based on mt9v032) working with the 3.0 release.
> 
> I'm running into the issue described above -- the omap3-isp module
> loads but fails to probe the device.
> 
> I've tried the tristate->bool option change and find that it does
> allow me to proceed further, but the omap3-isp module is no longer
> loaded automatically when I call omap3_init_camera in the board file.

That's weird, it should if udev is setup properly.

> I have to manually modprobe it. I then see the sensor module
> successfully probed and the video devices created (though not
> functioning yet).
> 
> Are you aware of a better way to do this?  I see lots of patches for
> iommu since this thread.  Would I be better off waiting for 3.1 and
> trying that, or will final resolution of this issue come even later?

The tristate -> bool change (which will likely be part of a much bigger change 
set) will come later.

-- 
Regards,

Laurent Pinchart
