From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V2 0/3]: OMAP4: Update OPP Table and Voltage Rail Values
Date: Mon, 07 Mar 2011 14:30:12 -0800
Message-ID: <87vczuzhqj.fsf@ti.com>
References: <1299318621-21280-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:56572 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754281Ab1CGWaQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 17:30:16 -0500
Received: by mail-qw0-f47.google.com with SMTP id 2so4018108qwi.20
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 14:30:15 -0800 (PST)
In-Reply-To: <1299318621-21280-1-git-send-email-shweta.gulati@ti.com> (Shweta
	Gulati's message of "Sat, 5 Mar 2011 15:20:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Shweta Gulati <shweta.gulati@ti.com> writes:

> The Series Updates OPP Table for MPU, add OPP enteries
> for IVA and update Voltage Rail values for MPU/IVA.
>
> It is based on the Patch which replaces
> Voltage values with Macros, Submitted by 
> Nishanth Menon 
> https://patchwork.kernel.org/patch/607541/
>
> Branch: pm-core
>
> Tested on OMAP4430 SDP.
>
> V2:
> Rebased on pm-core and incorporated
> comments from Nishanth Menon. 

This version looks OK to me.

Will queue for 2.6.39 after I see an Ack from Nishanth.

Thanks,

Kevin

> Shweta Gulati (3):
>   OMAP4: Enable 800 MHz and 1 GHz OPP for OMAP4.
>   OMAP4: Update Voltage Rail Values for MPU/IVA
>   OMAP4: Add IVA OPP enteries.
>
>  arch/arm/mach-omap2/opp4xxx_data.c |   26 ++++++++++++++++----------
>  1 files changed, 16 insertions(+), 10 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
