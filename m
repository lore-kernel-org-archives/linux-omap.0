From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: da850: Add the cppi41 dma node
Date: Tue, 10 Jan 2017 10:15:29 -0600
Message-ID: <026deab8-8584-0744-3ec5-9346a7f6d16a@lechnology.com>
References: <20170109162449.5012-1-abailon@baylibre.com>
 <20170109162449.5012-2-abailon@baylibre.com>
 <811adb6b-00e4-bbc4-d6f5-7bf3ba85ab63@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <811adb6b-00e4-bbc4-d6f5-7bf3ba85ab63-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/09/2017 12:26 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 01/09/2017 07:24 PM, Alexandre Bailon wrote:
>
>> This adds the device tree node for the cppi41 dma
>> used by the usb otg controller present in the da850 family of SoC's.
>>
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/da850.dtsi | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>> index 104155d..d6b406a 100644
>> --- a/arch/arm/boot/dts/da850.dtsi
>> +++ b/arch/arm/boot/dts/da850.dtsi
>> @@ -403,6 +403,22 @@
>>              phy-names = "usb-phy";
>>              status = "disabled";
>>          };
>> +        cppi41dma: dma-controller@201000 {
>> +            compatible = "ti,da8xx-cppi41";
>> +            reg =  <0x200000 0x1000
>
>    I don't remember any DA8xx glue regs having to do with the CPPI 4.1...
>
>> +                0x201000 0x1000
>> +                0x202000 0x1000
>> +                0x204000 0x4000>;
>> +            reg-names = "glue", "controller",
>> +                    "scheduler", "queuemgr";
>> +            interrupts = <58>;
>> +            interrupt-names = "glue";
>> +            #dma-cells = <2>;
>> +            #dma-channels = <4>;
>> +            #dma-requests = <256>;
>> +            status = "disabled";
>
>    Why disabled? It doesn't use any external pins...

Why enable it if musb node is not also enabled?

>
> [...]
>
> MBR, Sergei
>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
