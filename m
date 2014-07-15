From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2+: gpmc-nand: Use dynamic
 platform_device_alloc()
Date: Tue, 15 Jul 2014 00:25:45 -0700
Message-ID: <20140715072544.GA28715@atomide.com>
References: <1401891875-27843-1-git-send-email-lisovy@merica.cz>
 <53BFEA6A.4020501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52461 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932436AbaGOH1L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jul 2014 03:27:11 -0400
Content-Disposition: inline
In-Reply-To: <53BFEA6A.4020501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Rostislav Lisovy <lisovy@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, Pekon Gupta <pekon@ti.com>, Michal Vokac <vokac.m@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Rostislav Lisovy <lisovy@merica.cz>

* Roger Quadros <rogerq@ti.com> [140711 06:47]:
> On 06/04/2014 05:24 PM, Rostislav Lisovy wrote:
> > GPMC controller supports up to 8 memory devices connected to it.
> > Since there is one statically allocated "struct platform_device
> > gpmc_nand_device" it is not possible to configure the system to
> > use more than one NAND device connected to the GPMC. This
> > modification makes it possible to use up to 8 NAND devices
> > connected to the GPMC controller.
> > 
> > Signed-off-by: Rostislav Lisovy <lisovy@merica.cz>
> 
> pushed to git@github.com:rogerq/linux.git	for-v3.17/gpmc-omap
> 
> Tony,
> 
> You can please pull all omap-gpmc patches for 3.17 from there. Thanks.

OK so just this one fix, merging into omap-for-v3.17/fixes-not-urgent.

Regards,

Tony
