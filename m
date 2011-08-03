From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv2] OMAP4: I2C: Enable the wakeup in I2C_WE
Date: Wed, 03 Aug 2011 11:39:36 +0530
Message-ID: <4E38E620.9000200@ti.com>
References: <1311953092-12506-1-git-send-email-shubhrajyoti@ti.com> <877h6v8kwd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:40389 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751361Ab1HCGJo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Aug 2011 02:09:44 -0400
In-Reply-To: <877h6v8kwd.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, santosh.shilimkar@ti.com

On Wednesday 03 August 2011 04:46 AM, Kevin Hilman wrote:
> Shubhrajyoti D<shubhrajyoti@ti.com>  writes:
>
>> Currently for OMAP4 the I2C_WE is not programmed.
>> This patch enables the programming for OMAP4.
>>
>> This patch fixes a bad conflict resolution.
>> This effectively restores the following commit
>>
>> Commit 120bdaa47[i2c-omap: Program I2C_WE on OMAP4 to enable i2c wakeup]
>>
>> which got changed by
>>
>> Commit a3a7acbc[I2C: OMAP2+: address confused probed version naming]
>>
>> Reviewed-by: Felipe Balbi<balbi@ti.com>
>> Reported-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
>> ---
>> TODO:
>> Currently all the wakeup sources are enabled.
>> There is scope of optimising the same. Will revisit it.
>> Rebased on Kevin's wip/i2c branch
> Actually, this is based on top of your I2C reset series.
>
> Please rebase this onto my for_3.1/i2c-andy branch, and I'll queue it as
> a fix for v3.1.
yes will rebase and send.
> Thanks,
>
> Kevin

