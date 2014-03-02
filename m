From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 0/5] add parallel NAND support for TI's new OMAPx and
 AMxx platforms
Date: Sun, 2 Mar 2014 10:17:10 -0800
Message-ID: <20140302181710.GD18496@atomide.com>
References: <1391606914-9947-1-git-send-email-pekon@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA6FE42@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20243 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751554AbaCBSRi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Mar 2014 13:17:38 -0500
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA6FE42@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "bcousson@baylibre.com" <bcousson@baylibre.com>, "Benoit Cousson (benoit.cousson@linaro.org)" <benoit.cousson@linaro.org>, linux-omap <linux-omap@vger.kernel.org>

* Gupta, Pekon <pekon@ti.com> [140212 20:30]:
> Hi Benoit, Tony,
>  
> >From: Gupta, Pekon
> >
> >This patch-set adds and updates parallel NAND support on following TI platforms
> > - AM335x (am335x-evm)
> > - DRA7xx (dra7-evm
> > - AM43xx (am43X-epos-evm)
> >
> >In addition, following OMAP2+/GPMC patch is also added in this series as
> >it add checks DRA7xx and AM43xxx platforms for non-DT kernels.
> >	ARM: OMAP2+: gpmc: update gpmc_hwecc_bch_capable() for new platforms
> >
> Please let me know, if this patch-set is in acceptable state,
> Or should I rebase it against any specific branch at your side ?

Thanks applying all except 4/5 into omap-for-v3.15/dt. Patch 4
should be just updated for the macros, I'll comment on that
separately.

Regards,

Tony
