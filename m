From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/14] Omap patches for post 2.6.25
Date: Mon, 17 Mar 2008 11:42:24 +0200
Message-ID: <1205746958-11242-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62052 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbYCQJnR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:17 -0400
In-Reply-To: omap-upstream-2008-03-17-114234
References: omap-upstream-2008-03-17-114234
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi all,

Attached are patches for common omap code and omap1 specific code for
post 2.6.25 for review. The patches contain updates for gpiolib,
timers and pin multiplexing.

The patch for TPS65010 I2C driver is included in this series as it involves
some board updates also. This has been discussed already on the I2C list,
and it's OK with Jean [1].

I'm still working on patch set for arch/arm/mach-omap2, and will post it
within next few days.

Regards,

Tony

[1] http://lists.lm-sensors.org/pipermail/i2c/2008-March/003031.html
