From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [patch 2.6.29-rc6+misc] MMC: regulator utilities
Date: Sun, 8 Mar 2009 14:59:51 +0100
Message-ID: <20090308145951.0fdd607a@mjolnir.ossman.eu>
References: <200902081037.06645.david-b@pacbell.net>
	<20090302224040.5e7ab0b2@mjolnir.ossman.eu>
	<200903021400.50201.david-b@pacbell.net>
	<200903031918.07443.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752602AbZCHOAL@vger.kernel.org>
In-Reply-To: <200903031918.07443.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 3 Mar 2009 19:18:06 -0800
David Brownell <david-b@pacbell.net> wrote:

> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Glue between MMC and regulator stacks ... compiles, and
> mmc_regulator_get_ocrmask() passed sanity testing.
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
> Changes from previous version:  automagically available if the
> regulator calls are available; callers now pass in host->ios.vdd.
> mmc_regulator_set_ocr() still untested.
> 

Looks good. Now what should I do with it? Merge it in the next window
good enough?

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
