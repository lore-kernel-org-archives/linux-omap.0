From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Thu, 30 Jun 2011 15:50:19 -0700
Message-ID: <874o37djdg.fsf@ti.com>
References: <1309327221-4121-1-git-send-email-shubhrajyoti@ti.com>
	<871uycql0y.fsf@ti.com> <4E0C24A5.5020905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34348 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752270Ab1F3WuX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 18:50:23 -0400
In-Reply-To: <4E0C24A5.5020905@ti.com> (shubhrajyoti@ti.com's message of "Thu,
	30 Jun 2011 12:54:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org

Shubhrajyoti <shubhrajyoti@ti.com> writes:

> On Thursday 30 June 2011 04:53 AM, Kevin Hilman wrote:
>> Shubhrajyoti D<shubhrajyoti@ti.com>  writes:
>>
>>> Currently the fifo depth is set to zero for OMAP4 which disables
>>> the FIFO usage. This patch enables the FIFO usage for I2C transactions
>>> on OMAP4 also.
>> Do you know the history of why the FIFO depth was set to zero?  A
>> summary of that history would greatly help reviewers.
>>
>>> Reported-By:Nishanth Menon<nm@ti.com>
>> minor: missing space after ':'
>>
>>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
>> Tested on what platforms?   OMAP3 also?
> OMAP4 and OMAP3

Please add a brief summary of what platforms it was tested on in the
changelog.

>> Could you please rebase this onto my for_3.1/i2c-andy branch[1] where we
>> have a large series of I2C patches queued up for the v3.1 merge window
>> already?
> OK will rebase and resend.

Thanks,

Kevin
