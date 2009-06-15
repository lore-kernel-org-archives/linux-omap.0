From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH -pm 0/2] SDRC tweaks for stuck DLL state machine
Date: Mon, 15 Jun 2009 15:42:53 -0700
Message-ID: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:46720 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbZFOWm4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 18:42:56 -0400
Received: by qyk3 with SMTP id 3so778639qyk.33
        for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2009 15:42:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Chan <mikechan@google.com>

This series comes from Richard Woodruff to fix some rare cases of
the DLL state machine getting stuck.

Applies to current PM branch.

Thanks to Mike Chan <mikechan@google.com> for testing and confirming fix.

Richard Woodruff (2):
  SDRC: kick DLL state machine if it gets stuck
  SDRC: tabify dll lock code

 arch/arm/mach-omap2/sleep34xx.S |   60 +++++++++++++++++++++++++-------------
 1 files changed, 39 insertions(+), 21 deletions(-)

