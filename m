From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP: gpmc-smsc911x: always set irq flags to
 IORESOURCE_IRQ_LOWLEVEL
Date: Tue, 31 May 2011 03:32:55 -0700
Message-ID: <20110531103255.GV11352@atomide.com>
References: <cover.1302992702.git.mike@compulab.co.il>
 <7cf1c52880f0f32922c8973cb90aadcd2e728be1.1302992702.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:17550 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752898Ab1EaKc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 06:32:58 -0400
Content-Disposition: inline
In-Reply-To: <7cf1c52880f0f32922c8973cb90aadcd2e728be1.1302992702.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org

* Mike Rapoport <mike@compulab.co.il> [110416 15:20]:
> SMSC911x devices attached to OMAP GPMC always use low level irqs.
> Setting the appropriate flag in the irq resourse strucure allows using
> .flags field in the omap_smsc911x_platform_data for driver specific
> flags

Looks like this one needs to be refreshed against v3.0-rc1.

Tony
