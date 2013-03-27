From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] ARM: OMAP4+: Use common scratchpad SAR RAM offsets
 for all architectures
Date: Wed, 27 Mar 2013 13:49:30 -0700
Message-ID: <20130327204930.GM10155@atomide.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-2-git-send-email-santosh.shilimkar@ti.com>
 <87mwto7ki5.fsf@linaro.org>
 <51535B66.60307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27030 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab3C0Ute (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 16:49:34 -0400
Content-Disposition: inline
In-Reply-To: <51535B66.60307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130327 13:52]:
> On Thursday 28 March 2013 12:11 AM, Kevin Hilman wrote:
> > Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> > 
> >> From: Tero Kristo <t-kristo@ti.com>
> >>
> >> Simplifies code and also allows the re-use as is on OMAP5 devices.
> > 
> > nit: changelog here is rather weak.  It claims "simplifies code" but
> > it's not obvious from the patch how changing a few #defines does that.
> > 
> I agree. Basically the offset are chosen such a way that they can
> work on OMAP4 and OMAP5 instead of having two separate sets.
> Will expand the changelog to make it clear.

You might want to mention also that the offsets are only used by
the kernel to save and restore registers from so people don't
think those are hardare registers and that the patch might break
some things.

Regards,

Tony
