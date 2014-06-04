From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 0/7] OMAPDSS: Support multiple DPI instances
Date: Wed, 4 Jun 2014 12:10:56 +0530
Message-ID: <1401864063-19196-1-git-send-email-archit@ti.com>
References: <1401096492-1405-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57909 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbaFDGmY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 02:42:24 -0400
In-Reply-To: <1401096492-1405-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

DSS on DRA7x has 3 DPI outputs. In order to get them to work. We need to make
the DPI driver support multiple DPI instances. We also need to tweak the
DT parsing done to match an encoder/connector/panel driver to find the
corresponding omapdss output. This series tries to achieve the above 2 tasks.

Changes in v3:

- Make indexes in port lists not depend on DPI and SDI CONFIGs.
- Cleaner code in dss_init_ports/uninit_ports.
- Split up the patch which creates multi DPI instances.
- Switch to a simpler way of extracting DPI driver data from dssdev.
- Change some of the dss-of fucntions, such that
  omapdss_of_find_source_for_first_ep is simplified.

Archit Taneja (7):
  OMAPDSS: DPI: Use DPI driver data
  OMAPDSS: DPI: Allocate driver data
  OMAPDSS: DPI: Store dpi_data pointer in the DT port's data
  OMAPDSS: DSS: init dss ports cleanly
  OMAPDSS: DT: Get source endpoint by matching reg-id
  OMAPDSS: DPI: Add support for multiple instances
  omapdss: DSS: add reg-id param to dpi_select_source

 .../fbdev/omap2/displays-new/encoder-tfp410.c      |   1 +
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |   1 +
 drivers/video/fbdev/omap2/dss/dpi.c                | 259 ++++++++++++++-------
 drivers/video/fbdev/omap2/dss/dss-of.c             |  58 +++--
 drivers/video/fbdev/omap2/dss/dss.c                | 108 +++++++--
 drivers/video/fbdev/omap2/dss/dss.h                |  34 ++-
 drivers/video/fbdev/omap2/dss/output.c             |  19 +-
 drivers/video/fbdev/omap2/dss/sdi.c                |   2 +-
 include/video/omapdss.h                            |   5 +-
 9 files changed, 354 insertions(+), 133 deletions(-)

-- 
1.8.3.2

