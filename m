From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2+: devices: Silence hwmod lookup
 failures (dmic/mcpdm)
Date: Wed, 12 Jun 2013 07:10:50 -0700
Message-ID: <20130612141050.GU8164@atomide.com>
References: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48838 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268Ab3FLOKy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 10:10:54 -0400
Content-Disposition: inline
In-Reply-To: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130611 01:37]:
> Hi,
> 
> Small patches to silence the hwmod lookup failures in case when we boot the
> kernel on boards where the IPs are not present (OMAP2/3 vs McPDM, DMIC,
> HDMI audio).

Thanks applying into omap-for-v3.11/fixes-non-critical.

Regards,

Tony

> Peter Ujfalusi (3):
>   ARM: OMAP2+: devices: Do not print error when McPDM hwmod lookup fails
>   ARM: OMAP2+: devices: Do not print error when DMIC hwmod lookup fails
>   ARM: OMAP2+: devices: Do not print error when dss_hdmi hwmod lookup
>     fails
> 
>  arch/arm/mach-omap2/devices.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> -- 
> 1.8.2.1
> 
