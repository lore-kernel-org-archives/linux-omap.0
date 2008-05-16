From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Remove __REG macro access for multi-omap
Date: Fri, 16 May 2008 14:07:51 -0700
Message-ID: <1210972076-23911-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65271 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762190AbYEPVH4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 17:07:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: david-b@pacbell.net, felipe.balbi@nokia.com, Tony Lindgren <tony@atomide.com>

Hi all,

Following patches remove the __REG macros as they don't play nicely
with multi-omap if we have different IO bases as we cannot replace
them easily with C functions if needed for non-optimized multi-omap.

The biggest patch is the USB conversion.. Please everybody try out
these patches and let me know of any issues.

There are still some unnecessary read-modify-write read-modify-write
cycles that could be replaced with single read-modify-write cycle.
Please also keep your eyes open for register width issues between
readw/writew and readl/writel.

Regards,

Tony

