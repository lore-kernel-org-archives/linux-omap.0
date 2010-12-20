From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 5/7] OMAP3630: PM: Disable L2 cache while invalidating
 L2 cache
Date: Mon, 20 Dec 2010 07:33:09 -0600
Message-ID: <4D0F5B15.1020309@ti.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-6-git-send-email-nm@ti.com> <9b48aafcc94e9b69236ed4d934ebd91e@mail.gmail.com> <4D0F41BB.2070606@ti.com> <eb91f91221d31f1c74366590a4fb0900@mail.gmail.com> <4D0F553E.1060301@ti.com> <e6ba48e58d90204a23a5e948700a5166@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:33675 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751803Ab0LTNdO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 08:33:14 -0500
Received: by ywl5 with SMTP id 5so1555451ywl.4
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 05:33:13 -0800 (PST)
In-Reply-To: <e6ba48e58d90204a23a5e948700a5166@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

Santosh Shilimkar had written, on 12/20/2010 07:29 AM, the following:
[..]
> So may be you could update the change log something like below.
> 
> While coming out of MPU OSWR/OFF states, L2 controller is reseted.
> The reset behavior is implementation specific as per ARMv7 TRM and
> hence $L2 needs to be invalidated before it's use. Since the
> AUXCTRL register is also reconfigured, disable L2 cache before
> invalidating it and re-enables it afterwards. This is as per
> Cortex-A8 ARM documentation.
> Currently this is identified as being needed on OMAP3630 as the
> disable/enable is done from "public side" while, on OMAP3430, this
> is done in the "secure side".
Thanks, will update the rev5 patch with this commit log.

-- 
Regards,
Nishanth Menon
