From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAP2PLUS: DSS2: Clean up omap_display_init()
Date: Mon, 18 Apr 2011 13:08:17 +0300
Message-ID: <1303121297.2062.12.camel@deskari>
References: <1303099333-13327-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53393 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751792Ab1DRKIY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 06:08:24 -0400
Received: by fxm18 with SMTP id 18so3179507fxm.28
        for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 03:08:21 -0700 (PDT)
In-Reply-To: <1303099333-13327-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com

On Mon, 2011-04-18 at 09:32 +0530, Archit Taneja wrote:
> Currently, omap_display_init() maintains arrays for hwmod name(oh_name) and the
> correspnding platform_device name(dev_name) needed by omap_device_build().
> A variable oh_count keeps a track of the number of devices to build from oh_name
> based on what omap revision it is.
> 
> Clean this up by maintaining an array of omap_dss_hwmod_data struct which is
> defined for each omap revision as suggested by Tomi Valkeinen. Assign the
> corresponding omap_dss_hwmod_data array struct to the pointer curr_dss_hwmod in
> omap_display_init().
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
> v2:
> -Remove unnecessary extra struct
> -add __intdata in array definitions
> 
> Tested on OMAP 3430sdp and OMAP4430 sdp.
> 
> Can be applied over:
> https://gitorious.org/linux-omap-dss2/linux/commits/master
> 
>  arch/arm/mach-omap2/display.c |   75 ++++++++++++++++++++++++++--------------
>  1 files changed, 49 insertions(+), 26 deletions(-)

Thanks, applied.

 Tomi


