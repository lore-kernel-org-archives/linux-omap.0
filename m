From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH v2 0/2] ARM: update cpuinfo to print SoC model name
Date: Wed, 30 Jan 2013 11:30:56 +0530
Message-ID: <5108B718.3050507@ti.com>
References: <1359506337-21619-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44035 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385Ab3A3F7x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jan 2013 00:59:53 -0500
In-Reply-To: <1359506337-21619-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, eduardo.valentin@ti.com

On Wednesday 30 January 2013 06:08 AM, Ruslan Bilovol wrote:
> The following patches update cpuinfo to print SoC
> model name for ARM.
> The first patch exactly makes needed changes for ARM
> architecture and adds a common approach to show SoC name.
> Second patch uses this approach for OMAP4 SoCs (as live
> example).
>
> Looks like there were few attempts to do similar
> changes to cpuinfo without any luck (had stuck
> on review) so this functionality is still not
> in the kernel yet.
> In this patch series the update to cpuinfo is very
> short (10 lines) and easy.
>
> Comments are welcome as usual
>
As most of the people already commented, your purpose
behind the series isn't clear so please give examples
where and why you need  device type information from
user-space.

Regards,
Santosh


