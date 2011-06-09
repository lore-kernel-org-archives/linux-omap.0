From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3 04/12] Serial: OMAP: Add runtime pm support for omap-serial
 driver
Date: Thu, 9 Jun 2011 15:49:03 -0500
Message-ID: <4DF131BF.3050908@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com> <1307532194-13039-5-git-send-email-govindraj.raja@ti.com> <4DEFDDE8.3090808@ti.com> <BANLkTik1fRzQEnGyzTLour-_kYxR+y2kGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52815 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877Ab1FIUtN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jun 2011 16:49:13 -0400
In-Reply-To: <BANLkTik1fRzQEnGyzTLour-_kYxR+y2kGg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

Hi Govindraj

On 06/08/2011 11:35 PM, Govindraj wrote:
> On Thu, Jun 9, 2011 at 2:09 AM, Jon Hunter<jon-hunter@ti.com>  wrote:
>> Hi Govindraj,
>>
>> On 6/8/2011 6:23 AM, Govindraj.R wrote:
>>
>> [snip]
>>
>>> +
>>> +#define OMAP_UART_AUTOSUSPEND_DELAY (30 * HZ) /* Value is msecs */
>>
>> [snip]
>>
>>> @@ -1295,18 +1381,36 @@ static int serial_omap_probe(struct
>>> platform_device *pdev)
>>>                 up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
>>>         }
>>>
>>> +       pm_runtime_use_autosuspend(&pdev->dev);
>>> +       pm_runtime_set_autosuspend_delay(&pdev->dev,
>>> +                       OMAP_UART_AUTOSUSPEND_DELAY);
>>
>> Something is weird here...DEFAULT_AUTOSUSPEND_DELAY is defined as (30*HZ)
>> which would appear to be jiffies (ticks per second) and NOT msecs. However,
>> pm_runtime_set_autosuspend is clearly expecting msecs. So this seems to
>> conflict. By default 30*HZ for omap would be 30*128 = 3840ms so not quite 4
>> seconds.
>>
>> What were you intending here?
>
> Intention is to get approx 3 secs timeout for autosuspend.

In that case you should just define DEFAULT_AUTOSUSPEND_DELAY as 30000. 
The above is just confusing as you are mixing time types and hence, it 
is not clear what you intend the default timeout to be.

Jon
