From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/10] arm: omap2: fix regulator warnings
Date: Thu, 22 Dec 2011 10:23:13 -0800
Message-ID: <20111222182313.GP24444@atomide.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
 <1324341747-5922-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22778 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751671Ab1LVSXP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 13:23:15 -0500
Content-Disposition: inline
In-Reply-To: <1324341747-5922-5-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-kernel@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Felipe Balbi <balbi@ti.com>, Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@arm.linux.org.uk>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>

* Felipe Contreras <felipe.contreras@gmail.com> [111219 16:11]:
> warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3 && MACH_OMAP_4430SDP && MACH_OMAP4_PANDA && TPS6105X) selects REGULATOR_FIXED_VOLTAGE which has unmet direct dependencies (REGULATOR)

Thanks applying into fixes-non-critical-part3.

Tony
