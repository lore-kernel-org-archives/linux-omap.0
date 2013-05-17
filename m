From: yegorslists@googlemail.com
Subject: [PATCH] broken musb on am35xx
Date: Fri, 17 May 2013 14:30:33 +0200
Message-ID: <1368793834-31627-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:46488 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946Ab3EQMbL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 08:31:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com


The ick and fck clock names nave been changed. This patch updates these names. Please see this discussion for reference:

https://patchwork.kernel.org/patch/1231671/

Yegor
