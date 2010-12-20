From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 5/7] OMAP3630: PM: Disable L2 cache while invalidating
 L2 cache
Date: Mon, 20 Dec 2010 05:44:59 -0600
Message-ID: <4D0F41BB.2070606@ti.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-6-git-send-email-nm@ti.com> <9b48aafcc94e9b69236ed4d934ebd91e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53288 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755489Ab0LTLph (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 06:45:37 -0500
Received: by yxm8 with SMTP id 8so1511136yxm.35
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 03:45:36 -0800 (PST)
In-Reply-To: <9b48aafcc94e9b69236ed4d934ebd91e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

Santosh Shilimkar wrote, on 12/20/2010 01:13 AM:
[..]
>> This is be done according to ARM documentation. Currently this is
>> identified
>> as being needed on OMAP3630 as the disable/enable is done from "public
>> side"
>> while, on OMAP3430, this is done in the "secure side".
> Can you point me to ARM doc which says " for L2 invalidation, the
> controller
> needs to be disabled" ?
please see section 8.3 of the Cortex-A8 TRM


-- 
Regards,
Nishanth Menon
