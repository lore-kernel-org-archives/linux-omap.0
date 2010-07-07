From: Tony Lindgren <tony@atomide.com>
Subject: OK to base some patches on lmb branch?
Date: Wed, 7 Jul 2010 13:52:14 +0300
Message-ID: <20100707105213.GJ1920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62420 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab0GGKwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 06:52:21 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi Russell,

Is your lmb branch going to stay static?

I'd like to base a patch unifying omap3 map_io on top of that
to avoid merge conflicts:

https://patchwork.kernel.org/patch/108775/

Otherwise it will conflict with your LMB related patch
"Convert to use ->reserve method to reserve boot time memory".

Regards,

Tony

