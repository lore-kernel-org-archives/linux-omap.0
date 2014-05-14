From: Zhuang Jin Can <jin.can.zhuang@intel.com>
Subject: Re: [PATCH] usb: dwc3: ep0: fix delayed status is queued too early
Date: Tue, 13 May 2014 23:28:54 -0400
Message-ID: <20140514032854.GB16153@intel.com>
References: <20140507215344.GH19925@intel.com>
 <20140514014551.GA16153@intel.com>
 <20140513150534.GF1151@saruman.home>
Reply-To: jin.can.zhuang@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47391 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbaEMP2y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 May 2014 11:28:54 -0400
Content-Disposition: inline
In-Reply-To: <20140513150534.GF1151@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, liping.zhou@intel.com, david.a.cohen@linux.intel.com

On Tue, May 13, 2014 at 10:05:34AM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Tue, May 13, 2014 at 09:45:51PM -0400, Zhuang Jin Can wrote:
> > Hi Balbi,
> > 
> > Do you have any comment for this patch?
> 
> do you have an easy test-case which I can use to validate on my end ?
The issue was reproduced on a multi-core platform with f_mass_storage and
adb (f_fs gadget) enabled. The enumeration will fail when it's connected
to PC via USB2 cable.

You may not be able to use adb (I think), but do replacing it with some other
gadgets (e.g.f_rndis). And f_mass_storage gadget should be the first
interface in the composite device (this is important to larger the
chance to reproduce the issue, the delayed status request will be queued
while irq is still enabling other endpoints of other gadgets).

Best Regards
Jincan


