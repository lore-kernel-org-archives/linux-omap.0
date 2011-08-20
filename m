From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Sat, 20 Aug 2011 18:34:34 +0200
Message-ID: <201108201834.34741.rjw@sisk.pl>
References: <20110820062543.GA5011@opensource.wolfsonmicro.com> <Pine.LNX.4.44L0.1108200943500.26680-100000@netrider.rowland.org> <20110820152959.GA22424@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54591 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198Ab1HTQcu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Aug 2011 12:32:50 -0400
In-Reply-To: <20110820152959.GA22424@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Saturday, August 20, 2011, Mark Brown wrote:
> On Sat, Aug 20, 2011 at 09:48:25AM -0400, Alan Stern wrote:
> 
> > No, I as wasking about driver- and subsystem-specific interfaces to
> > userspace that translate into things users are already doing.  Kevin's
> > example was a touchscreen (although that was really an example of
> > setting a power usage level, not a latency constraint).  Do you have
> > any others?
> 
> Any sort of media streaming would be an obvious example - the
> application picks the amount of data it buffers and how often it's
> notified of progress depending on the usage which then controls how
> quickly the system needs to handle things.

Well, what about other types of devices?
