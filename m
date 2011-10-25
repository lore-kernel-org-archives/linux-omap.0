From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 3/7] arm: perf: support device with other non-irq
 resources
Date: Tue, 25 Oct 2011 02:44:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110250242130.27118@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-4-git-send-email-ming.lei@canonical.com> <20111024150814.GA4771@mudshark.cambridge.arm.com> <CACVXFVOzQ0QEnaAb=mLFdr7AU3H3TsT=wXcNgtqeUGVLXahd4Q@mail.gmail.com>
 <20111025083420.GA6184@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42850 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab1JYIon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Oct 2011 04:44:43 -0400
In-Reply-To: <20111025083420.GA6184@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Ming Lei <ming.lei@canonical.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 25 Oct 2011, Will Deacon wrote:

> Hurrah! If you can get the OMAP / hwmod bits acked by the OMAP guys then I'm
> happy to take the perf and PMU changes into my tree.

I'd suggest that you take the perf/PMU stuff yourself if you are happy 
with it, and then we'll deal with the OMAP bits ourselves, since it looks 
like they aren't dependent on each other, and the OMAP parts will need 
changes.


- Paul
