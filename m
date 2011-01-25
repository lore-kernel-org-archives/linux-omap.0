From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v10 00/18] OMAP2,3: hwmod DSS Adaptation
Date: Tue, 25 Jan 2011 09:03:32 -0800
Message-ID: <20110125170331.GM13589@atomide.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
 <87mxmq6k2g.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25903 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab1AYRDy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 12:03:54 -0500
Content-Disposition: inline
In-Reply-To: <87mxmq6k2g.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Sumit Semwal <sumit.semwal@ti.com>, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110124 13:56]:
> Sumit Semwal <sumit.semwal@ti.com> writes:
> 
> > v10 of the patch series corrects return-error handling from platform_request_irq()
> > based on comments from Sergei Shtylyov and Russell King.
> > [https://patchwork.kernel.org/patch/497911/]
> 
> Tony,
> 
> Assuming Tomi is OK with this series, I think these are ready to go into
> omap-testing for some broader testing.

I can merge in Tomi's branch for testing once Tomi is happy with them.

Regards,

Tony
