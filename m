From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [GIT PULL] OMAP DSS fixes for next rc
Date: Wed, 15 Dec 2010 17:20:08 +0200
Message-ID: <1292426408.11825.16.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:50161 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450Ab0LOPUP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 10:20:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

Hi Paul,

Two OMAP DSS fixes for the next rc.

 Tomi

The following changes since commit cf7d7e5a1980d1116ee152d25dac382b112b9c17:

  Linux 2.6.37-rc5 (2010-12-06 20:09:04 -0800)

are available in the git repository at:
  git://gitorious.org/linux-omap-dss2/linux.git for-paul-rc

Tomi Valkeinen (2):
      OMAP: DSS: VRAM: Align start & size of vram to 2M
      OMAP: OMAPFB: disable old omapfb for OMAP4 builds

 drivers/video/omap/Kconfig |    4 ++--
 drivers/video/omap2/vram.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


