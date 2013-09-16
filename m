From: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] arm: dts: omap4+: Add DMM bindings
Date: Mon, 16 Sep 2013 17:55:00 +0530
Message-ID: <5236F89C.2020903@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379323815-14130-1-git-send-email-archit@ti.com> <1379323815-14130-2-git-send-email-archit@ti.com> <5236E940.9070503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5236E940.9070503-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Monday 16 September 2013 04:49 PM, Tomi Valkeinen wrote:
> On 16/09/13 12:30, Archit Taneja wrote:
>> Add Dynamic Memory Manager (DMM) bindings for OMAP4 and OMAP5 devices. DMM
>> only requires address and irq information.
>>
>> Add documentation for the DMM bindings.
>>
>> Originally worked on by Andy Gross.
>>
>> Cc: Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
>> ---
>>   Documentation/devicetree/bindings/arm/omap/dmm.txt | 17 +++++++++++++++++
>>   arch/arm/boot/dts/omap4.dtsi                       |  7 +++++++
>>   arch/arm/boot/dts/omap5.dtsi                       |  7 +++++++
>>   3 files changed, 31 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/dmm.txt b/Documentation/devicetree/bindings/arm/omap/dmm.txt
>> new file mode 100644
>> index 0000000..237cd83
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/omap/dmm.txt
>> @@ -0,0 +1,17 @@
>> +OMAP Dynamic Memory Manager (DMM) bindings
>> +
>> +Required properties:
>> +- compatible:	Must be "ti,omap4-dmm" for OMAP4 family
>> +		Must be "ti,omap5-dmm" for OMAP5 family
>> +- reg:		Contains timer register address range (base address and length)
>
> "timer"?
>
>> +- interrupts:	Contains interrupt information (source, etc) for the DMM IRQ
>> +- ti,hwmods:	Name of the hwmod associated to the counter, which is typically
>> +		"dmm"
>
> "associated to the counter"?

Seem like copy paste errors, will fix them.

>
>> +
>> +Example:
>> +
>> +dmm: dmm@4e000000 {
>> +	compatible = "ti,omap4-dmm";
>> +	reg = <0x4e000000 0x800>;
>> +	ti,hwmods = "dmm";
>> +};
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 22d9f2b..24f388e 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -487,6 +487,13 @@
>>   			ti,hwmods = "kbd";
>>   		};
>>
>> +		dmm: dmm@4e000000 {
>
> I don't think anyone refers to this node, so there shouldn't be any need
> for the "dmm: " alias.

Yes, it won't be used. Will remove them.

Thanks,
Archit

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
