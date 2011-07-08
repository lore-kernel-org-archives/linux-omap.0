From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] OMAP2+: hwmod_data: I2C updates for v3.1
Date: Fri, 8 Jul 2011 17:40:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107081736060.15984@utopia.booyaka.com>
References: <1310141504-13688-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35806 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab1GHXkS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 19:40:18 -0400
In-Reply-To: <1310141504-13688-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Andy Green <andy@warmcat.com>, linux-arm-kernel@lists.infradead.org

Hi

On Fri, 8 Jul 2011, Kevin Hilman wrote:

> I've separated out the omap_hwmod data changes from Andy's original
> series so they can be easier managed with the rest of the hwmod data
> changes.
> 
> This series applies against v3.0-rc6 and is also available here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.1/i2c-hwmod-data
> 
> Kevin
> 
> Andy Green (3):
>   I2C: OMAP2+: Set hwmod flags to only allow 16-bit accesses to i2c
>   I2C: OMAP2+: Tag all OMAP2+ hwmod defintions with I2C IP revision
>   I2C: OMAP2+: add correct functionality flags to all omap2plus i2c
>     dev_attr

Unfortunately, this subset of patches doesn't compile on its own.  To get 
these to build, I also had to pull in these patches from Andy's 
series:

  I2C: OMAP2+: increase omap_i2c_dev_attr flags from u8 to u32
  I2C: OMAP2+:  Introduce I2C IP versioning constants
  I2C: OMAP1/OMAP2+: create omap I2C functionality flags for each cpu_... test

So I've queued the patches that you sent, plus the above three, for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'i2c_fixes_3.1' branch.

thanks

- Paul
