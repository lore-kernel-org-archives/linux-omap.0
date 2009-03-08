From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [patch 2.6.29-rc6+misc] MMC: regulator utilities
Date: Sun, 8 Mar 2009 22:49:07 +0100
Message-ID: <20090308224907.62e9d9d5@mjolnir.ossman.eu>
References: <200902081037.06645.david-b@pacbell.net>
	<200903031918.07443.david-b@pacbell.net>
	<20090308145951.0fdd607a@mjolnir.ossman.eu>
	<200903081334.26465.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:51847 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbZCHVtN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 8 Mar 2009 17:49:13 -0400
In-Reply-To: <200903081334.26465.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Sun, 8 Mar 2009 12:34:25 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Sunday 08 March 2009, Pierre Ossman wrote:
> > Looks good. Now what should I do with it? Merge it in the next window
> > good enough?
> 
> Well, after testing the previously-untested call ... here's
> another update.
> 
> Since these depend on new calls in the regulator framework,
> it can't merge until after they merge (in the next window).
> Least hassle for you would be if this merges through the
> regulator framework (with your ack), I suspect.
> 
> - Dave
> 
> 
> ======== CUT HERE
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Glue between MMC and regulator stacks ... verified with
> some OMAP3 boards using adjustable and configured-as-fixed
> regulators on several MMC controllers.
> 
> These calls are intended to be used by MMC host adapters
> using at least one regulator per host.  Examples include
> slots with regulators supporting multiple voltages and
> ones using multiple voltage rails (e.g. DAT4..DAT7 using a
> separate supply, or a split rail chip like certain SDIO
> WLAN or eMMC solutions).
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---

Acked-by: Pierre Ossman <drzeus@drzeus.cx>

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
