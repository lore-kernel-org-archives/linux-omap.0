From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 6/8] usb: phy: omap: get rid of omap_get_control_dev()
Date: Fri, 16 Aug 2013 12:00:27 +0300
Message-ID: <520DEA2B.5030608@ti.com>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
 <1376572512-9561-7-git-send-email-rogerq@ti.com>
 <20130815165152.GB10982@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130815165152.GB10982@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, tony@atomide.com, linux-usb@vger.kernel.org, balbi@ti.com, kishon@ti.com, dmurphy@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/15/2013 07:51 PM, Sebastian Andrzej Siewior wrote:
> * Roger Quadros | 2013-08-15 16:15:10 [+0300]:
> 
>> diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
>> index 078c46f..d144c14 100644
>> --- a/drivers/usb/phy/phy-omap-control.c
>> +++ b/drivers/usb/phy/phy-omap-control.c
>> @@ -187,11 +167,19 @@ void omap_control_usb_set_mode(struct device *dev,
>> {
>> 	struct omap_control_usb	*ctrl_usb;
>>
>> -	if (IS_ERR(dev) || control_usb->type != OMAP_CTRL_TYPE_OMAP)
>> +	if (IS_ERR(dev) || !dev)
>> 		return;
>>
>> 	ctrl_usb = dev_get_drvdata(dev);
>>
>> +	if (!ctrl_usb) {
>> +		dev_err(dev, "Invalid control usb device\n");
>> +		return;
>> +	}
>> +
>> +	if (ctrl_usb->type != OMAP_CTRL_TYPE_OMAP)
>> +		return;
>> +
> 
> I don't like that part where you can call this function even before the
> driver probed the device. This shouldn't happen since you have hard module
> dependency and the proper compatible string in your device. But this
> kind of thing won't happen in the am335x reset driver.

I don't like that part either, but omap_control_usb_set_mode is being called
from outside this driver (e.g. musb) and we are not making any changes to that behaviour
in this patch.

I think the issue you mentioned is being fixed by Kishon's extcon migration series.

cheers,
-roger
