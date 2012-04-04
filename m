From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: hwmod_data: Rename the common irq for
 McBSP ports
Date: Wed, 4 Apr 2012 09:46:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204040945540.8000@utopia.booyaka.com>
References: <1332169966-25400-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33516 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549Ab2DDPqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 11:46:04 -0400
In-Reply-To: <1332169966-25400-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 19 Mar 2012, Peter Ujfalusi wrote:

> Use 'common' as name for the common irq number in hwmod data for the McBSP
> ports. The same name already in use for OMAP2430, and the OMAP4 hwmod data
> will be using the same name.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks, queued for 3.5.

- Paul
