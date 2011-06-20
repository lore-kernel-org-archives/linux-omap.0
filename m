From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 03/10] omap: Move dmtimer defines to dmtimer.h
Date: Mon, 20 Jun 2011 10:56:03 +0100
Message-ID: <20110620095603.GC2082@n2100.arm.linux.org.uk>
References: <20110620091754.357.56441.stgit@kaulin> <20110620092334.357.3701.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37065 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab1FTJ4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 05:56:17 -0400
Content-Disposition: inline
In-Reply-To: <20110620092334.357.3701.stgit@kaulin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Mon, Jun 20, 2011 at 02:23:34AM -0700, Tony Lindgren wrote:
> These will be needed when dmtimer platform init code gets split
> for omap1 and omap2+. These will also be needed for separate
> sys_timer init and driver init for the rest of the hardware timers
> in the following patches. No functional changes.

If dmtimer.c is the only user of these definitions, then its quite correct
for them to be in there.  If not, they should be in dmtimer.h in the local
directory - they're private definitions to the .c file and so should not
be exported outside of that .c file.
