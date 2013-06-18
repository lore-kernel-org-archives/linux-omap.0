From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V2] ARM: OMAP3+: am33xx id: Add new am33xx specific
 function to check dev_feature
Date: Tue, 18 Jun 2013 03:04:58 -0700
Message-ID: <20130618100458.GH5523@atomide.com>
References: <1368785621-31591-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33356 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754164Ab3FRKFB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 06:05:01 -0400
Content-Disposition: inline
In-Reply-To: <1368785621-31591-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, linux-arm-kernel@lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [130517 03:19]:
> Layout of DEV_FEATURE register (offset = 0x604) is different
> between TI81xx and AM33xx device, so create separate function
> which will check for features available on specific AM33xx SoC
> and set the flags accordingly.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>

Thanks, applying into omap-for-v3.11/soc.

Regards,

Tony
