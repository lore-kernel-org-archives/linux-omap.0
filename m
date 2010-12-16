From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: ensure all sched_clock() implementations are
	notrace marked
Date: Thu, 16 Dec 2010 17:03:01 +0000
Message-ID: <20101216170301.GU9937@n2100.arm.linux.org.uk>
References: <E1PT92Y-0004Ba-64@rmk-PC.arm.linux.org.uk> <AANLkTimGHSqO=QwESp98UBK28yawdiq+kURU=nwau27G@mail.gmail.com> <20101216155750.GA28126@n2100.arm.linux.org.uk> <AANLkTikLoU-L4YF_FtG4Q8Qh+66zToun5p2LhgYyiyrv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38917 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab0LPREH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 12:04:07 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikLoU-L4YF_FtG4Q8Qh+66zToun5p2LhgYyiyrv@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Imre Kaloz <kaloz@openwrt.org>, Lennert Buytenhek <kernel@wantstofly.org>, Krzysztof Halasa <khc@pm.waw.pl>

On Thu, Dec 16, 2010 at 09:52:56PM +0530, Rabin Vincent wrote:
> Yes, I now see U300 no longer needs the notrace addition.  It still
> could do with the #include <linux/sched.h> addition though, which was
> also being done as part of that patch.

Okay, added to u300, tegra, iop, and omap which weren't including
linux/sched.h explicitly.
