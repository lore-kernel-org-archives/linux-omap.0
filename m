From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 1/5] OMAP4: hwmod: Add names for DMIC memory address
 space
Date: Mon, 19 Dec 2011 14:51:50 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112191451140.12660@utopia.booyaka.com>
References: <1322487943-14280-1-git-send-email-peter.ujfalusi@ti.com> <1322487943-14280-2-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.00.1112152327410.12660@utopia.booyaka.com> <4EEB5913.3090901@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51606 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325Ab1LSVvv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 16:51:51 -0500
In-Reply-To: <4EEB5913.3090901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hi

On Fri, 16 Dec 2011, Cousson, Benoit wrote:

> On 12/16/2011 7:28 AM, Paul Walmsley wrote:
> > On Mon, 28 Nov 2011, Peter Ujfalusi wrote:
> > 
> > > To be able to get the memory resources by name from
> > > the DMIC driver (for MPU and for DMA).
> > 
> > Any comments on this one?  Looks like we'd need to add these names as
> > hints in the script.
> 
> Maybe not, in theory we should be able to detect the dual mapping and add the
> proper name. I did that for some other IP in the ABE domain, so it should be
> doable for that one too.
> 
> > > Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>
> 
> Acked-by: Benoit Cousson <b-cousson@ti.com>

Cool.  Queued for when Tony wants to pull it.


- Paul
