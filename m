From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Thu, 30 Jun 2011 12:54:21 +0530
Message-ID: <4E0C24A5.5020905@ti.com>
References: <1309327221-4121-1-git-send-email-shubhrajyoti@ti.com> <871uycql0y.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37434 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754038Ab1F3Hbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 03:31:39 -0400
In-Reply-To: <871uycql0y.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org

On Thursday 30 June 2011 04:53 AM, Kevin Hilman wrote:
> Shubhrajyoti D<shubhrajyoti@ti.com>  writes:
>
>> Currently the fifo depth is set to zero for OMAP4 which disables
>> the FIFO usage. This patch enables the FIFO usage for I2C transactions
>> on OMAP4 also.
> Do you know the history of why the FIFO depth was set to zero?  A
> summary of that history would greatly help reviewers.
>
>> Reported-By:Nishanth Menon<nm@ti.com>
> minor: missing space after ':'
>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> Tested on what platforms?   OMAP3 also?
OMAP4 and OMAP3
> Could you please rebase this onto my for_3.1/i2c-andy branch[1] where we
> have a large series of I2C patches queued up for the v3.1 merge window
> already?
OK will rebase and resend.
> Thanks,
>
> Kevin
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
>

