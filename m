From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH 2/2] McSPI Slave and DMA,FIFO support
Date: Wed, 5 Aug 2009 11:59:27 +0300
Message-ID: <20090805085927.GD7374@atomide.com>
References: <42150.10.24.255.18.1245765248.squirrel@dbdmail.itg.ti.com> <200907021722.02459.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57971 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933639AbZHEI7b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 04:59:31 -0400
Content-Disposition: inline
In-Reply-To: <200907021722.02459.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Hemanth V <hemanthv@ti.com>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090703 03:22]:
> On Tuesday 23 June 2009, Hemanth V wrote:
> > This patch adds support for McSPI slave and FIFO. DMA and FIFO
> > could be enabled together for better throughput.
> > 
> > This has a dependency on patch
> > [RESEND][PATCH 1/2] McSPI Slave and DMA,FIFO support
> 
> ... in this case I'd think they would better be part of
> a single patch.
> 
> However, anything related to SPI slave support should
> be separated entirely from FIFO support.
> 
> Ditto anything adding more SPI_DEBUG support.
> 
> Oh, and use the BIT(n) syntax not (1 << n) in the new
> constants you define... the patch making this driver
> use that style finally went upstream.

I agree with Dave's comments. Maybe repost one more time,
then I'd actually prefer these get merged via the SPI list
once everybody's happy.

Tony
