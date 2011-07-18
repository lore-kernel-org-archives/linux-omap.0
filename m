From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/6] OMAP4: Add missing clock divider for OCP_ABE_ICLK
Date: Mon, 18 Jul 2011 16:46:26 -0500
Message-ID: <4E24A9B2.5070507@ti.com>
References: <1310685865-3249-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1107150216380.16606@utopia.booyaka.com> <4E204FFC.5080700@ti.com> <4E249E55.6010004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38526 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab1GRVqc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jul 2011 17:46:32 -0400
In-Reply-To: <4E249E55.6010004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, b-cousson@ti.com


On 7/18/2011 15:57, Jon Hunter wrote:
> On further inspection of the clock44xx_data.c, it appears that all
> interface clocks are called xxx_fck and not xxx_ick. I will ask Benoit
> about this. However, this particular clock we are dealing with here is
> an interface clock.

Actually, the above it not true. I will ask Benoit about the naming of 
the slimbus interface clocks.

Jon
