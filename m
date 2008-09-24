From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Add RX/TX interrupts for 2430 and 34xx
	McBSP ports 3-5
Date: Wed, 24 Sep 2008 12:39:03 +0300
Message-ID: <20080924093902.GM5222@atomide.com>
References: <1221569813-29771-1-git-send-email-jarkko.nikula@nokia.com> <20080924091402.GK5222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61128 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbYIXJjK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 05:39:10 -0400
Content-Disposition: inline
In-Reply-To: <20080924091402.GK5222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080924 12:14]:
> * Jarkko Nikula <jarkko.nikula@nokia.com> [080916 16:02]:
> > Without RX and TX interrupt definitions, the omap_mcbsp_request will
> > fail on OMAP2430 and OMAP34xx for ports 3-5 since default io_type is
> > OMAP_MCBSP_IRQ_IO.
> 
> Pushing to l-o and merging into your earlier patch
> "Add support for OMAP2430 in McBSP" for upstream.

Correction, merging 34xx interrupt changes into Chandra's
"Allocate McBSP devices dynamically, add 34xx support"
patch for upstream.

Tony
