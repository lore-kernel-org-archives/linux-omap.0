From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/2] remoteproc: add support to handle internal memories
Date: Tue, 19 Aug 2014 12:10:32 +0300
Message-ID: <CAK=WgbZ+NhA5AAhURUOojwnCbi2wYkJ11i-C5e7-kpZL5vD_3g@mail.gmail.com>
References: <1404836521-59637-1-git-send-email-s-anna@ti.com>
 <1404836521-59637-3-git-send-email-s-anna@ti.com> <CAK=WgbY-WmcJdnLHDf1CSkJqNBUeUMPTLcEZyLGKnECbxH1OAQ@mail.gmail.com>
 <53D7F6F3.9020804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:37382 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbaHSJKy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2014 05:10:54 -0400
Received: by mail-ie0-f176.google.com with SMTP id tr6so737201ieb.21
        for <linux-omap@vger.kernel.org>; Tue, 19 Aug 2014 02:10:53 -0700 (PDT)
In-Reply-To: <53D7F6F3.9020804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Robert Tivy <rtivy@ti.com>

Hi Suman,

On Tue, Jul 29, 2014 at 10:33 PM, Suman Anna <s-anna@ti.com> wrote:
> We currently have two usecases. The primary usecase is the WkupM3
> processor on TI Sitara AM335x/AM437x SoCs used for suspend/resume
> management. This series is a dependency for the WkupM3 remoteproc driver
> that Dave posted [1]. More details are in section 8.1.4.6 of the AM335x
> TRM [2]. The program/data sections for this processor all _needs_ to be
> in the two internal memory RAMS (16K Unified RAM and 8K Data RAM), and
> there is no MMU for this processor. The current RSC_CARVEOUT and
> RSC_DEVMEM do not fit to describe this type of memory (we neither
> allocate memory through dma api nor do we need to map these into an MMU).

Thanks for the details.

Can we define a CMA block for these regions, and then just use
carveout resource entries instead of the ioremap approach?

This may require some changes in remoteproc which we'll need to think
about, but it sounds like it may fit the problem better instead of
forcing ioremap to provide a regular pointer (we're supposed to use
ioremaped memory only with memory primitives such as readl/writel/..).

Thanks,
Ohad.
