From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: PM branch updates: 14 may 09
Date: Thu, 14 May 2009 11:14:00 -0700
Message-ID: <877i0jtuvr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:32957 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbZENSOC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 14:14:02 -0400
Received: by rv-out-0506.google.com with SMTP id f6so2862362rvb.5
        for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 11:14:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

FYI...

Just pushed another round of updates to the 'pm' branch of my
linux-omap-pm repo[1].  git shortlog below[2]

As far as I know, the only outstanding submissions which are being
discussed/reviewed are:

- Tero Kristo: OMAP3: PM: Force USB to standby if not used  	2009-05-14
- Kim Kyuwon: OMAP3: PM: Add the wakeup source driver, v4  	2009-05-05
- Russ Dill: [RFC] Allow disabling wakeup for serial ports..., 	2009-04-27

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary

[2] git-shortlog:

Kalle Jokiniemi (2):
      ARM: OMAP3: Fix OMAP_CHIP_INIT usage
      PM: Disable usb host HW save and restore

Kevin Hilman (2):
      OMAP: PM: SmartReflex has build dependency on OMAP PM layer
      OMAP3: PM: 3430SDP: update pm_defconfig

Paul Walmsley (1):
      PM: OMAP3 SDRC: set FIXEDDELAY when disabling SDRC DLL

Tero Kristo (2):
      OMAP3: PM: Added resource refresh to OPP unlock requests
      OMAP: PM: Fixed omap_pm_set_min_bus_tput



