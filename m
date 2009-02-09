From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: MMC: recover from transfer failures - Resend
Date: Mon, 9 Feb 2009 10:46:38 -0800
Message-ID: <20090209184636.GG14200@atomide.com>
References: <20090206145343.2b8a5353@mjolnir.drzeus.cx> <20090209175851.GA30769@angel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52853 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbZBISqr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 13:46:47 -0500
Content-Disposition: inline
In-Reply-To: <20090209175851.GA30769@angel.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Pierre Ossman <drzeus@drzeus.dddcx>, Jean Pihet <jpihet@mvista.com>, Paul Walmsley <paul@pwsan.com>, " Hunter Adrian (EXT-Teleca/Helsinki)" <ext-adrian.hunter@nokia.com>, OMAP <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, " linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

* Jarkko Lavinen <jarkko.lavinen@nokia.com> [090209 10:06]:
> Pierre Ossman wrote:
> > Related, who is the maintainer of this driver? Tony? I'd like
> > to have someone who checks patches before I queue them up.
> 
> I can be.  Tony asked me a month ago to set up git tree for OMAP
> HSMMC and put the workaround for the HSMMC multi-block DMA read
> corruption there, but hate to admit things have been hanging on
> todo list.

Yeah it would be great if Jarkkko can queue up all the omap MMC
patches from now on.

> There are some other fixes waiting. Omap_mmc_set_ios() doesn't
> handle power off case correctly and resume from suspend can hang
> if the SDBP bit fails to set.

And then all your PM patches for the next merge window..

Tony
