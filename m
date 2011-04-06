From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while arch_iommu is in use
Date: Wed, 6 Apr 2011 10:55:44 +0200
Message-ID: <201104061055.44640.laurent.pinchart@ideasonboard.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com> <201104051323.42401.laurent.pinchart@ideasonboard.com> <BANLkTi=Ybkotcpu7Hp1zvGJ-dd0huUHcBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42560 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965Ab1DFIzp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Apr 2011 04:55:45 -0400
In-Reply-To: <BANLkTi=Ybkotcpu7Hp1zvGJ-dd0huUHcBA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Cohen David Abraham <david.cohen@nokia.com>

Hi David,

On Tuesday 05 April 2011 13:54:09 David Cohen wrote:
> On Tue, Apr 5, 2011 at 2:23 PM, Laurent Pinchart wrote:

[snip]

> > We only have iommu2.ko at the moment. I've heard about an iommu1.ko being
> > worked on, but I don't have more information. We don't know whether the
> > OMAP5 will be able to use the same IOMMU implementation. Without more
> > information, I'm quite reluctant to design and implement a generic
> > solution that will end up being useless because we missed information in
> > the design stage.
> 
> One implementation belongs to mach-omap1 and other to mach-omap2. Not sure
> if it's a good plan to get them together.

My point is that we have a single implementation at the moment. Not one in 
mach-omap1 and one in mach-omap2, just one. I don't like solving problems with 
generic solutions when there's a single use case.

> IMO the third option from Laurent solves the issue for now and don't make it
> more difficult to implement a better standard to OMAP.

-- 
Regards,

Laurent Pinchart
