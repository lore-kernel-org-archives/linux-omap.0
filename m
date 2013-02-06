From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5] watchdog: introduce retu_wdt driver
Date: Wed, 6 Feb 2013 23:16:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302062315321.12769@utopia.booyaka.com>
References: <1356641909-8598-1-git-send-email-aaro.koskinen@iki.fi> <20130128151223.GH23053@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38733 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893Ab3BFXQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 18:16:43 -0500
In-Reply-To: <20130128151223.GH23053@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi Wim,

On Mon, 28 Jan 2013, Aaro Koskinen wrote:

> On Thu, Dec 27, 2012 at 10:58:29PM +0200, Aaro Koskinen wrote:
> > Introduce Retu watchdog driver.
> 
> Wim, any comments about this driver? Do you think it could be queued
> for 3.9?

It'd be really great if this could go in for v3.9.  Without it, Nokia N800 
boards crash shortly after boot because the Retu watchdog isn't being 
tickled :-(


- Paul
