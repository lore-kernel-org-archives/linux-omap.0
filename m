From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc2-omap1-git 0/7] regulator and MMC updates...
Date: Tue, 20 Jan 2009 02:44:36 -0800
Message-ID: <200901200244.36238.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:44258 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753934AbZATLBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2009 06:01:17 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

Several patches here:

 - New interface in regulator core ... in the regulator queue
   (presumably for 2.6.30 merge)

 - twl4030 regulator updates to use that interface

Given that second part, I think the twl4030 regulator code can
be submitted upstream.

 - Init updates for OMAP 3430 SDP ... regulators, MMC switches,
   and a bit more.

 - Minor Overo init update:  set up VMMC1

 - HSMMC init update:  pass device back so regulator setup can
   use it.  (Not as invasive as a cleaner fix would be...)

 - Beagle init update:  hook up the regulators used by MMC-1
   (relies on that init update)

 - SDP init update:  hook up regulators used by MMC-1 and MMC-2
   (also relies on that init update)

These go on top of patches I sent previously, to work around
a lockdep issue in the hsmmc driver (that might go to mainline
as a bugfix, assuming that driver goes to mainline for 2.6.29)
and correct the mach-omap2/mmc-twl4030.c power switching.

Once that's merged, it'll be ready to start using the regulator
calls to switch power for MMC on at least those platforms.

- Dave
