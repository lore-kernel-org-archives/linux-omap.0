From: kishon <kishon@ti.com>
Subject: Re: [PATCH v2 8/8] ARM: dts: omap5: add dwc3 core dt data
Date: Wed, 6 Mar 2013 14:51:14 +0530
Message-ID: <51370A8A.7010304@ti.com>
References: <1362494223-14151-1-git-send-email-kishon@ti.com> <1362494223-14151-9-git-send-email-kishon@ti.com> <20130305143934.GB12123@arwen.pp.htv.fi> <51370494.7090902@ti.com> <20130306091942.GJ28587@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130306091942.GJ28587@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 06 March 2013 02:49 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Mar 06, 2013 at 02:25:48PM +0530, kishon wrote:
>> Hi,
>>
>> On Tuesday 05 March 2013 08:09 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Tue, Mar 05, 2013 at 08:07:03PM +0530, Kishon Vijay Abraham I wrote:
>>>> Add dwc3 core dt data as a subnode to dwc3 omap glue data in omap5 dt
>>>> data file. The information for the entered data node is available @
>>>> Documentation/devicetree/bindings/usb/dwc3.txt
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>   arch/arm/boot/dts/omap5.dtsi |    7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>>>> index c4eb2ec..24dd69f 100644
>>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>>> @@ -514,6 +514,13 @@
>>>>   			#size-cells = <1>;
>>>>   			utmi-mode = <2>;
>>>>   			ranges;
>>>> +			dwc3@4a030000 {
>>>> +				compatible = "synopsys,dwc3";
>>>> +				reg = <0x4a030000 0x1000>;
>>>> +				interrupts = <0 92 4>;
>>>> +				usb-phy = <&usb2_phy>, <&usb3_phy>;
>>>> +				tx-fifo-resize;
>>>
>>> I think this should be merged with previous patch. Also, we need to
>>> check whether tx-fifo-resize is needed with ES2 or not ;-)
>>
>> yeah. ES2 works without tx-fifo-resize.
>
> Great, I guess we can deprecate that attribute. Can you check if ES2
> still works with:
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 82e160e..cad0131 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2029,6 +2029,8 @@ static void dwc3_gadget_usb3_phy_suspend(struct dwc3 *dwc, int suspend)
>   {
>   	u32			reg;
>
> +	return;
> +
>   	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
>
>   	if (suspend)
> @@ -2043,6 +2045,8 @@ static void dwc3_gadget_usb2_phy_suspend(struct dwc3 *dwc, int suspend)
>   {
>   	u32			reg;
>
> +	return;
> +
>   	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>
>   	if (suspend)
>
>
> starting on 1.94a (IIRC) core was supposed to control PHYs directly and
> since there's nobody in linux mainline using any version prior to 1.94a,
> we could drop that too.

Will check that in a while.

Thanks
Kishon
