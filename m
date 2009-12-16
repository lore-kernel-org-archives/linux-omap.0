From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [ANNOUNCE] new PM branch, rebased to current master
Date: Wed, 16 Dec 2009 11:45:16 -0800
Message-ID: <873a3abt4j.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:60530 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761764AbZLPTpX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 14:45:23 -0500
Received: by yxe17 with SMTP id 17so1239737yxe.33
        for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 11:45:22 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I've just pushed the latest PM branch.  As usual, all the gory details
can be found on the wiki[1], but I'll highlight the important changes
here:

- PM branch getting smaller: The off-mode support and CPUidle support
  is now in mainline, so it's no longer in PM branch.

- omap3_pm_defconfig: now works an all supported boards.  I moved to
  the new DEBUG_LL_NONE so all boards should work out of the box without
  having to switch DEBUG_LL_UART* setup.

- voltage_off_while_idle: only modifies the VOLTCTRL reg during OFF
  transitions instead of when debugfs file is changed

Otherwise, this is primarily a rebase and inclusion of several
patches/fixes from the mailing list.

The biggest change is on how the PM branch will be managed.  As of
this release, the PM branch will no longer be continually rebased.
Instead, it will remain mergable.  I will be rebuilding the PM
branch in a similar way that Tony is now doing the master branch.

Kevin

[1] http://elinux.org/OMAP_Power_Management
