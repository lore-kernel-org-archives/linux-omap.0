From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: omap: ehci: avoid compiler error with
 touchbook
Date: Mon, 8 Mar 2010 15:04:23 -0800
Message-ID: <20100308230422.GH2900@atomide.com>
References: <20100304074434.GI15954@nokia.com>
 <1267688753-6344-1-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCDFE@dbde02.ent.ti.com>
 <a05a09f453a7473f2ba54a9056589b72@secure211.sgcpanel.com>
 <20100305070330.GB12757@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51108 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab0CHXDJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 18:03:09 -0500
Content-Disposition: inline
In-Reply-To: <20100305070330.GB12757@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "ext me@felipebalbi.com" <me@felipebalbi.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [100304 23:00]:
> On Thu, Mar 04, 2010 at 08:15:27PM +0100, ext me@felipebalbi.com wrote:
> >Hi,
> >
> >On Thu, 4 Mar 2010 18:33:15 +0530, "Gadiyar, Anand" <gadiyar@ti.com>
> >wrote:
> >>>This patch fixes that for the ehci_hdc_omap_platform_data.
> >>>
> >>
> >>should be ehci_hcd_omap_platform_data ;)
> >>
> >>BTW, this breaks compile for omap3-evm.
> >>Could you please build with omap3_defconfig and check.
> >
> >will do first thing tomorrow :-)
> 
> yeah, it breaks because evm tries to assign to a (now) const
> variable. Maybe the only way is to move everybody out of the
> __initconst section and put them on __initdata.
> 
> or we drop the revision check for EVM and use only the newer one,
> I'm more into doing the first one.
> 
> Tony, do you have any comments ??

Hmm yeah thanks for digging into this mystery. Looks like we're
hitting some Linux initdata limitation.

We can't mark everything as __initconst. Some platform data can
get dynamically set based on the board type for resources.

So to me it sounds like the only solution is to mark everything
as __initdata and ignore the (correct) const for now for __initdata.

Or am I missing something?

Regards,

Tony
