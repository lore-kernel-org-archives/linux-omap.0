From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during
 suspend
Date: Thu, 19 Jul 2012 17:30:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207191726090.14390@utopia.booyaka.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>  <1342704392-23657-8-git-send-email-t-kristo@ti.com>  <alpine.DEB.2.00.1207190842310.432@utopia.booyaka.com> <1342711907.4672.153.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34341 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab2GSXaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 19:30:12 -0400
In-Reply-To: <1342711907.4672.153.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Hi

On Thu, 19 Jul 2012, Tero Kristo wrote:

> Subject: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during
> suspend
> 
> Currently OMAP4 suspend puts all power domains to CSWR. OSWR is a deeper
> state that saves more power, but has higher latencies also. As suspend
> is considered a high-latency operation, OSWR is appropriate here.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> 
> I'll update this to next rev if one is requested.

No need, I'll add it in the local copy here.

> (Kind of hoping this set would be reaching maturity already.)

It kind of looks to me like there are two or three separate sets within 
the series.  My feeling is that Kevin should take the first two, then I 
should take the rest other than 6 and 7.  Then once those are queued, 
we can pull in 6 and 7.  Does that make sense to you?


- Paul
