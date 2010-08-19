From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Thu, 19 Aug 2010 11:20:25 +0100
Message-ID: <20100819102025.GA32151@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com> <20100817135205.GC20325@n2100.arm.linux.org.uk> <20100817141210.GJ12184@atomide.com> <20100817154035.GD20325@n2100.arm.linux.org.uk> <20100819073810.GR12184@atomide.com> <4C6CFBAF.6020407@canonical.com> <20100819095705.GU12184@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45993 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab0HSKUk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 06:20:40 -0400
Content-Disposition: inline
In-Reply-To: <20100819095705.GU12184@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Aug 19, 2010 at 12:57:06PM +0300, Tony Lindgren wrote:
> Looks like something is not quite right with smp_on_up part of __fixup_smp,
> returning early before smp_on_up does not produce that.

It's probably overwriting some register it shouldn't be.  I might be
able to look at this sometime during the coming week... assuming that
the weather is as bad as they forecast and I have 'net connectivity.
