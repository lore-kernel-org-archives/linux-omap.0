From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] arm: omap4: hsmmc: check for null pointer
Date: Tue, 8 May 2012 16:36:01 -0700
Message-ID: <20120508233600.GU5088@atomide.com>
References: <20120423144348.GF26302@arwen.pp.htv.fi>
 <1335355066-26279-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22072 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab2EHXgE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 19:36:04 -0400
Content-Disposition: inline
In-Reply-To: <1335355066-26279-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

* Balaji T K <balajitk@ti.com> [120425 04:57]:
> platform_device pdev can be NULL if CONFIG_MMC_OMAP_HS is not set.
> Add check for NULL pointer. while at it move the duplicated functions
> to omap4-common.c
> 
> Fixes the following boot crash seen with omap4sdp and omap4panda
> when MMC is disabled.

Thanks applying into fixes-non-critical, this is a bit too intrusive for
the -rc series.

Regards,

Tony
