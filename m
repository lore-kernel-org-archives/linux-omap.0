From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while
 arch_iommu is in use
Date: Sat, 24 Sep 2011 06:44:52 -0700
Message-ID: <CAGDS+nkceS-qmdNyYmOLjEQY_SiMWodZx7SMqqWOLHzkN0xGeQ@mail.gmail.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com>
	<AANLkTikxd4kRu1+XskohhQzpqHaZTvK+afbgE-qRSOqN@mail.gmail.com>
	<201103291732.52620.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63523 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab1IXNoy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Sep 2011 09:44:54 -0400
Received: by vws1 with SMTP id 1so4778134vws.19
        for <linux-omap@vger.kernel.org>; Sat, 24 Sep 2011 06:44:53 -0700 (PDT)
In-Reply-To: <201103291732.52620.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Cohen David Abraham <david.cohen@nokia.com>

On Tue, Mar 29, 2011 at 8:32 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> I think that Sakari's patches correcty fix the problems he noticed. However,
> they won't fix one basic issue, which is that the iommu2 module won't be
> automatically pulled in when the omap3isp module is loaded. The omap3isp
> driver will then fail to probe the device. That's better than crashing though.
>
> One possible solution for that is to turn the tristate option for iommu2 into
> a bool option. I've also read a couple of times that the kernel provides a
> standard iommu API. Maybe switching to it would help.

I'm attempting to get support for the Gumstix Caspa image sensor
(based on mt9v032) working with the 3.0 release.

I'm running into the issue described above -- the omap3-isp module
loads but fails to probe the device.

I've tried the tristate->bool option change and find that it does
allow me to proceed further, but the omap3-isp module is no longer
loaded automatically when I call omap3_init_camera in the board file.
I have to manually modprobe it. I then see the sensor module
successfully probed and the video devices created (though not
functioning yet).

Are you aware of a better way to do this?  I see lots of patches for
iommu since this thread.  Would I be better off waiting for 3.1 and
trying that, or will final resolution of this issue come even later?

Best regards,

Steve
