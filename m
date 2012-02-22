From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/16] OMAPDSS: old OMAPFB cleanup
Date: Wed, 22 Feb 2012 14:09:26 -0800
Message-ID: <20120222220926.GL18185@atomide.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1329220343.1845.65.camel@deskari>
 <20120222185016.GI18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23654 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab2BVWJ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 17:09:29 -0500
Content-Disposition: inline
In-Reply-To: <20120222185016.GI18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, archit@ti.com, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120222 10:18]:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120214 03:21]:
> > 
> > Tony, do you have any feedback on this? I think the arch/arm changes are
> > quite clean as such, but are you ok with (possibly) breaking N770's
> > display? The other OMAP1 boards should, at least in theory, work as well
> > as before.
> > 
> > For N770, the bootloader passes the reset GPIO number and number of
> > datalines, and I have no idea what those are.
> 
> I think they should be:
> 
> conf->nreset_gpio = 13
> conf->data_lines = 24

Probably should be:

conf->nreset_gpio = 13
conf->data_lines = 16

No luck getting anything on the LCD though with
current kernel though.

Tony
