From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Sat, 20 Aug 2011 16:30:00 +0100
Message-ID: <20110820152959.GA22424@opensource.wolfsonmicro.com>
References: <20110820062543.GA5011@opensource.wolfsonmicro.com>
 <Pine.LNX.4.44L0.1108200943500.26680-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54646 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752208Ab1HTPaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Aug 2011 11:30:04 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1108200943500.26680-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Sat, Aug 20, 2011 at 09:48:25AM -0400, Alan Stern wrote:

> No, I as wasking about driver- and subsystem-specific interfaces to
> userspace that translate into things users are already doing.  Kevin's
> example was a touchscreen (although that was really an example of
> setting a power usage level, not a latency constraint).  Do you have
> any others?

Any sort of media streaming would be an obvious example - the
application picks the amount of data it buffers and how often it's
notified of progress depending on the usage which then controls how
quickly the system needs to handle things.
