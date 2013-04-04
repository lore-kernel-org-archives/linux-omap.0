From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 13/18] ARM: OMAP: CPUidle: Unregister drivere on device
 registration failure
Date: Thu, 4 Apr 2013 19:18:04 +0530
Message-ID: <515D8494.20305@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <1364205910-32392-14-git-send-email-santosh.shilimkar@ti.com> <871uartjgg.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47515 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760568Ab3DDNqD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 09:46:03 -0400
In-Reply-To: <871uartjgg.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Thursday 04 April 2013 02:33 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> If the CPUidle device registration fails for some reason, we should
>> unregister the driver on error path.
>>
>> Fix the code accordingly. Also when at it, check of the driver registration
>> failure too.
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Adding to my for_3.10/fixes/cpuidle branch.
> 
Thanks.

regards,
Santosh

