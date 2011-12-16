From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: I2C: prepare to use hwmod reset in
 driver
Date: Fri, 16 Dec 2011 13:17:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112161314180.12660@utopia.booyaka.com>
References: <alpine.DEB.2.00.1112160254320.12660@utopia.booyaka.com> <20111216195002.GL32251@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54023 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760073Ab1LPUR3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 15:17:29 -0500
In-Reply-To: <20111216195002.GL32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Shubhrajyoti <shubhrajyoti@ti.com>, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi

On Fri, 16 Dec 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [111216 01:24]:
> > The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:
> > 
> >   Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)
> > 
> > are available in the git repository at:
> >   git://git.pwsan.com/linux-2.6 i2c_reset_devel_3.3
> > 
> > Shubhrajyoti D (2):
> >       ARM: OMAP: omap_device: add omap_device_reset to reset all the hwmods in the device
> >       ARM: OMAP: I2C: Reset support
> > 
> >  arch/arm/plat-omap/i2c.c                      |    2 ++
> >  arch/arm/plat-omap/include/plat/omap_device.h |    1 +
> >  arch/arm/plat-omap/omap_device.c              |   22 ++++++++++++++++++++++
> >  include/linux/i2c-omap.h                      |    1 +
> >  4 files changed, 26 insertions(+), 0 deletions(-)
> 
> Can you please update shi to leave out the extra callback
> function int (*device_reset) (struct device *dev) as I'd
> rather see that happen with pm_runtime calls?

What PM runtime call is used to reset a device?


- Paul
