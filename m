From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] ARM: AM33xx: hwmod: Add RNG module data
Date: Wed, 28 Aug 2013 18:48:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308281845560.22040@utopia.booyaka.com>
References: <1375777984-6267-1-git-send-email-lokeshvutla@ti.com> <1375777984-6267-2-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34205 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab3H1Ssl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Aug 2013 14:48:41 -0400
In-Reply-To: <1375777984-6267-2-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org, rob@landley.net, rnayak@ti.com, benoit.cousson@linaro.org

Hi

On Tue, 6 Aug 2013, Lokesh Vutla wrote:

> Add RNG hwmod data for AM33xx SoC.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

I tried to queue this one, but it caused AM33xx boots to hang.  
Thought it might be related to the patch ordering -- seems to me that 
the clock change patch needed to come before this patch -- but if I 
recall correctly, both BeagleBone and BeagleBone-LT still hung.  

Also, this patch created a sparse warning.

Could you take another look at this patch?  Maybe try basing off of this 
tag:

git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.12/omap-prcm-hwmod

Fix the sparse problem, and see if the patch boots for you?

thanks


- Paul
