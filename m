From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/2] extcon: of: Remove unnecessary function call by using
 the name of device_node
Date: Thu, 20 Mar 2014 11:22:05 +0900
Message-ID: <532A50CD.7030601@samsung.com>
References: <1395144280-23240-1-git-send-email-cw00.choi@samsung.com>
 <1395144280-23240-2-git-send-email-cw00.choi@samsung.com>
 <532988DA.8030002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18439 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbaCTCWI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 22:22:08 -0400
In-reply-to: <532988DA.8030002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

On 03/19/2014 09:08 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 18 March 2014 05:34 PM, Chanwoo Choi wrote:
>> This patch remove unnecessary function call in of_extcon_get_extcon_dev()
>> by using the name of device_node structure.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/extcon/of_extcon.c | 12 ++----------
>>  1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/extcon/of_extcon.c b/drivers/extcon/of_extcon.c
>> index 72173ec..0a29f82 100644
>> --- a/drivers/extcon/of_extcon.c
>> +++ b/drivers/extcon/of_extcon.c
>> @@ -32,7 +32,6 @@ struct extcon_dev *of_extcon_get_extcon_dev(struct device *dev, int index)
>>  {
>>  	struct device_node *node;
>>  	struct extcon_dev *edev;
>> -	struct platform_device *extcon_parent_dev;
>>  
>>  	if (!dev->of_node) {
>>  		dev_dbg(dev, "device does not have a device node entry\n");
>> @@ -46,16 +45,9 @@ struct extcon_dev *of_extcon_get_extcon_dev(struct device *dev, int index)
>>  		return ERR_PTR(-ENODEV);
>>  	}
>>  
>> -	extcon_parent_dev = of_find_device_by_node(node);
>> -	if (!extcon_parent_dev) {
>> -		dev_dbg(dev, "unable to find device by node\n");
>> -		return ERR_PTR(-EPROBE_DEFER);
>> -	}
>> -
>> -	edev = extcon_get_extcon_dev(dev_name(&extcon_parent_dev->dev));
>> +	edev = extcon_get_extcon_dev(node->name);
> 
> Since you no longer want to use device names I think you should add this too to
> warn users if they rely on using the device name.

Previous of_extcon_get_extcon_dev() support only platform device using of_find_device_by_node.

If extcon device is based on i2c/spi/pci and so on, of_extcon_get_extcon_dev() can't
find device instance for device name. So, I change device name from the name of platform device
to the name of dt node.


> diff --git a/drivers/extcon/extcon-class.c b/drivers/extcon/extcon-class.c
> index bc4c789..025eb39 100644
> --- a/drivers/extcon/extcon-class.c
> +++ b/drivers/extcon/extcon-class.c
> @@ -601,7 +601,6 @@ int extcon_dev_register(struct extcon_dev *edev)
>         edev->dev.class = extcon_class;
>         edev->dev.release = extcon_dev_release;
> 
> -       edev->name = edev->name ? edev->name : dev_name(edev->dev.parent);
> //The user should always pass the 'name' as we no longer use device name while
> getting extcon device. And this name should also be the 'node' name?
>         if (IS_ERR_OR_NULL(edev->name)) {
>                 dev_err(&edev->dev,
>                         "extcon device name is null\n");
> 
> Btw changing to node name from device name breaks dwc3 in OMAP5 and you would
> need this too..
> 
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
> index 2aea4bc..cea8cd3 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -188,6 +188,7 @@ static int palmas_usb_probe(struct platform_device *pdev)
> 
>         palmas_usb->edev.supported_cable = palmas_extcon_cable;
>         palmas_usb->edev.dev.parent = palmas_usb->dev;
> +       palmas_usb->edev.name = "palmas_usb";
>         palmas_usb->edev.mutually_exclusive = mutually_exclusive;
> 
>         status = extcon_dev_register(&palmas_usb->edev);
> 
> Cheers
> Kishon
> 

If node name is same as extcon device name, don't need some modification.
Also, you can modify node name in some OMAP dts file insead of modification of extcon-palmas.c

Thanks,
Chanwoo Choi


