From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Mon, 24 Jan 2011 21:52:13 +0000
Message-ID: <20110124215213.GA27044@n2100.arm.linux.org.uk>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk> <20110123174814.GI30094@n2100.arm.linux.org.uk> <20110124201731.GC13589@atomide.com> <20110124202629.GE13589@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34061 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab1AXVwT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 16:52:19 -0500
Content-Disposition: inline
In-Reply-To: <20110124202629.GE13589@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 24, 2011 at 12:26:29PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [110124 12:16]:
> > 
> > So far tested on zoom3 only, but the following gets it booting
> > on top of your patch.
> 
> Looks like there are some other patches needed too.. At least
> omap4 still fails with these.

>From what I remember, the problem I saw on OMAP4 was hwmod related as
it seemed to be using ioremap() - which with its initialization moved
before memory allocators were up and running causes an oops.
