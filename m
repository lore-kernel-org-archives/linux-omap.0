From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH] arm: omap2plus: kill section mismatches
Date: Thu, 7 Apr 2011 11:23:03 +0300
Message-ID: <20110407082302.GG29038@legolas.emea.dhcp.ti.com>
References: <1302163511-32510-1-git-send-email-balbi@ti.com>
 <4D9D741D.2040304@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33095 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751992Ab1DGIXK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 04:23:10 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so833196eyx.5
        for <linux-omap@vger.kernel.org>; Thu, 07 Apr 2011 01:23:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9D741D.2040304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Apr 07, 2011 at 01:51:49PM +0530, Santosh Shilimkar wrote:
> On 4/7/2011 1:35 PM, Felipe Balbi wrote:
> >Those were very simple to fix and while we should
> >be putting effort on code consolidation, having
> >a noisy compilation is very painful and makes it
> >more difficult to see newer warnings introduced
> >by re-factoring other code.
> >
> >Signed-off-by: Felipe Balbi<balbi@ti.com>
> >---
> I did post one for section mismatch already :)
> http://www.spinics.net/lists/linux-omap/msg49557.html

oops, let's use that one instead :-)

-- 
balbi
