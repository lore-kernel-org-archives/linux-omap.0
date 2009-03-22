From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH 8/10] OMAP: HSMMC: Make driver support dynamic idle
Date: Sun, 22 Mar 2009 15:30:19 +0100
Message-ID: <20090322153019.2ae32458@mjolnir.ossman.eu>
References: <20090312162252.19421.34019.sendpatchset@ahunter-laptop>
	<20090312162346.19421.90213.sendpatchset@ahunter-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:39312 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbZCVOa0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Mar 2009 10:30:26 -0400
In-Reply-To: <20090312162346.19421.90213.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, David Brownell <david-b@pacbell.net>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>

On Thu, 12 Mar 2009 18:23:46 +0200
Adrian Hunter <adrian.hunter@nokia.com> wrote:

> From 47b6de0fcfeb5948199dbed941847580bedc5315 Mon Sep 17 00:00:00 2001
> From: Amit Kucheria <amit.kucheria@verdurent.com>
> Date: Thu, 12 Mar 2009 15:47:39 +0200
> Subject: [PATCH] OMAP: HSMMC: Make driver support dynamic idle
> 
> Add a timer that is kept active by MMC requests. FCLK is disabled on
> timeout.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
> Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---

NAK. This should be implemented in the core where we get a consistent
behaviour across all hosts. The principle with a timeout is sound
though.

As for the current state of the driver, stop fiddling with the clock
when it isn't necessary.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
