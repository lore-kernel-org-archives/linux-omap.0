From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP: DMA: move LCD related code from plat-omap to
 mach-omap1
Date: Fri, 4 Dec 2009 15:19:12 -0800
Message-ID: <20091204231912.GO24013@atomide.com>
References: <200911271325.57355.jkrzyszt@tis.icnet.pl>
 <alpine.DEB.2.00.0911292344310.17083@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64288 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442AbZLDXTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 18:19:14 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0911292344310.17083@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Paul Walmsley <paul@pwsan.com> [091129 22:44]:
> On Fri, 27 Nov 2009, Janusz Krzysztofik wrote:
> 
> > All of the LCD DMA code in plat-omap/dma.c appears to be OMAP1-only (and
> > apparently only is available on a subset of OMAP1 chips).
> 
> Looks good.
> 
> Reviewed-by: Paul Walmsley <paul@pwsan.com>
> 
> Tony, you want to take this one?

Yes, adding to for-next-vol2 branch.

Tony
