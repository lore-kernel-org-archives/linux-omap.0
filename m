From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/4] Add I2C support to AM3517EVM
Date: Wed, 06 Jan 2010 15:51:51 -0800
Message-ID: <87vdfe94h4.fsf@deeprootsystems.com>
References: <hvaibhav@ti.com>
	<1262614597-21685-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:61574 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932967Ab0AFXv6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 18:51:58 -0500
Received: by pxi4 with SMTP id 4so832026pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 15:51:56 -0800 (PST)
In-Reply-To: <1262614597-21685-1-git-send-email-hvaibhav@ti.com> (hvaibhav@ti.com's message of "Mon\,  4 Jan 2010 19\:46\:33 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com

hvaibhav@ti.com writes:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> This series of patchset adds support for I2C bus interface along with
> respective slave devices - 
> 	- RTC-S35390A
> 	- TSC2004
> 	- TVP5146 decoder along with VPFE-capture
>
> Vaibhav Hiremath (4):
>   AM3517EVM: Enable I2C Support
>   AM3517: Add support for TSC2004 driver
>   AM3517: Add RTC-S35390A support
>   AM3517: Add VPFE Capture driver support
>
>  arch/arm/mach-omap2/board-am3517evm.c |  249 +++++++++++++++++++++++++++++++++
>  1 files changed, 249 insertions(+), 0 deletions(-)

Please add some more detailed changelogs in this series.

Thanks,

Kevin
