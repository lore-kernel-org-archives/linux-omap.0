From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/6] OMAP: DSS: porting old drivers to DSS2 (board
 files part)
Date: Mon, 19 Sep 2011 14:08:27 -0700
Message-ID: <20110919210827.GH2937@atomide.com>
References: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
 <1316417915.1978.52.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:58446 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753988Ab1ISVIa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 17:08:30 -0400
Content-Disposition: inline
In-Reply-To: <1316417915.1978.52.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110919 00:05]:
> Hi Tony, 
> 
> On Mon, 2011-09-12 at 14:20 +0300, Tomi Valkeinen wrote:
> > This patch set ports all the OMAP2/3 boards, except N8x0, that use the old
> > omapfb to use the newer DSS2 driver. Only board files are changed, the panel
> > driver additions are done in separate patch set. Applying this set without the
> > driver changes will obviously disable the displays of the affected boards until
> > the drivers are also merged.
> > 
> > Some board files contained old omapfb code, but there wasn't a matching LCD
> > driver. That board file code is also removed.
> 
> Any chances to get these in for the next merge window? These will remove
> most of the OMAP2/3 users of the old omapfb, and when the old omapfb is
> used only by OMAP1, we can remove quite a bit of code there.

OK thanks for cleaning this up. Will apply these to board branch.

Tony
