From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] usb: dwc3: Addition of "dr_mode" dt property.
Date: Thu, 30 May 2013 15:35:08 -0500
Message-ID: <51A7B7FC.7090807@ti.com>
References: <1369944894-3176-1-git-send-email-ruchika@ti.com> <51A7B725.1090103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <51A7B725.1090103@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ruchika Kharwar <ruchika@ti.com>
Cc: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>
List-Id: linux-omap@vger.kernel.org

Fix spelling in my own comments

On 05/30/2013 03:31 PM, Dan Murphy wrote:
> On 05/30/2013 03:14 PM, Ruchika Kharwar wrote:
>> This patch adds an optional parameter "dr_mode" to the dwc3 core device node.
>> In the case the compile flag for the DWC3 controller is set to
>> "USB_DWC3_DUAL_ROLE" a device tree could restrain to either functionality of
>> host or gadget. In the case the device tree does not use this optional flag or
>> specifies it superfluously to "drd" the functionality will be that
>> of a dual role device.
>>
>> Signed-off-by: Ruchika Kharwar <ruchika@ti.com>
>> ---
> Can you add patch history if this is truly a new patch to a previous submission
>>  Documentation/devicetree/bindings/usb/dwc3.txt |    3 ++-
>>  drivers/usb/dwc3/core.c                        |   21 +++++++++++++++++----
>>  2 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
>> index 7a95c65..2f5d584 100644
>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>> @@ -10,7 +10,8 @@ Required properties:
>>  
>>  Optional properties:
>>   - tx-fifo-resize: determines if the FIFO *has* to be reallocated.
>> -
>> + - dr_mode: determines the mode of core. Supported modes are "gadget", "host"
>> +   and "drd".
> My previous comments still stand for this section.  Nothing was addressed or commented back
>
> https://patchwork.kernel.org/patch/2638511/
>>  This is usually a subnode to DWC3 glue to which it is connected.
>>  
>>  dwc3@4a030000 {
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index c35d49d..e11660a 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -378,7 +378,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>  	void			*mem;
>>  
>>  	u8			mode;
>> -
>> +	char			*dr_mode;
>>  	mem = devm_kzalloc(dev, sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
>>  	if (!mem) {
>>  		dev_err(dev, "not enough memory\n");
>> @@ -520,9 +520,22 @@ static int dwc3_probe(struct platform_device *pdev)
>>  		mode = DWC3_MODE_HOST;
>>  	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
>>  		mode = DWC3_MODE_DEVICE;
>> -	else
>> -		mode = DWC3_MODE_DRD;
>> -
>> +	else {
>> +		if (of_property_read_string(node, "dr_mode", &dr_mode))
>> +			mode = DWC3_MODE_DRD;
>> +		else {
>> +			if (strcmp(dr_mode, "host") == 0)
>> +				mode = DWC3_MODE_HOST;
>> +			else if (strcmp(dr_mode, "gadget") == 0)
>> +				mode = DWC3_MODE_DEVICE;
>> +			else if (strcmp(dr_mode, "drd") == 0)
>> +				mode = DWC3_MODE_DRD;
> My previous comments still stand for this section.  Nothing was addressed or commented back
>
> https://patchwork.kernel.org/patch/2638511/
>> +			else {
>> +				dev_err(dev, "invalid dr_mode property value\n");
>> +				goto err2;
> This is still wrong.  You have not initialized and of the device's
s/and/any
>> +			}
>> +		}
>> +	}
>>  	switch (mode) {
>>  	case DWC3_MODE_DEVICE:
>>  		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> Is this a new patch?
> Subject should say v2.
>


-- 
------------------
Dan Murphy

