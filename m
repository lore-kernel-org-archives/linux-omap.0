From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: PM: readability fix for IVA2 DPLL autoidle
Date: Wed, 26 Nov 2008 11:31:34 -0800
Message-ID: <20081126193133.GA11997@atomide.com>
References: <1227626615-2949-1-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.0811251007020.28747@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51702 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYKZTbe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 14:31:34 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0811251007020.28747@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@booyaka.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@booyaka.com> [081125 09:07]:
> On Tue, 25 Nov 2008, Kevin Hilman wrote:
> 
> > No functional change, just a readability fix.
> > 
> > The symbolic name of the shift value used in writing
> > CM_AUTOIDLE_PLL_IVA2 referred values in the CM_CLKSTCTRL_IVA2
> > register.  Fix this to use the AUTOIDLE fields.
> > 
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Pushing today.

Tony
