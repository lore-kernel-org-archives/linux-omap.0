From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from
 the driver
Date: Wed, 20 Feb 2013 21:14:25 +0530
Message-ID: <5124EF59.5080206@ti.com>
References: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com> <87sj4rqa7r.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54530 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935543Ab3BTPnO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:43:14 -0500
In-Reply-To: <87sj4rqa7r.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

On Wednesday 20 February 2013 08:54 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
>> so remove the hackery from the driver.
>>
>> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
>> Signed-off-by: Rajendra nayak <rnayak@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> ---
>>   drivers/tty/serial/omap-serial.c |   23 -----------------------
>>   1 file changed, 23 deletions(-)
>
> This patch should also remove the hooks from
> <linux/platform_data/serial-omap.h>
>
Right. Will fix that in next version. Thanks.

Regards,
Santosh

