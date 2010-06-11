From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/3] arm: omap1/2/3/4: convert 32k-sync driver to a
 platform_driver
Date: Fri, 11 Jun 2010 20:54:50 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5AB138E@dbde02.ent.ti.com>
References: <20100407072102.GU16297@nokia.com>
 <1270634244-22741-3-git-send-email-felipe.balbi@nokia.com>
 <87bpdvfdoy.fsf@deeprootsystems.com> <20100407173420.GA11943@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37243 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781Ab0FKPY7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 11:24:59 -0400
In-Reply-To: <20100407173420.GA11943@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe
> Balbi
> Sent: Wednesday, April 07, 2010 11:04 PM
> To: ext Kevin Hilman
> Cc: Balbi Felipe (Nokia-D/Helsinki); Linux OMAP Mailing List
> Subject: Re: [PATCH 3/3] arm: omap1/2/3/4: convert 32k-sync driver to a platform_driver
> 
> On Wed, Apr 07, 2010 at 06:08:13PM +0200, ext Kevin Hilman wrote:
> >felipe.balbi@nokia.com writes:
> >
> >> From: Felipe Balbi <felipe.balbi@nokia.com>
> >>
> >> Convert the omap32k clocksource driver into a platform_driver
> >> and while at that, also remove the ifdeferry around the code.
> >>
> >> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> >
> >I'm OK with this for now.  Ideally, this would be further converted to
> >use hwmod + omap_device to automatcially created the platform_devices
> >for you.
> 
> Yeah. I was asking Paul about it today. I can send as a follow up patch
> on next week.
> 
Is there a newer version of this series already available/posted??
Sorry I missed it.

Regards
Santosh
