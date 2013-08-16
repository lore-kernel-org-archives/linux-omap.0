From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 2/8] usb: phy: omap: Add new device types and remove
 omap_control_usb3_phy_power()
Date: Fri, 16 Aug 2013 12:09:13 +0300
Message-ID: <520DEC39.1000804@ti.com>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
 <1376572512-9561-3-git-send-email-rogerq@ti.com>
 <520CDEA1.7060804@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <520CDEA1.7060804@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, tony@atomide.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, balbi@ti.com, kishon@ti.com, dmurphy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

On 08/15/2013 04:58 PM, Benoit Cousson wrote:
> Hi Roger,
> 
> On 15/08/2013 15:15, Roger Quadros wrote:
>> Add support for new device types and in the process rid of "ti,type"
>> device tree property. The correct type of device will be determined
>> from the compatible string instead.
>>
>> Introduce a compatible string for each device type. At the moment
>> we support 4 types Mailbox, USB2, USB3 and DRA7.
>>
>> Update DT binding information to reflect these changes.
>>
>> Also get rid of omap_control_usb3_phy_power(). Just one function
>> i.e. omap_control_usb_phy_power() will now take care of all PHY types.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   Documentation/devicetree/bindings/usb/omap-usb.txt |   29 ++--
>>   drivers/usb/phy/phy-omap-control.c                 |  148 ++++++++++++--------
>>   drivers/usb/phy/phy-omap-usb2.c                    |    4 +
>>   drivers/usb/phy/phy-omap-usb3.c                    |    6 +-
>>   include/linux/usb/omap_control_usb.h               |   24 ++--
>>   5 files changed, 122 insertions(+), 89 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
>> index 57e71f6..1c6b54a 100644
>> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
>> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
>> @@ -73,22 +73,23 @@ omap_dwc3 {
>>   OMAP CONTROL USB
>>
>>   Required properties:
>> - - compatible: Should be "ti,omap-control-usb"
>> + - compatible: Should be one of
>> + "ti,omap-control-usb" - if it has otghs_control mailbox register
>> +            e.g. on OMAP4.
> 
> How generic is that one? I mean if this is applicable for OMAP4 only, you'd better name it omap4-control-usb.
> 
AFAIK it is OMAP4 only so i'll change it to omap4-control-usb.

>> + "ti,usb2-control-usb" - if it has Power down bit in control_dev_conf register
>> +            e.g. USB2_PHY on OMAP5.
>> + "ti,usb3-control-usb" - if it has DPLL and individual Rx & Tx power control
>> +            e.g. USB3 PHY and SATA PHY on OMAP5.
>> + "ti,dra7-control-usb" - if it has both power down and power aux registers
>> +            e.g. USB2 PHY on DRA7 platform.
>> +
>>    - reg : Address and length of the register set for the device. It contains
>> -   the address of "control_dev_conf" and "otghs_control" or "phy_power_usb"
>> -   depending upon omap4 or omap5.
>> - - reg-names: The names of the register addresses corresponding to the registers
>> -   filled in "reg".
>> - - ti,type: This is used to differentiate whether the control module has
>> -   usb mailbox or usb3 phy power. omap4 has usb mailbox in control module to
>> -   notify events to the musb core and omap5 has usb3 phy power register to
>> -   power on usb3 phy. Should be "1" if it has mailbox and "2" if it has usb3
>> -   phy power.
>> +   the address of "otghs_control" for type 1 or "power" register for other types.
>> +   For type 4, it must also contain "power_aux" register.
>> + - reg-names: should be otghs_control for type 1 and "power" for other types.
> 
> type1 and 4 are less obvious now that you have name, you should be more explicit and name them directly.

OK, I'll fix it.
> 
>>
>>   omap_control_usb: omap-control-usb@4a002300 {
>>       compatible = "ti,omap-control-usb";
>> -    reg = <0x4a002300 0x4>,
>> -          <0x4a00233c 0x4>;
>> -    reg-names = "control_dev_conf", "otghs_control";
>> -    ti,type = <1>;
>> +    reg = <0x4a00233c 0x4>;
>> +    reg-names = "otghs_control";
>>   };
>> diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
>> index 3b9ee83..078c46f 100644
>> --- a/drivers/usb/phy/phy-omap-control.c
>> +++ b/drivers/usb/phy/phy-omap-control.c
>> @@ -46,61 +46,76 @@ struct device *omap_get_control_dev(void)
>>   EXPORT_SYMBOL_GPL(omap_get_control_dev);
>>
...

>>
>> -    control_usb->dev    = &pdev->dev;
>> +    control_usb->dev = &pdev->dev;
>> +    control_usb->type = OMAP_CTRL_TYPE_OMAP;
>>
>> -    res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> -        "control_dev_conf");
>> -    control_usb->dev_conf = devm_ioremap_resource(&pdev->dev, res);
>> -    if (IS_ERR(control_usb->dev_conf))
>> -        return PTR_ERR(control_usb->dev_conf);
>> +    if (of_device_is_compatible(np, "ti,usb2-control-usb"))
>> +        control_usb->type = OMAP_CTRL_TYPE_USB2;
>> +    else if (of_device_is_compatible(np, "ti,usb3-control-usb"))
>> +        control_usb->type = OMAP_CTRL_TYPE_USB3;
>> +    else if (of_device_is_compatible(np, "ti,dra7-control-usb"))
>> +        control_usb->type = OMAP_CTRL_TYPE_DRA7;
> 
> You can avoid that by adding the type directly in the data field of the omap_control_usb_id_table.
> It will be more readable and scalable.
> 
> This how it was done on gpio-omap for example.

OK. Thanks for the hint.
> 
>>
>> -    if (control_usb->type == OMAP_CTRL_DEV_TYPE1) {
>> +    if (control_usb->type == OMAP_CTRL_TYPE_OMAP) {
>>           res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>>               "otghs_control");
>>           control_usb->otghs_control = devm_ioremap_resource(
>>               &pdev->dev, res);
>>           if (IS_ERR(control_usb->otghs_control))
>>               return PTR_ERR(control_usb->otghs_control);
>> -    }
>> -
>> -    if (control_usb->type == OMAP_CTRL_DEV_TYPE2) {
>> +    } else {
>>           res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> -            "phy_power_usb");
>> -        control_usb->phy_power = devm_ioremap_resource(
>> -            &pdev->dev, res);
>> -        if (IS_ERR(control_usb->phy_power))
>> -            return PTR_ERR(control_usb->phy_power);
>> +                "power");
>> +        control_usb->power = devm_ioremap_resource(&pdev->dev, res);
>> +        if (IS_ERR(control_usb->power)) {
>> +            dev_err(&pdev->dev, "Couldn't get power register\n");
>> +            return PTR_ERR(control_usb->power);
>> +        }
>> +    }
>>
>> +    if (control_usb->type == OMAP_CTRL_TYPE_USB3) {
>>           control_usb->sys_clk = devm_clk_get(control_usb->dev,
>>               "sys_clkin");
>>           if (IS_ERR(control_usb->sys_clk)) {
>> @@ -245,6 +261,15 @@ static int omap_control_usb_probe(struct platform_device *pdev)
>>           }
>>       }
>>
>> +    if (control_usb->type == OMAP_CTRL_TYPE_DRA7) {
>> +        res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +                "power_aux");
>> +        control_usb->power_aux = devm_ioremap_resource(&pdev->dev, res);
>> +        if (IS_ERR(control_usb->power_aux)) {
>> +            dev_err(&pdev->dev, "Couldn't get power_aux register\n");
>> +            return PTR_ERR(control_usb->power_aux);
>> +        }
>> +    }
>>
>>       dev_set_drvdata(control_usb->dev, control_usb);
>>
>> @@ -254,6 +279,9 @@ static int omap_control_usb_probe(struct platform_device *pdev)
>>   #ifdef CONFIG_OF
>>   static const struct of_device_id omap_control_usb_id_table[] = {
>>       { .compatible = "ti,omap-control-usb" },
>> +    { .compatible = "ti,usb2-control-usb" },
>> +    { .compatible = "ti,usb3-control-usb" },
>> +    { .compatible = "ti,dra7-control-usb" },
>>       {}
> 
> In that table you can add a data field with the proper type enum.

got it.

cheers,
-roger
