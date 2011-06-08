From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Clock & PM breakage in 3.0-rc2
Date: Wed, 8 Jun 2011 17:31:43 +0300
Message-ID: <20110608173143.0b03ebac.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43313 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab1FHOam (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 10:30:42 -0400
Received: by ewy4 with SMTP id 4so193486ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Jun 2011 07:30:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Hi

While debugging another issue I noticed that McBSP2 clock on Nokia N900
doesn't get disabled in 3.0-rc2 after calling
pm_runtime_put_sync(mcbsp->dev) and the fclk usecount remains active if
the pm_runtime_get_sync(mcbsp->dev) was ever called activating it.

I believe this affects other drivers too as the system is not able to
enter into retention idle even if the mcbsp clocks are off.

I traced breakage to commit 638080c ("OMAP2+ / PM: move runtime
PM implementation to use device power domains").

Reventing that and and 2064af9 ("PM: Revert "driver core: platform_bus:
allow runtime override of dev_pm_ops") makes both mcbsp clocks and
retention idle working again.

Unfortunately I'm not able to see quickly what would be the right fix.

-- 
Jarkko
