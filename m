From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 01/11] ARM: omap: edma: add suspend suspend/resume
 hooks
Date: Mon, 14 Jul 2014 04:05:53 -0700
Message-ID: <20140714110552.GA20068@atomide.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <1405047349-15101-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34869 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752252AbaGNLHW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jul 2014 07:07:22 -0400
Content-Disposition: inline
In-Reply-To: <1405047349-15101-2-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Daniel Mack <zonque@gmail.com>

* Dave Gerlach <d-gerlach@ti.com> [140710 19:58]:
> From: Daniel Mack <zonque@gmail.com>
> 
> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
> 
> All information can be reconstructed by already known runtime
> information.
> 
> As we now use some functions that were previously only used from __init
> context, annotations had to be dropped.

This is something Sekhar needs to look at, did you maybe forget
to Cc him?

Regards,

Tony
