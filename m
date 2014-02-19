From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] ARM: OMAP2+: clockdomain: Reintroduce SW_SLEEP
 Support
Date: Wed, 19 Feb 2014 18:15:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402191811370.8777@utopia.booyaka.com>
References: <1391811659-33716-1-git-send-email-d-gerlach@ti.com> <1391811659-33716-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42280 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbaBSSPF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 13:15:05 -0500
In-Reply-To: <1391811659-33716-2-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Fri, 7 Feb 2014, Dave Gerlach wrote:

> Since commit 65aa94b204d (ARM: OMAP4: clockdomain/CM code: Update supported
> transition modes), on OMAP4, all CLKDMs support HW_AUTO so this is used
> instead of SW_SLEEP for the idling of clockdomains. However, additional
> SoCs now leverage the OMAP4 clockdomain code so update it to use SW_SLEEP
> if the clockdomain data specifies that the CLKDM has the
> CLKDM_CAN_FORCE_SLEEP flag set rather than using HW_AUTO for both cases.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Thanks, queued for v3.15 unless someone else complains.

Significant chunks of PM are pretty much broken now in mainline.  So 
probably folks won't be able to detect a regression immediately.  But I 
agree with the basic idea.


- Paul
