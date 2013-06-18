From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3EVM: Marking omap3_evm_display_init() with
 CONFIG_BROKEN
Date: Tue, 18 Jun 2013 11:23:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306181122390.4392@utopia.booyaka.com>
References: <1371120838-29599-1-git-send-email-lokeshvutla@ti.com> <alpine.DEB.2.02.1306140238270.5514@utopia.booyaka.com> <20130618101139.GJ5523@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41585 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab3FRLXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 07:23:34 -0400
In-Reply-To: <20130618101139.GJ5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

On Tue, 18 Jun 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [130613 19:44]:
> > On Thu, 13 Jun 2013, Lokesh Vutla wrote:
> > 
> > > On 37xx EVM non-dt boot fails with current mainline,
> > > because of broken GPIO numbering in the board file
> > > that uses hardcoded GPIOs.
> > > 
> > > So marking omap3_evm_display_init() with CONFIG_BROKEN
> > > for now as suggested by Tony as per the below link:
> > > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg90399.html
> > > 
> > > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com> ---
> > 
> > Tested-by: Paul Walmsley <paul@pwsan.com>
> 
> Thanks applying into omap-for-v3.11/board.

This one is probably a candidate for v3.10-rc...  Otherwise 37xx EVM won't 
boot on v3.10.


- Paul
