From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: gpmc: get number of useable GPMC
 chip-selects via DT
Date: Wed, 12 Jun 2013 09:57:43 -0700
Message-ID: <20130612165742.GG8164@atomide.com>
References: <1370001691-29320-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58326 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754494Ab3FLQ5p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 12:57:45 -0400
Content-Disposition: inline
In-Reply-To: <1370001691-29320-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jgchunter@gmail.com>

* Gupta, Pekon <pekon@ti.com> [130531 05:07]:
> From: "Gupta, Pekon" <pekon@ti.com>
> 
> This patch enables usage of DT property 'gpmc,num-cs' as already documented in
> Documentation/devicetree/bindings/bus/ti-gpmc.txt
> 
> Though GPMC hardware supports upto 8 chip-selects, but all chip-selects may
> not be available for use because:
> - chip-select pin may not be bonded out at SoC device boundary.
> - chip-select pin-mux may conflict with other pins usage.
> - board level constrains.
> 
> gpmc,num-cs allows user to configure maximum number of GPMC chip-selects
> available for use on any given platform. This ensures:
> - GPMC child nodes having chip-selects within allowed range are only probed.
> - And un-used GPMC chip-selects remain blocked.(may be for security reasons).

Thanks applying this patch into omap-for-v3.11/gpmc.

Regards,

Tony
