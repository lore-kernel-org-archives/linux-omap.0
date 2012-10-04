From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] ARM: OMAP: SmartReflex: pass device dependent data via platform data
Date: Thu, 04 Oct 2012 16:40:20 -0700
Message-ID: <87r4pdst5n.fsf@deeprootsystems.com>
References: <1349369231-25204-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:33661 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab2JDXkS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 19:40:18 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so470811dak.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 16:40:18 -0700 (PDT)
In-Reply-To: <1349369231-25204-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Thu, 4 Oct 2012 18:47:09 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Anton Vorontsov <cbou@mail.ru>, J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Remove the device dependent code (ex. cpu_is_xxx()) and settings
> from the driver code and instead pass them via the platform
> data. This allows a clean separation of the driver code and the platform
> code, as required by the move of the platform header files to
> include/linux/platform_data.
>
> Note about the smartreflex functional clocks: the smartreflex fclks
> are derived from sys_clk and have the same name as the main_clk from
> the hwmod entry, in order for the SmartReflex driver to request the
> fclk (using clk_get(dev, "fck")).
>
> Based on mainline 3.6.0. Boot tested on OMAP3&4 platforms.

Thanks, queuing this version for v3.8 (branch: for_3.8/pm/sr)

Kevin

P.S. in the future, It helps reviewers and maintainers if there's some
versioning in the patches (e.g. PATCH v3 0/2]), especially when updated
versions come in quick succession.  Thanks.

