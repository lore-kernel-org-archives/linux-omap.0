From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Mon, 13 Jun 2011 13:22:22 +0100
Message-ID: <20110613122221.GA19552@opensource.wolfsonmicro.com>
References: <20110610155707.GN26436@opensource.wolfsonmicro.com> <201106102227.25391.rjw@sisk.pl> <20110611114239.GC2738@opensource.wolfsonmicro.com> <201106112256.37012.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47373 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752125Ab1G0MT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jul 2011 08:19:57 -0400
Content-Disposition: inline
In-Reply-To: <201106112256.37012.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org

On Sat, Jun 11, 2011 at 10:56:36PM +0200, Rafael J. Wysocki wrote:
> On Saturday, June 11, 2011, Mark Brown wrote:

> > that's a very large proportion of the embedded space.  It really feels
> > like we could be doing a better job for drivers using these buses,
> > there's a lot of similarities in what many of them need but I can never
> > find the time to get my head round it confidently enough to actually
> > propose anything.

> I agree.  That's one of the reasons why I introduced the struct dev_power_domain
> thing a while ago and the generic PM domains patchset I've just posted is a step
> in that direction.

Ah, right - I'd not been thinking of those in the context of
simplifications for basic devices, I'd been thinking of them as being
for CPUs with more complex power domains that need managing.  I'll keep
more of an eye on what's going on there.
