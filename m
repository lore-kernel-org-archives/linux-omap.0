From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/4] mfd: twl-core: switch over to defines in twl.h
Date: Sat, 21 Aug 2010 00:11:46 +0200
Message-ID: <20100820221145.GM3650@sortiz-mobl>
References: <1282112377-1335-1-git-send-email-felipe.balbi@nokia.com>
 <1282112377-1335-3-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032422229C@dbde02.ent.ti.com>
 <20100818065905.GC11947@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03242222C7@dbde02.ent.ti.com>
 <20100818071022.GD11947@nokia.com>
 <20100818071619.GE11947@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:21844 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab0HTWLs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Aug 2010 18:11:48 -0400
Content-Disposition: inline
In-Reply-To: <20100818071619.GE11947@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "ext Gopinath, Thara" <thara@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>

Hi Felipe,

On Wed, Aug 18, 2010 at 10:16:19AM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Aug 18, 2010 at 09:10:22AM +0200, Balbi Felipe (Nokia-MS/Helsinki) wrote:
> >On Wed, Aug 18, 2010 at 09:03:44AM +0200, ext Gopinath, Thara wrote:
> >>>>No I am not talking about the key values. I was talking about the register offset
> >>>>for TWL4030_PM_MASTER_PROTECT_KEY. My question is, is it ok for it to be 0xd or 0xe.
> >>>>Earlier we were using 0xd and in the new implementation it has been changed to 0xe.
> >>
> >>Typo. Earlier we were using 0xe and in the new implementation it has
> >>been changed to 0xd.
> >
> >you're right, I'm not sure how I came up with that value since the TRM
> >shows 0x0e, maybe a copy&paste error. Will change patch 1.
> 
> ok, it's because there's no register 0x0a. And I missed that when
> defined the register space. Good catch, thanks. 
Should I expect a new patch then ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
