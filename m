From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 4/7] usb: musb: omap2430: Don't use omap_get_control_dev()
Date: Tue, 6 Aug 2013 16:27:29 +0300
Message-ID: <5200F9C1.8090307@ti.com>
References: <1375365915-21380-1-git-send-email-rogerq@ti.com> <1375365915-21380-5-git-send-email-rogerq@ti.com> <5200E358.9010505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5200E358.9010505@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, tony@atomide.com, george.cherian@ti.com, dmurphy@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/06/2013 02:51 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Thursday 01 August 2013 07:35 PM, Roger Quadros wrote:
>> omap_get_control_dev() is being deprecated as it doesn't support
>> multiple instances. As control device is present only from OMAP4
>> onwards which supports DT only, we use phandles to get the
>> reference to the control device.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/usb/musb/omap2430.c |   22 ++++++++++++++++++----
>>   1 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>> index ebb46ec..1db9588 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -38,6 +38,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/usb/musb-omap.h>
>>   #include <linux/usb/omap_control_usb.h>
>> +#include <linux/of_platform.h>
>>
>>   #include "musb_core.h"
>>   #include "omap2430.h"
>> @@ -547,12 +548,25 @@ static int omap2430_probe(struct platform_device *pdev)
>>       }
>>
>>       if (pdata->has_mailbox) {
> 
> I think you can remove this this check all together. Mailbox is present only from OMAP4 so it can be dt only.
> 
OK.

cheers,
-roger
