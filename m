From: Kevin Hilman <khilman@linaro.org>
Subject: [GIT PULL] OMAP: PM: remove OMAP-specific no_console_suspend handling
Date: Thu, 13 Jun 2013 15:12:11 -0700
Message-ID: <87zjutacec.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:48031 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884Ab3FMWMP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 18:12:15 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so10687106pbc.40
        for <linux-omap@vger.kernel.org>; Thu, 13 Jun 2013 15:12:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Please pull this OMAP PM cleanup for v3.11.

Thanks,

Kevin

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.11/cleanup/pm

for you to fetch changes up to 4b7ec5accecdb136c7afaf8739a06d5335cc05aa:

  arm: omap2+: omap_device: remove no_idle_on_suspend (2013-05-16 07:09:09 -0700)

----------------------------------------------------------------
OMAP: PM: the serial core + driver can no handle no_console_suspend support
without any SoC specific handlding or SoC-specific DT bindings.  Remove
the now unused SoC specifics for OMAP.

----------------------------------------------------------------
Sourav Poddar (3):
      arm: omap2+: serial: remove no_console_suspend support
      arm: dts: am33xx: Remove "ti,no_idle_on_suspend" property.
      arm: omap2+: omap_device: remove no_idle_on_suspend

 arch/arm/boot/dts/am33xx.dtsi     |  1 -
 arch/arm/mach-omap2/omap_device.c |  9 ++-------
 arch/arm/mach-omap2/omap_device.h | 10 ----------
 arch/arm/mach-omap2/serial.c      |  7 -------
 4 files changed, 2 insertions(+), 25 deletions(-)
