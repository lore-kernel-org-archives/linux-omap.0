From: Tony Lindgren <tony@atomide.com>
Subject: Re: [pandaboard] audio initialization fails due to TWL6040
Date: Thu, 5 Dec 2013 10:53:49 -0800
Message-ID: <20131205185349.GH26766@atomide.com>
References: <529E5EC9.10008@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61214 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757021Ab3LESxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 13:53:52 -0500
Content-Disposition: inline
In-Reply-To: <529E5EC9.10008@math.uni-bielefeld.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Tobias Jakobi <tjakobi@math.uni-bielefeld.de> [131203 14:45]:
> And another one!
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=66451

Maybe Peter can take a look at this one?

FYI, Peter, only slightly related to this, but can you also please
unravel the mcbsp and sidetone .dtsi entries to be separate
devices? I'm hoping to deprecate ti,hwmods for v3.15 and use
the compatible property instead, so we need to have 1-to-1
mapping of devices defined in the .dtsi files compared to the
real hardware devices mapped in the omap_hwmod_*_data.c files.

There's some more info regarding that in thread:

http://www.spinics.net/lists/arm-kernel/msg288036.html

Regards,

Tony
