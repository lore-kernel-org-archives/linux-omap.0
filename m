From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2+: SR Layer Cleanup.
Date: Wed, 06 Apr 2011 08:33:32 -0700
Message-ID: <87mxk3iecz.fsf@ti.com>
References: <1301378352-29269-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46685 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932099Ab1DFPdi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Apr 2011 11:33:38 -0400
Received: by mail-iw0-f176.google.com with SMTP id 19so2286764iwr.21
        for <linux-omap@vger.kernel.org>; Wed, 06 Apr 2011 08:33:35 -0700 (PDT)
In-Reply-To: <1301378352-29269-1-git-send-email-shweta.gulati@ti.com> (Shweta
	Gulati's message of "Tue, 29 Mar 2011 11:29:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Shweta,

Shweta Gulati <shweta.gulati@ti.com> writes:

> As a part of Voltage Layer Cleanup Patches,
> submitted by Kevin Hilman, Voltage domain
> Information is removed from hwmod,
> So the patch removes 'vdd_name' info from omap_hwmod
> and adds that info into dev_attr as SR code uses vdd_name
> to get voltagedomain sructure info.
>
> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>

Thanks for this.  It looks good.

> ---
> It apllies over Voltage Layer Cleanup Patch by
> Kevin Hilman: 
>  https://patchwork.kernel.org/patch/657421/ 

Can you rebase on top of my pm-wip/voltdm_a branch?  It currently
doesn't apply there because the some of the voltage domain names were
changed, e.g. mpu -> mpu_iva, wkup -> wakeup.

Thanks,

Kevin
