From: Kevin Hilman <khilman@linaro.org>
Subject: [GIT PULL] OMAP5: fix voltage domains, remove wrong data
Date: Wed, 26 Jun 2013 08:10:45 -0700
Message-ID: <87fvw4sya2.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:49892 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab3FZPKs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jun 2013 11:10:48 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so14315972pbc.11
        for <linux-omap@vger.kernel.org>; Wed, 26 Jun 2013 08:10:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Arnd,

Below is a pull request with a patch that fixes the build breakage you reported
related to voltage domains on OMAP5-only builds: https://patchwork.kernel.org/patch/2764191/

This applies on top of arm-soc/omap/omap5

Kevin



The following changes since commit 6503a8e109a639760408f874c1251060d563942e:

  ARM: OMAP5: Remove unused include for ocp2scp (2013-06-09 21:17:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.11/fixes/omap5-voltdm

for you to fetch changes up to 2ac524f151dbecb862c95b8f433267772caa800e:

  ARM: OMAP5: voltagedomain data: remove temporary OMAP4 voltage data (2013-06-25 17:11:06 -0700)

----------------------------------------------------------------
OMAP5: PM: fix boot by removing unneeded dummy voltage domain data

----------------------------------------------------------------
Nishanth Menon (1):
      ARM: OMAP5: voltagedomain data: remove temporary OMAP4 voltage data

 arch/arm/mach-omap2/voltagedomains54xx_data.c | 10 ----------
 1 file changed, 10 deletions(-)
