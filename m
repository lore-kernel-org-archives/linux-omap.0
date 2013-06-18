From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3EVM: Marking omap3_evm_display_init() with
 CONFIG_BROKEN
Date: Tue, 18 Jun 2013 03:11:39 -0700
Message-ID: <20130618101139.GJ5523@atomide.com>
References: <1371120838-29599-1-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1306140238270.5514@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44844 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754001Ab3FRKLm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 06:11:42 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1306140238270.5514@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

* Paul Walmsley <paul@pwsan.com> [130613 19:44]:
> On Thu, 13 Jun 2013, Lokesh Vutla wrote:
> 
> > On 37xx EVM non-dt boot fails with current mainline,
> > because of broken GPIO numbering in the board file
> > that uses hardcoded GPIOs.
> > 
> > So marking omap3_evm_display_init() with CONFIG_BROKEN
> > for now as suggested by Tony as per the below link:
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg90399.html
> > 
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com> ---
> 
> Tested-by: Paul Walmsley <paul@pwsan.com>

Thanks applying into omap-for-v3.11/board.

Regards,

Tony
