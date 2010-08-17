From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Tue, 17 Aug 2010 16:40:35 +0100
Message-ID: <20100817154035.GD20325@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com> <20100817135205.GC20325@n2100.arm.linux.org.uk> <20100817141210.GJ12184@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45914 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757467Ab0HQPkq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 11:40:46 -0400
Content-Disposition: inline
In-Reply-To: <20100817141210.GJ12184@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

On Tue, Aug 17, 2010 at 05:12:11PM +0300, Tony Lindgren wrote:
> Great, will give it a try hopefully tomorrow. Sounds like that's the way
> to deal with fixing up things when booting up older UP ARMv6 without the
> 32v6 support :)

What I've also been debating about is adding another word to the
smpalt structure, that being a set of flags which denote the situation
where the alternative should be used.

That means we can use it to do individual word replacements for SMP vs
UP, ARMv6 vs ARMv6k etc.
