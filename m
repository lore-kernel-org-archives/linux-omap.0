From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 3/4] TI816X: Create board support and enable build
 for TI816X EVM
Date: Tue, 15 Feb 2011 10:05:34 -0800
Message-ID: <20110215180533.GA20795@atomide.com>
References: <1297791368-32042-1-git-send-email-hemantp@ti.com>
 <20110215180139.GF11199@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64433 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451Ab1BOSGA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 13:06:00 -0500
Content-Disposition: inline
In-Reply-To: <20110215180139.GF11199@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hemant Pedanekar <hemantp@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110215 10:00]:
> On Tue, Feb 15, 2011 at 11:06:08PM +0530, Hemant Pedanekar wrote:
> > +static void __init ti8168_evm_init_irq(void)
> > +{
> > +	omap_board_config = ti8168_evm_config;
> > +	omap_board_config_size = ARRAY_SIZE(ti8168_evm_config);
> > +	omap2_init_common_infrastructure();
> > +	omap2_init_common_devices(NULL, NULL);
> > +	omap_init_irq();
> > +}
> 
> What here can use the new init_early hook in the machine record?

I can fix this up for the init_early changes when I merge the branches
together.

Tony
