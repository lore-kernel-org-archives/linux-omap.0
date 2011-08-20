From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Sat, 20 Aug 2011 21:14:37 +0200
Message-ID: <201108202114.37502.rjw@sisk.pl>
References: <20110820062543.GA5011@opensource.wolfsonmicro.com> <201108201834.34741.rjw@sisk.pl> <20110820170403.GA27040@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54749 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078Ab1HTTMw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Aug 2011 15:12:52 -0400
In-Reply-To: <20110820170403.GA27040@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Saturday, August 20, 2011, Mark Brown wrote:
> On Sat, Aug 20, 2011 at 06:34:34PM +0200, Rafael J. Wysocki wrote:
> > On Saturday, August 20, 2011, Mark Brown wrote:
> 
> > > Any sort of media streaming would be an obvious example - the
> > > application picks the amount of data it buffers and how often it's
> > > notified of progress depending on the usage which then controls how
> > > quickly the system needs to handle things.
> 
> > Well, what about other types of devices?
> 
> Other than the input case (which is a latency issue - there's two
> components, one is how much data is delivered for things like
> touchscreens which stream and the other is how quickly the first data is
> delivered) nothing immediately springs to mind but this may just be a
> product of what I'm most familiar with.  I don't really see this as a
> problem, for a lot of devices it's probably the case that the device can
> figure out something sensible to do without any help.

I guess you mean the driver here and I'm not really sure it can.
For instance, the driver may not know what configuration it works in,
e.g. is there a power domain or a hierarchy of those and how much time
it takes to power them all down and up and what the power break even is.

Thanks,
Rafael
