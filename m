From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH 0/3] OMAP: control: bootaddr and bootmod APIs
Date: Wed,  2 May 2012 21:11:50 -0500
Message-ID: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63256 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649Ab2ECCME (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 22:12:04 -0400
Received: by obbtb18 with SMTP id tb18so1792752obb.19
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 19:12:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-dev@lists.linaro.org, Omar Ramirez Luna <omar.luna@linaro.org>

Recently a patch went in for tidspbridge code, to ioremap
SCM registers and solve a build break[1]. However it has
been pointed out before that this is a layer violation
given that control module should handle its own registers, this
series is an attempt to create APIs for the users of these
registers.

With some adaptations this patch might also make use of it:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg66491.html

Patch: staging: tidspbridge: use scm functions to set boot address and mode,
will be sent separately to staging tree.

Tested on OMAP3 Beagleboard.

[1] http://www.mail-archive.com/devel@linuxdriverproject.org/msg18762.html

Omar Ramirez Luna (3):
  OMAP2+: control: new APIs to configure boot address and mode
  OMAP: dsp: interface to control module functions
  staging: tidspbridge: use scm functions to set boot address and mode

 arch/arm/mach-omap2/control.c                      |   43 ++++++++++++++++++++
 arch/arm/mach-omap2/control.h                      |    2 +
 arch/arm/mach-omap2/dsp.c                          |    4 ++
 .../include/mach/ctrl_module_core_44xx.h           |    1 +
 arch/arm/plat-omap/include/plat/dsp.h              |    3 +
 drivers/staging/tidspbridge/core/tiomap3430.c      |   32 +++-----------
 6 files changed, 60 insertions(+), 25 deletions(-)

-- 
1.7.4.1

