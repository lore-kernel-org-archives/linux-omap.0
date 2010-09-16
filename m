From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM: Handle __flush_icache_all for CONFIG_SMP_ON_UP
Date: Thu, 16 Sep 2010 18:05:20 +0100
Message-ID: <1284656720.31429.2.camel@e102109-lin.cambridge.arm.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	 <20100906104413.GD20903@n2100.arm.linux.org.uk>
	 <20100914185907.GG8647@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50698 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754338Ab0IPRFi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 13:05:38 -0400
In-Reply-To: <20100914185907.GG8647@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>

On Tue, 2010-09-14 at 11:59 -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100906 03:36]:
> > Here's my latest patch (which is combined from two patches.)
> 
> I think that patch is now done assuming the fixes I've posted are
> merged, so here's my S-O-B for the bits I've contributed:
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Anybody else care to ack?

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

