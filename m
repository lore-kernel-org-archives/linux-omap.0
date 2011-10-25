From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] of: Add a reg-names property to name reg entries
Date: Tue, 25 Oct 2011 10:26:33 +0200
Message-ID: <20111025082632.GJ4429@atomide.com>
References: <1319471697-8970-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57418 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750998Ab1JYI0k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Oct 2011 04:26:40 -0400
Content-Disposition: inline
In-Reply-To: <1319471697-8970-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [111024 17:20]:
> +		compatible = "ti,mcasp";
> +		reg = <0 0x10 0x10>, <0 0x20 0x10>,
> +		      <1 0x10 0x10>, <1 0x20 0x10>;
> +		reg-names = "mpu", "dat",
> +			    "dma", "dma_dat";

Hmm for some systems looks like this can also solve how to pass the
mux signal names cleanly from DT.

For some systems we may also need reg-bits in addition to reg-names
to describe the signal names. Or do we already have something for
that?

Tony

