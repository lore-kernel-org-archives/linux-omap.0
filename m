From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: Allow NAND transfer mode to be
 specified in DT
Date: Thu, 16 May 2013 08:56:06 -0700
Message-ID: <20130516155605.GU5600@atomide.com>
References: <51767D49.1010909@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51912 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab3EPP4J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 11:56:09 -0400
Content-Disposition: inline
In-Reply-To: <51767D49.1010909@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>

* Mark Jackson <mpfj-list@newflow.co.uk> [130423 05:28]:
> OMAP devices support various NAND transfer modes.
> 
> Currently all device-tree definitions will use the default "prefetch
> polled" mode, so this patch enables the transfer mode to be specified
> in the device-tree.
> 
> Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>

Thanks applying into omap-for-v3.11/gpmc with Pekon's ack.

Regards,

Tony
