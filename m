From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Remove dmm device creation
Date: Wed, 20 Mar 2013 11:46:33 +0530
Message-ID: <51495441.1000606@ti.com>
References: <1363754624-5209-1-git-send-email-andy.gross@ti.com> <1363754624-5209-3-git-send-email-andy.gross@ti.com> <51494F89.4050308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52015 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab3CTGRX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 02:17:23 -0400
In-Reply-To: <51494F89.4050308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Andy Gross <andy.gross@ti.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Nishanth Menon <nm@ti.com>

On Wednesday 20 March 2013 11:26 AM, Santosh Shilimkar wrote:
> On Wednesday 20 March 2013 10:13 AM, Andy Gross wrote:
>> Remove DMM device creation via the hwmod entry.  The DMM device will
>> now be enumerated as part of the device tree information for the
>> processor.
>>
>> Signed-off-by: Andy Gross <andy.gross@ti.com>
>> ---
> OMAP4 is still not made DT only so I suggest you to hold on for this patch
> till that happens.

Wouldn't we need to at least prevent building the platform device using 
omap_device_build() when we are using DT?

Archit

>
> Regards,
> Santosh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

