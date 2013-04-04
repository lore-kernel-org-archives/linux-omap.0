From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 12/18] ARM: OMAP4: CPUidle: Avoid double idle driver
 registration
Date: Thu, 4 Apr 2013 19:17:30 +0530
Message-ID: <515D8472.4030204@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <1364205910-32392-13-git-send-email-santosh.shilimkar@ti.com> <877gkjtjht.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36061 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760186Ab3DDNpc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 09:45:32 -0400
In-Reply-To: <877gkjtjht.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Thursday 04 April 2013 02:33 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> OMAP4 CPUidle driver registration call is under a loop which leads
>> to calling cpuidle_register_driver twice which is not intended.
>>
>> Fix it by moving the driver registration outside the loop.
>>
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Looks good.
> 
> I've already got a for_3.10/fixes/cpuidle branch going, so I'll apply
> this one there.
> 
ok.

Regards,
Santosh

