From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] MFD: TWL/TPS: fix twl_probe section mismatch warning in
 mfd/twl-core.c
Date: Tue, 7 Dec 2010 09:12:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012070911380.13430@utopia.booyaka.com>
References: <alpine.DEB.2.00.1012061734590.13430@utopia.booyaka.com> <AANLkTimXPFROMQ_fF4Od-jw3aDY0WZQgc=x14=VcFM3d@mail.gmail.com> <alpine.DEB.2.00.1012061839170.13430@utopia.booyaka.com> <20101207094841.GA4772@sortiz-mobl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54256 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab0LGQMq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 11:12:46 -0500
In-Reply-To: <20101207094841.GA4772@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hello Samuel,

On Tue, 7 Dec 2010, Samuel Ortiz wrote:

> On Mon, Dec 06, 2010 at 06:40:38PM -0700, Paul Walmsley wrote:
> > 
> > That's fine with me.  Samuel et al, Bryan's already done a patch 
> > for this stuff:
> > 
> > https://patchwork.kernel.org/patch/367011/
> > 
> > so we should use that instead, if you're happy with it.  Samuel, maybe we 
> > could get an ack from you on it?
> The twl driver is not OMAP specific, so this should be a separate patch thatI
> will merge to my mfd tree.
> If you really insist in pushing this through Tony's tree, then please add my
> Acked-by for the mfd part.

I don't insist at all :-)

Bryan, maybe split your patch into a mach-omap2 patch and a TWL 
driver-specific patch, and send the latter for Samuel?


- Paul
