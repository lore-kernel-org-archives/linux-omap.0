From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: dss-common: fix Panda's DVI DDC channel
Date: Fri, 2 Aug 2013 08:30:09 -0500
Message-ID: <51FBB461.7010209@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com> <1374570405-8301-2-git-send-email-tomi.valkeinen@ti.com> <51FBAC21.2040609@ti.com> <51FBAD64.5090600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40868 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296Ab3HBNac (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 09:30:32 -0400
In-Reply-To: <51FBAD64.5090600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/02/2013 08:00 AM, Tomi Valkeinen wrote:
> On 02/08/13 15:54, Nishanth Menon wrote:
>> On 07/23/2013 04:06 AM, Tomi Valkeinen wrote:
>>> Panda's DVI connector's DDC pins are connected to OMAP's third i2c bus.
>>> With non-DT, the bus number was 3, and that is what is used in the
>>> dss-common.c which contains the platform data for Panda's DVI.
>>>
>>> However, with DT, the bus number is 2. As we now only have DT boot for
>>> Panda, we have to change the bus number to make DVI EDID read
>>> operational.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>>    arch/arm/mach-omap2/dss-common.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/dss-common.c
>>> b/arch/arm/mach-omap2/dss-common.c
>>> index 393aeef..043e570 100644
>>> --- a/arch/arm/mach-omap2/dss-common.c
>>> +++ b/arch/arm/mach-omap2/dss-common.c
>>> @@ -42,7 +42,7 @@
>>>
>>>    /* Using generic display panel */
>>>    static struct tfp410_platform_data omap4_dvi_panel = {
>>> -    .i2c_bus_num        = 3,
>>> +    .i2c_bus_num        = 2,
>>>        .power_down_gpio    = PANDA_DVI_TFP410_POWER_DOWN_GPIO,
>>>    };
>>>
>>>
>> completely dumb question :) :
>> why cant we have dts support for this instead of having to renumber
>> every time?
>
> What do you mean "every time"?

below

>
> Feel free to help me develop the DT support for DSS =). When that's
> done, we can remove all this code.

suggesting here - but it will be nice we have some steps towards this 
direction - is there anything you'd suggest we do first?

>
>> Example: if -EPROBEDEFER is incurred due to some unexpected dependency,
>> we'd have to redo the numbering in the kernel yet again.
>
> Hmm, sorry? Do you mean that the i2c bus numbers can change "randomly"?
>
> With board files they were numbered 1, 2, 3, 4, but with DT boot they
> seem to be 0, 1, 2, 3. And as we have the current situation where omap4
> boots with DT, but DSS does not have DT support, we add the DSS related
> devices in a board-file-like-fashion.

Aah we are then depending on the following
i2c-omap.c:
  adap->nr = pdev->id;
  r = i2c_add_numbered_adapter(adap);

mach-omapx/i2c.c:
.. i2c_bus_register..
pdev->id = bus_id
platform_device_register(pdev);


I dont seem to see any similar numbering enforced in dtsi - if I reorder 
the i2c entries in SoC dtsi, i'd have an issue as well, no?

probe deferral could create problems as well.. not saying it can change 
random order on a given kernel between boots, but am saying that when 
new changes come in, deferral mechanism ensures proper ordering 
dynamically, which kind of messes up with expected device numbers. I had 
an issue with mmc sometime back where probe deferal on mmc1 made it 
registered as second device as the dependency was not present on the mmc2.

No reason this cannot happen on other busses as well. To solve this on 
i2c dts, the usual convention is as follows (from omap3-beagle):
&i2c1 {
         clock-frequency = <2600000>;

         twl: twl@48 {
                 reg = <0x48>;
                 interrupts = <7>; /* SYS_NIRQ cascaded to intc */
                 interrupt-parent = <&intc>;
         };
};

this ensures that probe success order is made independent of device 
expectation of i2c bus numbering or the order in which it was defined in 
dts.


just my 2 cents to help continued functionality in the world of dts..
-- 
Regards,
Nishanth Menon
