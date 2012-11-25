From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP build now completely broken in latest arm-soc
Date: Sun, 25 Nov 2012 14:07:01 +0000
Message-ID: <20121125140701.GW3332@n2100.arm.linux.org.uk>
References: <20121125093704.GV3332@n2100.arm.linux.org.uk> <CAOesGMgvGxfghFbyki7aXE8dVbAA7QQP6nwBKhzHftngGRi0Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50272 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab2KYOMX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Nov 2012 09:12:23 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMgvGxfghFbyki7aXE8dVbAA7QQP6nwBKhzHftngGRi0Tw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, arm@kernel.org

On Sun, Nov 25, 2012 at 05:56:58AM -0800, Olof Johansson wrote:
> Hi,
> 
> On Sun, Nov 25, 2012 at 1:37 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Not much more to say...
> >
> > arch/arm/plat-omap/i2c.c:35:1: error: expected identifier or '(' before '<<' token
> 
> Hmm. In for-next, line 35 is a blank line.
> 
> Could this be because of a merge conflict in your local version? This
> is one of the files that has conflicts with mainline right now; I'll
> look to see if we can resolve those in our tree later today.

Hmm, it looks like a merge conflict which didn't get fixed up... and
looking at it, it's beyond what I'd call trivial to fix.

So I'll shut down the build system until that can be resolved properly;
as OMAP is effectively unbuildable there's not much point it running the
builds.
