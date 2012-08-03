From: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] arm/dts: AM33XX: Add D_CAN device tree data
Date: Fri, 3 Aug 2012 14:44:10 +0530
Message-ID: <501B9662.6000406@ti.com>
References: <1343219012-19472-1-git-send-email-anilkumar@ti.com>
 <1343219012-19472-2-git-send-email-anilkumar@ti.com>
 <500FE9FC.7070303@mvista.com> <501101A7.2030503@gmail.com>
 <50114069.7070605@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50114069.7070605-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
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
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 7/26/2012 6:34 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 26-07-2012 12:36, Daniel Mack wrote:
> 
>>>> Add Bosch D_CAN controller device tree data to AM33XX dtsi file
>>>> by adding d_can device node with all the necessary parameters.
> 
>>>> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>>    arch/arm/boot/dts/am33xx.dtsi |    5 +++++
>>>>    1 file changed, 5 insertions(+)
> 
>>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>>>> index 9b974dc..2db2ffb 100644
>>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>>> @@ -163,5 +163,10 @@
>>>>    			#size-cells = <0>;
>>>>    			ti,hwmods = "i2c3";
>>>>    		};
>>>> +
>>>> +		dcan1: d_can@481D0000 {
>>>
>>>      Address postfix in the node name and no "reg" property?
> 
>> This still works due to the hwmod mappings OMAP relies on.
> 
>     I.e. the "reg" property is populated in runtime?
> 
>> I would still
>> put it there, so the switch to real DT definitions will be less painful.
> 
>     How it helps anything?
> 

This is required field if you want to use "of_dev_auxdata", without
"reg" property OF layer fails to create dev_id (name) bindings with what
you have specified as part of "of_dev_auxdata".

And with respect to CAN driver, even though we are using hwmod, I would
want to create dev_id = d_can.0 and d_can.1. And this is only possible
if Address and compatible string matches.

So this field is important and required in this case.

Thanks,
Vaibhav
