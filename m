From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/10] arm: omap4: fix kconfig warning
Date: Thu, 22 Dec 2011 10:22:40 -0800
Message-ID: <20111222182240.GN24444@atomide.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
 <1324341747-5922-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27880 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab1LVSWq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 13:22:46 -0500
Content-Disposition: inline
In-Reply-To: <1324341747-5922-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-kernel@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Felipe Balbi <balbi@ti.com>, Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@arm.linux.org.uk>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>

* Felipe Contreras <felipe.contreras@gmail.com> [111219 16:11]:
> warning: (ARCH_OMAP4 && ARCH_VEXPRESS_CA9X4) selects ARM_ERRATA_720789 which has unmet direct dependencies (CPU_V7 && SMP)

Thanks applying into fixes-non-critical-part3.

Tony
