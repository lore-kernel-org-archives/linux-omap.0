From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Sun, 21 Aug 2011 20:05:53 +0200
Message-ID: <201108212005.53898.rjw@sisk.pl>
References: <20110820062543.GA5011@opensource.wolfsonmicro.com> <201108202114.37502.rjw@sisk.pl> <20110821082509.GA10380@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55592 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab1HUSEH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Aug 2011 14:04:07 -0400
In-Reply-To: <20110821082509.GA10380@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Sunday, August 21, 2011, Mark Brown wrote:
> On Sat, Aug 20, 2011 at 09:14:37PM +0200, Rafael J. Wysocki wrote:
> 
> > I guess you mean the driver here and I'm not really sure it can.
> > For instance, the driver may not know what configuration it works in,
> > e.g. is there a power domain or a hierarchy of those and how much time
> > it takes to power them all down and up and what the power break even is.
> 
> I don't understand why the driver would need to know what situation it's
> in.  I'd been working on the basis that the idea was that the driver
> said what the constraints it has are and then some code with a more
> system wide view would make the actual decisions for things outside the
> driver domian.

That's correct, but in order to figure out a "sensible default"
the driver generally would need to know what the expectations with
respect to it are.  Otherwise it can very well generate a random
number and use that.

Thanks,
Rafael
