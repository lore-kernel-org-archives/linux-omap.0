From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 0/2] OMAP: DSS2: Fix DSS core init fail path
Date: Fri,  7 May 2010 12:58:40 +0300
Message-ID: <cover.1273222740.git.ext-jani.1.nikula@nokia.com>
References: <1273219659.1978.144.camel@tubuntu.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61928 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621Ab0EGKAF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 06:00:05 -0400
In-Reply-To: <1273219659.1978.144.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, khilman@deeprootsystems.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, ext-jani.1.nikula@nokia.com

Hi -

These patches fix the broken DSS omap_dss_probe() fail path, reported by Kevin
Hilman [1].

v2:
 - rebased against [2]

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27112.html
[2] git://gitorious.org/linux-omap-dss2/linux.git


BR,
Jani.


Jani Nikula (2):
  OMAP: DSS2: omap_dss_probe() conditional compilation cleanup
  OMAP: DSS2: Fix omap_dss_probe() error path

 drivers/video/omap2/dss/core.c |   89 +++++++++++++++++++++++----------------
 drivers/video/omap2/dss/dss.h  |   50 ++++++++++++++++++++++
 2 files changed, 102 insertions(+), 37 deletions(-)

