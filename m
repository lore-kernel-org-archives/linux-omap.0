From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP3: clean up ASM idle code
Date: Thu, 18 Nov 2010 09:41:18 -0800
Message-ID: <20101118174118.GD9264@atomide.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
 <1290091906-32539-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50876 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab0KRRlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 12:41:24 -0500
Content-Disposition: inline
In-Reply-To: <1290091906-32539-3-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Vishwanath BS <vishwanath.bs@ti.com>, Jean Pihet <j-pihet@ti.com>

* Jean Pihet <jean.pihet@newoldbits.com> [101118 06:43]:
> From: Vishwanath BS <vishwanath.bs@ti.com>
> 
> Clean up of the ASM code:
> - reworked and simplified the execution paths, for better
>    readability and to avoid duplication of code,
> - reworked the comments for better readability,
> - reworked the code formating and alignment,
> - added comments for the i443 errata workarounds,
> - replaced the cache flush code by a call to the kernel
>    common code for ARMv7 (v7_flush_kern_cache_all), which is
>    better maintained and so more mature,
> - clean up of non used symbols.

This should be broken into several patches.

The first patch should be to use v7_flush_kern_cache_all
instead of the buggy older copy of that in sleep34xx.S.

After that, any readability and formatting patches should
contain no functional changes.

Regards,

Tony
