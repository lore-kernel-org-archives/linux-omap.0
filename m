From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 2/7] usb: dwc3: adapt dwc3 core to use Generic PHY
 Framework
Date: Wed, 16 Oct 2013 17:23:45 +0300
Message-ID: <525EA171.9010402@ti.com>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
 <1381866857-3861-3-git-send-email-kishon@ti.com> <525E9232.9050502@ti.com>
 <525E9A11.7080501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <525E9A11.7080501@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux@arm.linux.org.uk, bcousson@baylibre.com, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, gregkh@linuxfoundation.org, ijc+devicetree@hellion.org.uk, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, balbi@ti.com, rob@landley.net, galak@codeaurora.org, grant.likely@linaro.org, s.nawrocki@samsung.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/16/2013 04:52 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Wednesday 16 October 2013 06:48 PM, Roger Quadros wrote:
>> Hi,
>>
>> On 10/15/2013 10:54 PM, Kishon Vijay Abraham I wrote:
>>> Adapted dwc3 core to use the Generic PHY Framework. So for init, exit,
>>> power_on and power_off the following APIs are used phy_init(), phy_exit(),
>>> phy_power_on() and phy_power_off().
>>>
>>> However using the old USB phy library wont be removed till the PHYs of all
>>> other SoC's using dwc3 core is adapted to the Generic PHY Framework.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/usb/dwc3.txt |    6 ++-
>>>  drivers/usb/dwc3/Kconfig                       |    1 +
>>>  drivers/usb/dwc3/core.c                        |   52 ++++++++++++++++++++++++
>>>  drivers/usb/dwc3/core.h                        |    7 ++++
>>>  drivers/usb/dwc3/platform_data.h               |    2 +
>>>  5 files changed, 66 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
>>> index e807635..471366d 100644
>>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>>> @@ -6,11 +6,13 @@ Required properties:
>>>   - compatible: must be "snps,dwc3"
>>>   - reg : Address and length of the register set for the device
>>>   - interrupts: Interrupts used by the dwc3 controller.
>>> +
>>> +Optional properties:
>>>   - usb-phy : array of phandle for the PHY device.  The first element
>>>     in the array is expected to be a handle to the USB2/HS PHY and
>>>     the second element is expected to be a handle to the USB3/SS PHY
>>> -
>>> -Optional properties:
>>> + - phys: from the *Generic PHY* bindings
>>> + - phy-names: from the *Generic PHY* bindings
>>>   - tx-fifo-resize: determines if the FIFO *has* to be reallocated.
>>>  
>>>  This is usually a subnode to DWC3 glue to which it is connected.
>>> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
>>> index 8e385b4..64eed6f 100644
>>> --- a/drivers/usb/dwc3/Kconfig
>>> +++ b/drivers/usb/dwc3/Kconfig
>>> @@ -2,6 +2,7 @@ config USB_DWC3
>>>  	tristate "DesignWare USB3 DRD Core Support"
>>>  	depends on (USB || USB_GADGET) && HAS_DMA
>>>  	select USB_PHY
>>> +	select GENERIC_PHY
>>>  	select USB_XHCI_PLATFORM if USB_SUPPORT && USB_XHCI_HCD
>>>  	help
>>>  	  Say Y or M here if your system has a Dual Role SuperSpeed
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index cb91d70..28bfa5b 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -82,6 +82,12 @@ static void dwc3_core_soft_reset(struct dwc3 *dwc)
>>>  
>>>  	usb_phy_init(dwc->usb2_phy);
>>>  	usb_phy_init(dwc->usb3_phy);
>>> +
>>> +	if (dwc->usb2_generic_phy)
>>> +		phy_init(dwc->usb2_generic_phy);
>>> +	if (dwc->usb3_generic_phy)
>>> +		phy_init(dwc->usb3_generic_phy);
>>> +
>>
>> dwc3_core_soft_reset() is called from dwc3_core_init() which is called from
>> dwc3_probe() but before the PHYs are initialized.
>>
>> This will cause phy power_on() to be called before phy_init() which is wrong.
>>

You overlooked the above?

>>>  	mdelay(100);
>>>  
>>>  	/* Clear USB3 PHY reset */
>>> @@ -343,6 +349,11 @@ static void dwc3_core_exit(struct dwc3 *dwc)
>>>  {
>>>  	usb_phy_shutdown(dwc->usb2_phy);
>>>  	usb_phy_shutdown(dwc->usb3_phy);
>>> +
>>> +	if (dwc->usb2_generic_phy)
>>> +		phy_power_off(dwc->usb2_generic_phy);
>>> +	if (dwc->usb3_generic_phy)
>>> +		phy_power_off(dwc->usb3_generic_phy);
>>>  }
>>>  
>>>  #define DWC3_ALIGN_MASK		(16 - 1)
>>> @@ -439,6 +450,26 @@ static int dwc3_probe(struct platform_device *pdev)
>>>  		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
>>>  	}
>>>  
>>> +	count = of_property_match_string(node, "phy-names", "usb2-phy");
>>> +	if (count >= 0 || (pdata && pdata->usb2_generic_phy)) {
>>> +		dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
>>> +		if (IS_ERR(dwc->usb2_generic_phy)) {
>>> +			dev_err(dev, "no usb2 phy configured yet");
>>> +			return PTR_ERR(dwc->usb2_generic_phy);
>>> +		}
>>> +		dwc->usb2_phy = NULL;
>>> +	}
>>> +
>>> +	count = of_property_match_string(node, "phy-names", "usb3-phy");
>>> +	if (count >= 0 || (pdata && pdata->usb3_generic_phy)) {
>>> +		dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
>>> +		if (IS_ERR(dwc->usb3_generic_phy)) {
>>> +			dev_err(dev, "no usb3 phy configured yet");
>>> +			return PTR_ERR(dwc->usb3_generic_phy);
>>> +		}
>>> +		dwc->usb3_phy = NULL;
>>> +	}
>>> +
>>
>> There are a couple of issues here.
>> - The above code must be executed only if it node is valid.
> 
> of_property_match_string will give a error value if the node is not present.
> *count >= 0* can take care of this.

OK. 

>> - We must either get both PHYs via old method or via new method and not support mix matching
>> them. e.g. it is possible with this code that usb2_phy is set and usb3_generic_phy is set.
> 
> Why? As long as both the frameworks co-exist (and we support both in dwc3), I
> don't see any reason why we shouldn't allow it. We can avoid adding a few more
> checks by leaving it the way it is currently.

Because it just doesn't seem elegant. Why would you want to even allow both types of PHY
to be used simultaneously?

cheers,
-roger
