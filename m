From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP4: twl-common: Support for additional
 devices on i2c1 bus
Date: Tue, 7 Aug 2012 00:20:42 -0700
Message-ID: <20120807072041.GL11011@atomide.com>
References: <1342168682-15888-1-git-send-email-peter.ujfalusi@ti.com>
 <500D0FA5.3020208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:11066 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab2HGHUp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 03:20:45 -0400
Content-Disposition: inline
In-Reply-To: <500D0FA5.3020208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120723 01:52]:
> Hi Tony,
> 
> On 07/13/2012 10:38 AM, Peter Ujfalusi wrote:
> > On OMAP4 the i2c1 bus is dedicated for the PMIC and audio related devices.
> > Manufacturers can opt to use different codec than twl6040 and also can add
> > audio related IC to the bus (external amplifier for example on SDP4430).
> > 
> > Make it possible to add differnet set of additional devices to i2c1 bus on
> > OMAP4 boards.
> 
> Would it be possible to queue this patch for 3.6?

Sorry things were getting already too complex for v3.6 merge window..
So v3.7 it will be. Looks like this need to be updated against v3.6-rc1
to apply.

Regards,

Tony
