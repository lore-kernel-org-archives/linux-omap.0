From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS: dispc: enable/disable clocks in error
 handler
Date: Wed, 29 Jun 2011 07:58:07 +0300
Message-ID: <1309323487.1829.9.camel@deskari>
References: <1309195865-23808-1-git-send-email-dima@android.com>
	 <4E09FEFD.9020005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:34298 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750974Ab1F2E6O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 00:58:14 -0400
In-Reply-To: <4E09FEFD.9020005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Dima Zavin <dima@android.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-06-28 at 09:19 -0700, Archit Taneja wrote:
> Hi,
> 
> On Monday 27 June 2011 10:31 AM, Dima Zavin wrote:
> > There's no guarantee that the error handler worker thread
> > will run while the dispc clocks are on. Explicitly enable/disable
> > them.
> 
> I agree with this.

Yes, I think this patch is fine. I'll apply it to DSS tree.

> Tomi,
> 
> We could get prevent scheduling of the error worker by registering 
> omap_dispc_irq_handler() as an interrupt thread.

But then we would get extra latency on the interrupt handlers. I wanted
to keep handling DSS interrupts in interrupt context, because some use
cases may require very fast reaction to an interrupt.

 Tomi


