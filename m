From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 2/7] UART: OMAP: Cut the clock in the error cases
Date: Wed, 18 Apr 2012 12:14:34 +0530
Message-ID: <4F8E62D2.9080206@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com> <1334588821-5224-3-git-send-email-shubhrajyoti@ti.com> <87bomprjic.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43557 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750769Ab2DRGol (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 02:44:41 -0400
Received: by obqv19 with SMTP id v19so8934815obq.41
        for <linux-omap@vger.kernel.org>; Tue, 17 Apr 2012 23:44:40 -0700 (PDT)
In-Reply-To: <87bomprjic.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>

Hi Kevin,
Thanks for the review.

On Wednesday 18 April 2012 05:36 AM, Kevin Hilman wrote:
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>
>> In the error cases the clock cut is missed. This patch intends to fix the
>> same.
> Please change the references to 'cut clocks' in subject/changelog here
> (and in other patches) to use runtime suspend instead.   First, runtime PM
> calls do more than cut clocks, but they only do so when
> usecounting/autosuspend timeouts permit.
Yes thanks will fix it.
>
>
>> Cc: stable@vger.kernel.org
> Please hold off on Cc'ing stable until your patches are reviewed and accepted.
OK
>> Cc: Govindraj.R <govindraj.raja@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/tty/serial/omap-serial.c |    6 +++++-
>>  1 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index fe099bb..10e80bb 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -319,6 +319,8 @@ static void serial_omap_start_tx(struct uart_port *port)
>>  
>>  		if (ret < 0) {
>>  			serial_omap_enable_ier_thri(up);
>> +			pm_runtime_mark_last_busy(&up->pdev->dev);
>> +			pm_runtime_put_autosuspend(&up->pdev->dev);
> Why the autosuspend version here?
>
> Kevin
>
>
In case the request_dma fails we enable the thri( effectively like intr
mode) so
I thought of using the autosuspend version here .

Do you prefer put version instead ?

With Regards,
Shubhro
