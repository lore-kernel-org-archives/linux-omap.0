From: <mythripk@ti.com>
Subject: [PATCH v4 0/2] OMAPDSS: HDMI: Boardfile cleanup
Date: Mon, 2 Jan 2012 14:02:36 +0530
Message-ID: <1325493158-25740-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43948 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843Ab2ABIkK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jan 2012 03:40:10 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q028e8JY026685
	for <linux-omap@vger.kernel.org>; Mon, 2 Jan 2012 02:40:09 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q028e71n013620
	for <linux-omap@vger.kernel.org>; Mon, 2 Jan 2012 14:10:08 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Clean up of boardfiles to have the functions common to differnt boards in a
common display file, Also in some OMAP4 boards external pull-up's are enabled
thus enabling internal pull up should be a parameter from the boardfile.

changes since v3 : Comment improvement to move some portion from boardfile to
display.
changes since v2 : Make the flag as enum.
changes since v1 : Make omap hdmi_init generic to handle different parameters
and pass the pull up as a flag instead of int. 

Mythri P K (2):
  OMAPDSS: HDMI: Move duplicate code from boardfile
  OMAPDSS: HDMI: Disable DDC internal pull up

 arch/arm/mach-omap2/board-4430sdp.c    |   23 ++++++------------
 arch/arm/mach-omap2/board-omap4panda.c |   25 +++++++-------------
 arch/arm/mach-omap2/display.c          |   39 ++++++++++++++++++++++++++++++++
 include/video/omapdss.h                |    6 +++++
 4 files changed, 62 insertions(+), 31 deletions(-)

-- 
1.7.5.4

