From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: next PM branch preview
Date: Tue, 05 May 2009 11:11:52 -0700
Message-ID: <87hbzz8lnb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:15348 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZEESL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2009 14:11:56 -0400
Received: by gv-out-0910.google.com with SMTP id p33so250396gvf.37
        for <linux-omap@vger.kernel.org>; Tue, 05 May 2009 11:11:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I've rebased the PM branch on to current linux-omap HEAD (currently
2.6.30-rc4) and it is available from my tree[1] as the branch named
'pm-next'

There's still a couple issues for me to work, out but since people
have been asking, I've made it publicly available.

So far, I have only tested full-chip retention in suspend and PM idle
(not CPUidle) using minimal kernels on the following platforms:

- 3430SDP: initramfs
- RX51: OneNAND rootfs
- OMAP3EVM: initramfs
- Beagle: initramfs

Not tested:
- CPUidle
- DVFS (CPUfreq)

Known issues:
- 3430SDP: CORE pwrdm does not hit retention
- hangs on return from OFF
- OMAP3EVM: debounce used on TS GPIO (in GPIO6) and result in
  "Clock gpio6_dbck didn't enable in 100000 tries"

Also note that I only build minimal kernels using very few drivers.
So I've also added the defconfigs I used for the boards so it's clear
what I'm using to test.  They are named *_pm_defconfig.

Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git
