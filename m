From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Sat, 20 Aug 2011 00:14:19 +0100
Message-ID: <20110819231419.GA3981@sirena.org.uk>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
 <201108082331.35853.rjw@sisk.pl>
 <1313723464.19990.124.camel@finisterre.wolfsonmicro.main>
 <201108192242.20471.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:37445 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab1HSXOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 19:14:25 -0400
Content-Disposition: inline
In-Reply-To: <201108192242.20471.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Fri, Aug 19, 2011 at 10:42:20PM +0200, Rafael J. Wysocki wrote:

> I really wouldn't like the discussion to go in circles.

> First, please tell me what in particular you are objecting to,
> because I don't think that's any of the patches that have been
> sent to the linux-pm list to date.

The original issue that Kevin raised and CCed me in on was the idea of
exposing raw per-device wakeup latency constraints to userspace; it
seems much better to expose user level requirements via subsystem
interfaces and let the subsystem and driver translate these into actual
wakeup latency constraints:

  https://lists.linux-foundation.org/pipermail/linux-pm/2011-August/032422.html
  https://lists.linux-foundation.org/pipermail/linux-pm/2011-August/032428.html

This is much easier for users as it translates into something they're
actually doing (and in most cases the driver can make it Just Work) and
it means that off the shelf applications will end up tuning the system
appropriately by themselves.  I'm additionally concerned that if we
expose this stuff directly to userspace that's an open invitation to
driver authors to not even bother trying to make the kernel figure this
stuff out by itself and to instead tie the system together with magic
userspace.

In embedded systems this approach seems tractable and reasonable.  Your
concern seems to be that for PC class systems it's not going to be
possible to figure out the required latencies in the drivers reliably
enough to be useful so we'll need to punt to userspace and let users
tune their systems that way.  I can't speak for Kevin but I think my
preferred solution there would be to make this a feature of the relevant
systems rather than a standard feature that users can expect in the
Linux power management framework.

I think at some point in the discussion (you've not quoted any of the
text of the discussion for context...) you started thinking about other
constraints, different considerations may apply to those, I don't know
what other constraints we have.
