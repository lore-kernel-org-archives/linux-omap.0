From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [PATCH v3] omap: serial: fix non-empty uart fifo
 read abort
Date: Wed, 9 Dec 2009 08:29:45 -0800
Message-ID: <20091209162945.GN24013@atomide.com>
References: <1259972404-28784-1-git-send-email-vikram.pandita@ti.com>
 <notify-1260224602@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFA1C@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFBF7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59124 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053AbZLIQ3m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 11:29:42 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFBF7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [091209 06:16]:
> <snip>
> 
> > 
> > With current Linus' tree + this patch, I can boot up on 3630.
> > 
> > Playing with the omap3_defconfig now, to see how many boards
> > we can boot up with a single image :)
> > 
> 
> I got a zoom2, zoom3, 3430SDP and 3630 SDP booting with a
> single image.

OK good to hear.
 
> I had to disable Profiling and Sound support to get it to
> build with this config. Will post a patch after -rc1 if this
> is not resolved by then.

I've applied a patch for the profiling into omap-testing
from Carsten Emde I found on LKML. See patch 
"tracing: Fix trace_marker output".

Regards,

Tony

