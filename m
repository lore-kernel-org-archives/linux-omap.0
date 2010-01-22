From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 0/3] OMAP3: VC: first pass at common VC init
Date: Thu, 21 Jan 2010 17:02:18 -0800
Message-ID: <1264122141-17886-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f196.google.com ([209.85.223.196]:60567 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab0AVBCX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 20:02:23 -0500
Received: by iwn34 with SMTP id 34so557850iwn.21
        for <linux-omap@vger.kernel.org>; Thu, 21 Jan 2010 17:02:23 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>

In my reply to this series from Lesly:

  [PATCH v2 0/6] omap3: pm: Update TRITON power scripts and making it generic

I made this proposal:

> Second, your series is making it clear we need some common VC init.
> And this common VC init should be probably be separated from PMIC
> init/setup.  So before we go much further with this, I think it's time
> for some common VC infrastructure.
>
> So here's a proposal off the top of my head:
>
> - create new file(s): vc34xx.c, vc.h (or something like that)
> - move the common prm_setup_times init and structs there
> - move VC init from pm34xx.c (omap3_pm_init_vc, configure_vc, etc.)
>
> We'll then have all the VC init/setup in a single place.  

To help get things moving along in that direction, I created
this series to get things started.

Comments are welcome.

This series applies on to of current PM branch, and is also available
in my tree as the branch 'pm-wip/vc',

Kevin

Kevin Hilman (3):
  OMAP3: VC: create common init code
  OMAP3: VC: simply struct copy in init_vc routine
  OMAP3: VC: 3430SDP: remove prm_setup_vc, done in common VC code

 arch/arm/mach-omap2/Makefile        |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c |   18 ------
 arch/arm/mach-omap2/pm.h            |   25 ---------
 arch/arm/mach-omap2/pm34xx.c        |   91 -------------------------------
 arch/arm/mach-omap2/vc.c            |  102 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vc.h            |   47 ++++++++++++++++
 6 files changed, 151 insertions(+), 135 deletions(-)
 create mode 100644 arch/arm/mach-omap2/vc.c
 create mode 100644 arch/arm/mach-omap2/vc.h

