From: Thomas Weber <weber@corscience.de>
Subject: [PATCHv4 0/4] omap3: Devkit8000: misc fixes
Date: Wed, 19 Jan 2011 09:19:22 +0100
Message-ID: <1295425166-25540-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56697 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659Ab1ASITl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 03:19:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Morsing <daniel.morsing@gmail.com>, charu@ti.com, sshtylyov@mvista.com

Here is a set of misc fixes for the devkit8000.

The only really notable one is the lcd enable gpio fix. It gets rid
of some nasty low level twl4030 calls and replaces them with generic gpio
calls. It also fixes a bug where the screen would not turn off when
blanking.

Changes from v1: 
	Pull the indention fix into "Change lcd power pin".
	Change the pin for lcd pwren.
	Fix the pullup/pulldown configuration after lcd prwen correction.

Changes from v2:
	Better comment for removing low level functions used for twl4030 gpio
	Fix indention => indentation in comment

Changed from v3:
	Use return value of gpio_request.
	Fix indentation of one curly brace.

Daniel Morsing (1):
  OMAP3: Devkit8000: Fix tps65930 pullup/pulldown configuration

Thomas Weber (3):
  OMAP3: Devkit8000: Change lcd power pin
  OMAP3: Devkit8000: Check return value of gpio_request
  OMAP3: Devkit8000: Fix indentation

 arch/arm/mach-omap2/board-devkit8000.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

-- 
1.7.4.rc2

