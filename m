From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way operationcan
 cause data corruption
Date: Mon, 28 Feb 2011 09:15:52 +0530
Message-ID: <680a3e4f3107f4fcb10f98bd0a589d1c@mail.gmail.com>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
 <1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com> <20110227120021.GA15314@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49649 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752233Ab1B1Dp4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Feb 2011 22:45:56 -0500
Received: by mail-qw0-f45.google.com with SMTP id 8so3021354qwj.4
        for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 19:45:53 -0800 (PST)
In-Reply-To: <20110227120021.GA15314@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, catalin.marinas@arm.com, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Sunday, February 27, 2011 5:30 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; tony@atomide.com;
> catalin.marinas@arm.com; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way
> operationcan cause data corruption
>
> On Fri, Feb 18, 2011 at 06:05:24PM +0530, Santosh Shilimkar wrote:

[...]

>
> > @@ -329,6 +330,7 @@ void __init l2x0_init(void __iomem *base,
> __u32 aux_val, __u32 aux_mask)
> >  	outer_cache.flush_all = l2x0_flush_all;
> >  	outer_cache.inv_all = l2x0_inv_all;
> >  	outer_cache.disable = l2x0_disable;
> > +	outer_cache.set_debug = NULL;
>
> 	outer_cache.set_debug = l2x0_set_debug;
>
> may result in more efficient code as we're avoiding having to test
> the value of outer_cache.set_debug each time we want to call it and
> branch appropriately.

Ok. Will do the necessary change and submit it to patch System

Regards,
Santosh
