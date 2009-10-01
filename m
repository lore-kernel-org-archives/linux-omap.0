From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/2] twl4030 power support for 3430SDP
Date: Thu,  1 Oct 2009 11:54:20 -0700
Message-ID: <1254423262-25380-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:64592 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbZJASyZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 14:54:25 -0400
Received: by pzk7 with SMTP id 7so351457pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 11:54:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I've been carrying these in the PM branch, but now that twl4030 power
support is in mainline, these can be queued for 2.6.33.

Kevin Hilman (1):
  OMAP3: PM: 3430SDP: add initial twl4030 power scripts

Rajendra Nayak (1):
  OMAP3: PM: 3430SDP: Update twl4030 power scripts and device groups

 arch/arm/mach-omap2/board-3430sdp.c |   93 ++++++++++++++++++++++++++++++++++-
 1 files changed, 91 insertions(+), 2 deletions(-)

