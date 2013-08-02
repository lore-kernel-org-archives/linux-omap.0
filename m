From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: dss-common: fix Panda's DVI DDC channel
Date: Fri, 2 Aug 2013 09:43:36 -0500
Message-ID: <51FBC598.50601@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com> <1374570405-8301-2-git-send-email-tomi.valkeinen@ti.com> <51FBAC21.2040609@ti.com> <51FBAD64.5090600@ti.com> <51FBB461.7010209@ti.com> <51FBC0C0.2060207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab3HBOoB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 10:44:01 -0400
In-Reply-To: <51FBC0C0.2060207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/02/2013 09:22 AM, Tomi Valkeinen wrote:
> On 02/08/13 16:30, Nishanth Menon wrote:
>> On 08/02/2013 08:00 AM, Tomi Valkeinen wrote:
>
>>> Feel free to help me develop the DT support for DSS =). When that's
>>> done, we can remove all this code.
>>
>> suggesting here - but it will be nice we have some steps towards this
>> direction - is there anything you'd suggest we do first?
>
> I do have a DSS-DT branch, which works. I've had such a branch for
> almost a year, although I've been refining it all the time. But I'm
> still not happy with the DT bindings I have there, and I haven't had any
> clear ideas how to solve those issues. And, as the DT bindings are an
> external API, I've been very cautious with it.
>
> I'm currently cleaning the branch up, and I hope I can send the series
> next week. Hopefully I'll receive some ideas for the problematic parts.
> I'll cc you =).

Awesome, given that there is work in progress to do this properly and 
the current solution is meant for 3.11 transition, I dont have any 
objections.


>
>>>> Example: if -EPROBEDEFER is incurred due to some unexpected dependency,
>>>> we'd have to redo the numbering in the kernel yet again.
>>>
>>> Hmm, sorry? Do you mean that the i2c bus numbers can change "randomly"?
>>>
>>> With board files they were numbered 1, 2, 3, 4, but with DT boot they
>>> seem to be 0, 1, 2, 3. And as we have the current situation where omap4
>>> boots with DT, but DSS does not have DT support, we add the DSS related
>>> devices in a board-file-like-fashion.
>>
>> Aah we are then depending on the following
>> i2c-omap.c:
>>   adap->nr = pdev->id;
>>   r = i2c_add_numbered_adapter(adap);
>>
>> mach-omapx/i2c.c:
>> .. i2c_bus_register..
>> pdev->id = bus_id
>> platform_device_register(pdev);
>>
>>
>> I dont seem to see any similar numbering enforced in dtsi - if I reorder
>> the i2c entries in SoC dtsi, i'd have an issue as well, no?
>
> I don't know, but yes, possibly. But you probably won't reorder them, as
> they are in the HW I2C ID module order.

we dont want to depend on ordering of anything usually.. anyways, 
besides the point, I guess.

>
>> probe deferral could create problems as well.. not saying it can change
>> random order on a given kernel between boots, but am saying that when
>> new changes come in, deferral mechanism ensures proper ordering
>> dynamically, which kind of messes up with expected device numbers. I had
>> an issue with mmc sometime back where probe deferal on mmc1 made it
>> registered as second device as the dependency was not present on the mmc2.
>
> Yes, interesting point. If I got you right, you're saying that if a
> single i2c device gets deferred, but the others not, the ID numbering
> could change?
>
> I don't if it's possible to get only single i2c device deferred. Maybe.
>
> Anyway, we need some way to fix this for 3.11. As far as I understand,
> it's rather unlikely that the bus number would change, so I think this
> fix is the best I can do.
>
>> No reason this cannot happen on other busses as well. To solve this on
>> i2c dts, the usual convention is as follows (from omap3-beagle):
>> &i2c1 {
>>          clock-frequency = <2600000>;
>>
>>          twl: twl@48 {
>>                  reg = <0x48>;
>>                  interrupts = <7>; /* SYS_NIRQ cascaded to intc */
>>                  interrupt-parent = <&intc>;
>>          };
>> };
>>
>> this ensures that probe success order is made independent of device
>> expectation of i2c bus numbering or the order in which it was defined in
>> dts.
>
> With dts, this is not a problem, it's handle with phandles. Although not
> as you show above, because we don't really have an i2c device on the board.
>
> The i2c in question goes through the DVI connector to the monitor. So
> the monitor is the i2c device. Thus we just get a handle to the i2c bus
> going to the monitor, and send messages to it directly, without having a
> linux i2c device.

I think we should take this as part of your series next week :). I could 
argue that the device on remote display which communicates over DCC is 
an real i2c device and communicates using real i2c protocol? when we 
read it, how the gates to EDID information is opened up is upto the driver.


-- 
Regards,
Nishanth Menon
