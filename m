From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: PM branch update: rebase to .31-rc, added omap_hwmod/omap_device
Date: Mon, 20 Jul 2009 17:19:42 -0700
Message-ID: <87fxcqq44h.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:37118 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbZGUATp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jul 2009 20:19:45 -0400
Received: by pzk42 with SMTP id 42so183244pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 20 Jul 2009 17:19:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The PM branch hosted in my linux-omap-pm repo[1] has been updated.

Significant changes:

- rebased to omap/master (currently v2.6.31-rc1)
- Using new omap_hwmod and omap_device infrastructure from Paul Walmsley
- more reorg into groups of commits for easier submission upstream

Tested on the following platforms using omap3_pm_defconfig with
busybox-based initramfs, and tested full-chip RET and OFF in idle and
suspend:

- 3430SDP
- OMAP3EVM
- Beagle
- Overo
- RX51
- Zoom2 (use 'pm-staging/zoom2' branch as well, which is Vikram's
         zoom2 branch rebased on top of PM branch with DEBUG_LL
         support and misc. fixes)

Known problems:

- no DVFS because of next item...

- SRF driver broken, needs update for new hwmod/omap_device layer
  (default config used PM NOOP)

- network drivers and off-mode
  - various hangs when using off-while-idle and NFS-mounted rootfs
  - network drivers likely need some context save/restore support

- SDRAM on 2 CSes (Beagle, Overo, RX51)
  - need to boot with mem=128M so only a single CS is used
  - 2 CS support patches from Jean Pihet solve this problem,
    but not yet merged.

- 3430SDP ES3.0
  - UART1 doesn't come back from off-while-idle (ok on es3.1 SDP)

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git
