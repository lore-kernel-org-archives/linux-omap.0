From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on
 device id
Date: Tue, 26 Nov 2013 15:52:02 -0800
Message-ID: <20131126235201.GV26766@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-3-git-send-email-tony@atomide.com>
 <20131118184723.GR10317@atomide.com>
 <87ioveeo0x.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48107 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3KZXwF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 18:52:05 -0500
Content-Disposition: inline
In-Reply-To: <87ioveeo0x.fsf@octavius.laptop.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

* Chris Ball <cjb@laptop.org> [131126 15:35]:
> Hi Tony,
> 
> On Mon, Nov 18 2013, Tony Lindgren wrote:
> > We are wrongly relying on device id for the DMA configuration
> > which can lead to wrong DMA channel being selected.
> >
> > Fix the issue by using the standard resources like we should.
> >
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc@vger.kernel.org
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Feel free to merge via your tree:
> 
> Acked-by: Chris Ball <cjb@laptop.org>

OK thanks will merge both mmc fixes.

Tony
