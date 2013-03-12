From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 01/13] usb: phy: nop: Add device tree support and binding
 information
Date: Tue, 12 Mar 2013 11:09:24 +0200
Message-ID: <513EF0C4.9080402@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-2-git-send-email-rogerq@ti.com>
 <20130205072637.GA32118@arwen.pp.htv.fi> <513DFDD7.7000801@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <513DFDD7.7000801-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/11/2013 05:52 PM, Marc Kleine-Budde wrote:
> On 02/05/2013 08:26 AM, Felipe Balbi wrote:
>> Hi,
>>
>> On Mon, Feb 04, 2013 at 05:58:48PM +0200, Roger Quadros wrote:
>>> The PHY clock, clock rate, VCC regulator and RESET regulator
>>> can now be provided via device tree.
>>>
>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>> ---
>>>  .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 ++++++++++++++++++++
>>>  drivers/usb/otg/nop-usb-xceiv.c                    |   31 ++++++++++++++++++
>>>  2 files changed, 65 insertions(+), 0 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>>> new file mode 100644
>>> index 0000000..d7e2726
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>>> @@ -0,0 +1,34 @@
>>> +USB NOP PHY
>>> +
>>> +Required properties:
>>> +- compatible: should be usb-nop-xceiv
>>> +
>>> +Optional properties:
>>> +- clocks: phandle to the PHY clock. Use as per Documentation/devicetree
>>> +  /bindings/clock/clock-bindings.txt
>>> +  This property is required if clock-frequency is specified.
>>> +
>>> +- clock-names: Should be "main_clk"
>>> +
>>> +- clock-frequency: the clock frequency (in Hz) that the PHY clock must
>>> +  be configured to.
>>> +
>>> +- vcc-supply: phandle to the regulator that provides RESET to the PHY.
>>> +
>>> +- reset-supply: phandle to the regulator that provides power to the PHY.
>>> +
>>> +Example:
>>> +
>>> +	hsusb1_phy {
>>> +		compatible = "usb-nop-xceiv";
>>> +		clock-frequency = <19200000>;
>>> +		clocks = <&osc 0>;
>>> +		clock-names = "main_clk";
>>> +		vcc-supply = <&hsusb1_vcc_regulator>;
>>> +		reset-supply = <&hsusb1_reset_regulator>;
>>> +	};
>>> +
>>> +hsusb1_phy is a NOP USB PHY device that gets its clock from an oscillator
>>> +and expects that clock to be configured to 19.2MHz by the NOP PHY driver.
>>> +hsusb1_vcc_regulator provides power to the PHY and hsusb1_reset_regulator
>>> +controls RESET.
>>> diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
>>> index ac027a1..adbb7ab 100644
>>> --- a/drivers/usb/otg/nop-usb-xceiv.c
>>> +++ b/drivers/usb/otg/nop-usb-xceiv.c
>>> @@ -34,6 +34,7 @@
>>>  #include <linux/slab.h>
>>>  #include <linux/clk.h>
>>>  #include <linux/regulator/consumer.h>
>>> +#include <linux/of.h>
>>>  
>>>  struct nop_usb_xceiv {
>>>  	struct usb_phy		phy;
>>> @@ -138,8 +139,19 @@ static int nop_set_host(struct usb_otg *otg, struct usb_bus *host)
>>>  	return 0;
>>>  }
>>>  
>>> +static void nop_xeiv_get_dt_pdata(struct device *dev,
>>
>> asking to remove, but xeiv != xceiv :-)
>>
>>> +				struct nop_usb_xceiv_platform_data *pdata)
>>> +{
>>> +	struct device_node *node = dev->of_node;
>>> +	u32 clk_rate;
>>> +
>>> +	if (!of_property_read_u32(node, "clock-frequency", &clk_rate))
>>> +		pdata->clk_rate = clk_rate;
>>> +}
>>> +
>>>  static int nop_usb_xceiv_probe(struct platform_device *pdev)
>>>  {
>>> +	struct device *dev = &pdev->dev;
>>>  	struct nop_usb_xceiv_platform_data *pdata = pdev->dev.platform_data;
>>>  	struct nop_usb_xceiv	*nop;
>>>  	enum usb_phy_type	type = USB_PHY_TYPE_USB2;
>>> @@ -153,6 +165,17 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
>>>  	if (!nop->phy.otg)
>>>  		return -ENOMEM;
>>>  
>>> +	if (dev->of_node) {
>>> +		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>>> +		if (!pdata) {
>>> +			dev_err(dev, "Memory allocation failure\n");
>>> +			return -ENOMEM;
>>> +		}
>>> +		nop_xeiv_get_dt_pdata(dev, pdata);
>>
>> actually, I would prefer to not create pdata at all. I mean, ideally
>> pdata would be used to initialize fields in your own structure, so first
>> move clk_rate to your own private structure, copy pdata's clk_rate value
>> to that, then you don't need this hackery when using DT.
> 
> As far as I can see, clk_rate is never used, but in the probe function.
> Why should it be saved into the private data structure at all?
> 
Yes you are right. I'll fix it up.
Thanks.

cheers,
-roger
