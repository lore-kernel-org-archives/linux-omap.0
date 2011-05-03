From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCHv2 0/2] OMAP: DSS: Support new dpi panels
Date: Tue,  3 May 2011 09:07:35 +0200
Message-ID: <1304406457-5109-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51514 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab1ECHHm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 03:07:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Hi all,

These patches add support for two new panels to the generic-dpi-panel.

The first patch adds support for the Seiko 70WVW1TZ3 LCD panel, and the second
adds support for the Powertip PH480272T LCD panel.

Tested with an IGEP v2 board.

Changes since v1:
  - Change the names of both panels in the panel_config struct to
    include the name of the manufacturer.
  - Mention the board which uses those panels.

Please consider to add in next merge window, thanks,

Enric Balletbo i Serra (2):
  OMAP: DSS2: Support for Seiko 70WVW1TZ3
  OMAP: DSS2: Support for Powertip PH480272T

 drivers/video/omap2/displays/panel-generic-dpi.c |   50 ++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

