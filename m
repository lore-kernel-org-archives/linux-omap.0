From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH] W1: OMAP HDQ1W: allow driver to be built on all OMAP2+
Date: Wed, 2 May 2012 19:34:32 +0400
Message-ID: <20120502153432.GA15534@ioremap.net>
References: <alpine.DEB.2.00.1205020206020.19695@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intermatrixgroup.ru ([195.178.208.66]:56252 "EHLO
	tservice.net.ru" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752806Ab2EBPef (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 11:34:35 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1205020206020.19695@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, May 02, 2012 at 02:08:36AM -0600, Paul Walmsley (paul@pwsan.com) wrote:
> 
> Allow the OMAP HDQ1W driver to be built for all OMAP2+ SoCs by
> adjusting KConfig dependencies.  The previous dependency required
> either SOC_OMAP2430 or ARCH_OMAP3 to be set, but the HDQ IP block is
> present on OMAP2420 and OMAP44xx SoCs.  The driver was still
> selectable on multi-OMAP kernel configurations, however; so the
> previous prohibition was rather pointless.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Evgeniy Polyakov <zbr@ioremap.net>

Well, looks good, although I know nothing about build deps for OMAP platform :)

-- 
	Evgeniy Polyakov
