From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V3] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
Date: Wed, 25 Jul 2012 14:41:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207251438210.23542@utopia.booyaka.com>
References: <1343214422-28718-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48120 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab2GYUlT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 16:41:19 -0400
In-Reply-To: <1343214422-28718-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hello Vaibhav,

On Wed, 25 Jul 2012, Vaibhav Hiremath wrote:

> This patch adds HWMOD data for all the peripherals of
> AM335X device and also hooks up to the existing OMAP framework.

Looks pretty good.  One question:

> +static struct omap_hwmod am33xx_ehrpwm0_hwmod = {
> +	.name		= "ehrpwm.0",

These IP blocks and the ECAP IP blocks have periods in their names.
The rest of the IP block named in the file don't use periods -- which
is also the style used by the rest of the OMAP SoCs.  Is there
some reason that these have periods in their names?


- Paul
