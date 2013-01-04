From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v5 13/22] mfd: omap-usb-host: override number of ports
 from platform data
Date: Fri, 4 Jan 2013 16:06:53 +0200
Message-ID: <50E6E1FD.40604@ti.com>
References: <1357138842-28964-1-git-send-email-rogerq@ti.com>
 <1357138842-28964-14-git-send-email-rogerq@ti.com>
 <50E57F10.6030402@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50E57F10.6030402@mvista.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: sameo@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, keshava_mgowda@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bjorn@mork.no
List-Id: linux-omap@vger.kernel.org

On 01/03/2013 02:52 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 02-01-2013 19:00, Roger Quadros wrote:
> 
>> Both OMAP4 and 5 exhibit the same revision ID in the REVISION register
>> but they have different number of ports i.e. 2 and 3 respectively.
>> So we can't rely on REVISION register for number of ports on OMAP5
>> and depend on platform data (or device tree) instead.
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> [...]
> 
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index 5edb828..710460d 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -497,19 +497,27 @@ static int usbhs_omap_probe(struct
>> platform_device *pdev)
>>        */
>>       pm_runtime_put_sync(dev);
>>
>> -    switch (omap->usbhs_rev) {
>> -    case OMAP_USBHS_REV1:
>> -        omap->nports = 3;
>> -        break;
>> -    case OMAP_USBHS_REV2:
>> -        omap->nports = 2;
>> -        break;
>> -    default:
>> -        omap->nports = OMAP3_HS_USB_PORTS;
>> -        dev_dbg(dev,
>> -          "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
>> -           omap->usbhs_rev, omap->nports);
>> -        break;
>> +    /*
>> +     * If platform data contains nports then use that
>> +     * else make out number of ports from USBHS revision
>> +     */
>> +    if (pdata->nports) {
>> +        omap->nports = pdata->nports;
>> +    } else {
>> +        switch (omap->usbhs_rev) {
>> +        case OMAP_USBHS_REV1:
>> +            omap->nports = 3;
>> +            break;
>> +        case OMAP_USBHS_REV2:
>> +            omap->nports = 2;
>> +            break;
>> +        default:
>> +            omap->nports = OMAP3_HS_USB_PORTS;
>> +            dev_dbg(dev,
>> +            "USB HOST Rev:0x%d not recognized, assuming %d ports\n",
> 
>    Please indent the string to the right somewhat, as it was before.
> 

OK. I will fix it in the pull request e-mail that i'll send in a while
as a reply to the first message in this patchset.

--
cheers,
-roger
