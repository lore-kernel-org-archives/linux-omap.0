From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 08/10] ARM: OMAP5: hwmod data: Create initial OMAP5 SOC
 hwmod data
Date: Thu, 24 Jan 2013 15:20:49 +0530
Message-ID: <510103F9.4080601@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com> <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com> <20130118171500.GC15361@atomide.com> <50FCF838.6000105@ti.com> <50FD5993.5010008@ti.com> <20130121180113.GA22517@atomide.com> <50FE909B.1020001@ti.com> <20130122183942.GO15361@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46577 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab3AXJvE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 04:51:04 -0500
In-Reply-To: <20130122183942.GO15361@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>

On Wednesday 23 January 2013 12:09 AM, Tony Lindgren wrote:
> It seems that we should have the iospace available in the driver
> at that point. And it should be also available to the runtime PM
> code in hwmod in the device somewhere?

I couldn't find anything as part of the device. Definitely not the
ioremaped address. There's a device_private->driver_data which the
drivers can use to populate the ioremaped address but I am sure thats
not whats its meant for.
