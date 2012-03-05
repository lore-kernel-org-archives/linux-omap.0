From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] OMAP2+: ads7846_init: put gpio_pendown into pdata
 if it's provided
Date: Mon, 5 Mar 2012 11:58:10 -0800
Message-ID: <20120305195810.GR12083@atomide.com>
References: <1324562448-24066-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27872 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757515Ab2CET6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 14:58:12 -0500
Content-Disposition: inline
In-Reply-To: <1324562448-24066-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@infradead.org, sasha_d@emcraft.com, Igor Grinberg <grinberg@compulab.co.il>

* Ilya Yanok <yanok@emcraft.com> [111222 05:29]:
> If platform data is provided by the caller gpio_pendown is put into
> unused static ads7846_config structure and effectively has no effect.
> Of course caller can set gpio_pendown field in platform data himself
> but it seems natural to do this in ads7846_init to remove duplication.

Thanks applying into fixes-non-critical-part2.

Regards,

Tony
