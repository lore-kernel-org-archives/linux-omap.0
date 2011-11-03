From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Thu, 03 Nov 2011 20:49:58 +0530
Message-ID: <4EB2B11E.6010603@ti.com>
References: <1309849870-25660-1-git-send-email-shubhrajyoti@ti.com>	<8739ikp9aa.fsf@ti.com> <20110713192055.GC3369@freya.fluff.org>	<4EB278C4.6030006@ti.com> <87ipn1i8xd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:59450 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755670Ab1KCPUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 11:20:07 -0400
In-Reply-To: <87ipn1i8xd.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Ben Dooks <ben-i2c@fluff.org>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org

On Thursday 03 November 2011 07:51 PM, Kevin Hilman wrote:
> Shubhrajyoti <shubhrajyoti@ti.com> writes:
>
>> On Thursday 14 July 2011 12:50 AM, Ben Dooks wrote:
>>> On Tue, Jul 05, 2011 at 05:01:01PM -0700, Kevin Hilman wrote:
>>>> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>>>>
>>>>> Currently the fifo depth is set to zero for OMAP4 which disables
>>>>> the FIFO usage. This patch enables the FIFO usage for I2C transactions
>>>>> on OMAP4 also.
>>>>>
>>>>> Tested on omap4430 and 3430.
>>>>>
>>>>> Reported-By: Nishanth Menon <nm@ti.com>
>>>>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>>>>> ---
>>>>> Rebased on top of the series by Andy Green
>>>>> http://www.spinics.net/lists/linux-i2c/msg05632.html
>>>> Thanks.
>>>>
>>>> This is v3.1 material, but would be nice to see a couple tested-by or
>>>> acked-by tags from folks that are more actively using the I2C driver
>>>> before merging
>>>>
>>>> Kevin
>>> guess you'll be picking these up?
>> Ben Could this patch be lined up as well?
> Please update this patch against my for_3.2/i2c-cleanup branch, and add
> the Tested-by from Nishanth Menon.
>
> Then I will push to get this in as a fix for v3.2-rc.
Thanks the patch was already rebased to the 

for_3.2/i2c-cleanup branch and applies on your tree . Resent it adding Nishanth's Tested-by

Thanks.

> Kevin

