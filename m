From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP: gpmc-smsc911x: always set irq flags to
 IORESOURCE_IRQ_LOWLEVEL
Date: Wed, 1 Jun 2011 04:45:44 -0700
Message-ID: <20110601114544.GA11352@atomide.com>
References: <cover.1302992702.git.mike@compulab.co.il>
 <7cf1c52880f0f32922c8973cb90aadcd2e728be1.1302992702.git.mike@compulab.co.il>
 <20110531103255.GV11352@atomide.com>
 <4DE623A5.3080300@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49548 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753128Ab1FALpr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 07:45:47 -0400
Content-Disposition: inline
In-Reply-To: <4DE623A5.3080300@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

* Igor Grinberg <grinberg@compulab.co.il> [110601 04:29]:
> On 05/31/11 13:32, Tony Lindgren wrote:
> 
> > * Mike Rapoport <mike@compulab.co.il> [110416 15:20]:
> >> SMSC911x devices attached to OMAP GPMC always use low level irqs.
> >> Setting the appropriate flag in the irq resourse strucure allows using
> >> .flags field in the omap_smsc911x_platform_data for driver specific
> >> flags
> > Looks like this one needs to be refreshed against v3.0-rc1.
> 
> Both patches are already in v3.0-rc1... Working late? ;)

That explains, maybe it's time for me to go to the back room and take a nap :)

I was using both patchwork and my mailbox as patchwork was missing some
patches and did not allow login yesterday..

Tony
