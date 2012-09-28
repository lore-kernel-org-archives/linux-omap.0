From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5] drivers: usb: phy: add a new driver for omap usb2 phy
Date: Sat, 29 Sep 2012 00:29:26 +0530
Message-ID: <CAAe_U6KfcucSHyndadUXiHer4jxYmMkFp1Ur0oNHTjJeOui04g@mail.gmail.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com>
 <1346943430-18236-2-git-send-email-kishon@ti.com>
 <50605CFB.5090402@gmail.com>
 <CAAe_U6+2Vxd8F_JMafm41+0SnZSrZCa_9VKRbdB200BUHw5vEQ@mail.gmail.com>
 <506461A0.4050103@gmail.com> <5064D7CA.1070909@ti.com>
 <CAAe_U6KHk1nuSBVn-4H397wzUk0cnqGe_H0D8RVqrSFYGJVMCg@mail.gmail.com>
 <5065BE44.3090903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5065BE44.3090903-l0cyMroinI0@public.gmane.org>
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
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 28, 2012 at 8:42 PM, Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org> wrote:
> On 9/28/2012 3:07 AM, ABRAHAM, KISHON VIJAY wrote:
>>
>> Hi,
>>
>> On Fri, Sep 28, 2012 at 4:18 AM, Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org> wrote:
>>>
>>> On 9/27/2012 7:24 AM, Rob Herring wrote:
>>>>
>>>>
>>>> On 09/25/2012 05:06 AM, ABRAHAM, KISHON VIJAY wrote:
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Mon, Sep 24, 2012 at 6:45 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> On 09/06/2012 09:57 AM, Kishon Vijay Abraham I wrote:
>>>>>>>
>>>>>>>
>>>>>>> All phy related programming like enabling/disabling the clocks,
>>>>>>> powering
>>>>>>> on/off the phy is taken care of by this driver. It is also used for
>>>>>>> OTG
>>>>>>> related functionality like srp.
>>>>>>>
>>>>>>> This also includes device tree support for usb2 phy driver and
>>>>>>> the documentation with device tree binding information is updated.
>>>>>>>
>>>>>>> Currently writing to control module register is taken care in this
>>>>>>> driver which will be removed once the control module driver is in
>>>>>>> place.
>>>>>>>
>>>>>>> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>>>>>> ---
>>>>>>>    Documentation/devicetree/bindings/usb/usb-phy.txt |   17 ++
>>>>>>>    drivers/usb/phy/Kconfig                           |    9 +
>>>>>>>    drivers/usb/phy/Makefile                          |    1 +
>>>>>>>    drivers/usb/phy/omap-usb2.c                       |  271
>>>>>>> +++++++++++++++++++++
>>>>>>>    include/linux/usb/omap_usb.h                      |   46 ++++
>>>>>>>    include/linux/usb/phy_companion.h                 |   34 +++
>>>>>>>    6 files changed, 378 insertions(+)
>>>>>>>    create mode 100644
>>>>>>> Documentation/devicetree/bindings/usb/usb-phy.txt
>>>>>>>    create mode 100644 drivers/usb/phy/omap-usb2.c
>>>>>>>    create mode 100644 include/linux/usb/omap_usb.h
>>>>>>>    create mode 100644 include/linux/usb/phy_companion.h
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt
>>>>>>> b/Documentation/devicetree/bindings/usb/usb-phy.txt
>>>>>>> new file mode 100644
>>>>>>> index 0000000..80d4148
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/usb/usb-phy.txt
>>>>>>
>>>>>>
>>>>>>
>>>>>> This is a very generic name...
>>>>>>
>>>>>>> @@ -0,0 +1,17 @@
>>>>>>> +USB PHY
>>>>>>> +
>>>>>>> +OMAP USB2 PHY
>>>>>>> +
>>>>>>> +Required properties:
>>>>>>> + - compatible: Should be "ti,omap-usb2"
>>>>>>
>>>>>>
>>>>>>
>>>>>> ...for a specific phy. However, I do think a generic binding to
>>>>>> describe
>>>>>> host ctrlr to phy connections is needed.
>>>>>>
>>>>>>> + - reg : Address and length of the register set for the device. Also
>>>>>>> +add the address of control module dev conf register until a driver
>>>>>>> for
>>>>>>> +control module is added
>>>>>>
>>>>>>
>>>>>>
>>>>>> The dts should describe the h/w, not what you need for the current
>>>>>> driver. The 2nd reg field does not belong here.
>>>>>
>>>>>
>>>>>
>>>>> Indeed. This was discussed and agreed upon as a interim solution till
>>>>> we have a control module driver in place to write to the control
>>>>> module register.
>>>>
>>>>
>>>>
>>>> Discussed where and agreed by who? I for one do not agree.
>>>
>>>
>>>
>>> Yeah, what was tolerated was the addition of that address inside hwmod
>>> data,
>>> but I do agree that it should not go into DTS.
>>
>>
>> So how can we handle reg writes to control module until we have a
>> control module driver. usb2 phy does not have a hwmod data for itself.
>> Do you think we should add a new hwmod data for usb2 phy and use this
>> in the usb2phy data node in the dts file?
>
>
> Now, I'm confused... didn't you already do that? What was the hwmod you
> added?

That was in usb_otg_hs (musb glue for omap) for writing to MUSB
mailbox. This is for usb2 phy for powering on/off the PHY.

Thanks
Kishon
