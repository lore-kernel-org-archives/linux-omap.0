From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 0/3] DSPBRIDGE: simplify ntfy module
Date: Wed, 24 Mar 2010 22:52:14 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CADC2FF1@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37908 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab0CYDwf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 23:52:35 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

>From 87f5751e8838fae3b3eed189eaa9a94a6d8e1ebd Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 24 Mar 2010 21:53:02 -0600
Subject: [PATCH] DSPBRIDGE: simplify ntfy module

This set of patches simplifies the ntfy and also use kernel functions
for notifications. Always keeping the same behavior that it had before
the changes. That is the reason the code could no be simplified a little
more.

Fernando Guzman Lugo (3):
  DSPBRIDGE: remove ntfy_init/exit functions
  DSPBRIDGE: allocation of ntfy object take out of ntfy module.
  DSPBRIDGE: simplify and make more use of kernel function in notify
    module

 arch/arm/plat-omap/include/dspbridge/ntfy.h |  275 +++++++++++++++++---------
 drivers/dsp/bridge/rmgr/node.c              |   22 ++-
 drivers/dsp/bridge/rmgr/proc.c              |   16 ++-
 drivers/dsp/bridge/services/ntfy.c          |  282 +--------------------------
 drivers/dsp/bridge/services/services.c      |    6 +-
 drivers/dsp/bridge/wmd/chnl_sm.c            |   19 ++-
 drivers/dsp/bridge/wmd/msg_sm.c             |   23 ++-
 drivers/dsp/bridge/wmd/ue_deh.c             |   19 ++-
 8 files changed, 270 insertions(+), 392 deletions(-)

