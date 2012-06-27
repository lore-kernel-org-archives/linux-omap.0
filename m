From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Date: Tue, 26 Jun 2012 17:47:10 -0700
Message-ID: <20120627004709.GA22766@gmail.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-6-git-send-email-rnayak@ti.com>
 <1340604478.12683.25.camel@lappyti>
 <4FE80C43.6090802@ti.com>
 <1340611133.3395.3.camel@deskari>
 <4FE85005.4090303@ti.com>
 <1340630090.3395.85.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:55701 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754738Ab2F0ArX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 20:47:23 -0400
Received: by pbbro12 with SMTP id ro12so872854pbb.32
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 17:47:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340630090.3395.85.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

On 20120625-16:14, Tomi Valkeinen wrote:
> A question about clk_prepare/unprepare, not directly related: let's say
> I have a driver for some HW block. The driver doesn't use clk functions,
> but uses runtime PM. The driver also sets pm_runtime_irq_safe().
> 
> Now, the driver can call pm_runtime_get_sync() in an atomic context, and
> this would lead to the underlying framework (hwmod, omap_device, I don't
> know who =) enabling the func clock for that HW. But this would happen
> in atomic context, so the underlying framework can't use clk_prepare.
> 
> How does the underlying framework handle that case? (sorry if that's a
> stupid question =).
> 

I think it's a good question!

If we're going to call clk_prepare_enable from within a runtime pm
callback then I think we'll need to check if _irq_safe() is set and
conditionally call only clk_enable in such a case.

I'm not a runtime pm expert, but if the driver owns the responsibility
of calling pm_runtime_irq_safe then the driver has the proper context
to know that it should call clk_prepare BEFORE calling
pm_runtime_get_sync.

However if some other framework (outside of the driver) calls
pm_runtime_irq_safe then it will be difficult for the driver to know
what to do...

Regards,
Mike

>  Tomi
> 


