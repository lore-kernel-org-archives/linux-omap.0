From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv10 1/7] I2C: OMAP: I2C register restore only if context
 is lost
Date: Tue, 26 Jun 2012 11:38:07 +0530
Message-ID: <4FE951C7.8070907@ti.com>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com> <1340622702-21622-2-git-send-email-shubhrajyoti@ti.com> <20120625123000.GB30463@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:36871 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757508Ab2FZGIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 02:08:15 -0400
Received: by obbun3 with SMTP id un3so7825988obb.41
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 23:08:13 -0700 (PDT)
In-Reply-To: <20120625123000.GB30463@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Kevin Hilman <khilman@ti.com>

On Monday 25 June 2012 06:00 PM, Felipe Balbi wrote:
>> Cc: Kevin Hilman <khilman@ti.com>
>> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> how will this ever work with DT ? 
What you say makes sense however that is what currently
most of the omap drivers do.

Will check on this.
> I say we get rid of the OMAP-specific
> API and build this "context lost" status directly on dev_pm_info and
> have something like pm_runtime_lost_context() or something with pm QoS
> tell you if a device has lost its context.
>
> Also, your commit log doesn't really state any problems you might have
> reached before, or any improvements wrt latency coming out of suspend
> and so on.
>
> IMHO, drivers need a generic way to differentiate if they're resuming
> from OFF or RET, otherwise we will end up with a bunch of OMAP-specific
> hackery on all drivers


