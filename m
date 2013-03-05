From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 7/8] ARM: dts: omap5: add dwc3 omap dt data
Date: Tue, 5 Mar 2013 20:33:18 +0530
Message-ID: <51360936.7050009@ti.com>
References: <1362494223-14151-1-git-send-email-kishon@ti.com>
 <1362494223-14151-8-git-send-email-kishon@ti.com>
 <51360436.6050409@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51360436.6050409-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
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
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 05 March 2013 08:11 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 05-03-2013 18:37, Kishon Vijay Abraham I wrote:
>
>> Add dwc3 omap glue data to the omap5 dt data file. The information about
>> the dt node added here is available @
>> Documentation/devicetree/bindings/usb/omap-usb.txt
>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/omap5.dtsi |   11 +++++++++++
>>   1 file changed, 11 insertions(+)
>
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index bd73257..c4eb2ec 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -505,6 +505,17 @@
>>               ti,type = <2>;
>>           };
>>
>> +        omap_dwc3@4a020000 {
>> +            compatible = "ti,dwc3";
>> +            ti,hwmods = "usb_otg_ss";
>> +            reg = <0x4a020000 0x1000>;
>> +            interrupts = <0 93 4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>
>    Why the above two props? You don't seem to have the subnodes...

It's added in the next patch. Ok, Felipe has already pointed out to 
merge the two patches.

Thanks
Kishon
