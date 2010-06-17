From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: no network on 3630/Zoom3 using omap3_defconfig
Date: Thu, 17 Jun 2010 16:38:31 -0700
Message-ID: <87iq5hcjrc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48436 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649Ab0FQXie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 19:38:34 -0400
Received: by pwi1 with SMTP id 1so195585pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 16:38:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vishwanath.bs@ti.com
Cc: linux-omap@vger.kernel.org

Vishwa,

Can you have someone investigate/debug why using omap3_defconfig on
3630/Zoom3 results in no network while using omap_zoom3_defconfig
seems to work?

In addition, this would also be a good opportunity to get rid of the
Zoom3-specific defconfig and move towards using the common
omap3_defconfig.

Kevin

