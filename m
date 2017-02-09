From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/8] usb: dwc3: add dual-role support
Date: Thu, 9 Feb 2017 09:49:07 +0200
Message-ID: <81abd13d-4800-2f05-8ad2-7d31d7f596f4@ti.com>
References: <1485170381-32110-1-git-send-email-rogerq@ti.com>
 <CAFp+6iHXgG1Q4+5XU+mBa-VEcyMs+X9RtnM6-saGCvY+7n7rgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFp+6iHXgG1Q4+5XU+mBa-VEcyMs+X9RtnM6-saGCvY+7n7rgQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Felipe Balbi <balbi@kernel.org>, Tony Lindgren <tony@atomide.com>, peter.chen@freescale.com, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Vivek,

On 09/02/17 08:42, Vivek Gautam wrote:
> Hi Roger,
> 
> On Mon, Jan 23, 2017 at 4:49 PM, Roger Quadros <rogerq@ti.com> wrote:
>> Hi,
>>
>> We rely on the OTG controller block to provide us with
>> VBUS and ID line status via an interrupt.
>>
>> This is then used to switch the controller between host, peripheral
>> and idle roles based on the following table.
>>
>>     ID  VBUS    dual-role state
>>     --  ----    ---------------
>>     0   x       A_HOST - Host controller active
>>     1   0       B_IDLE - Both Host and Gadget controllers inactive
>>     1   1       B_PERIPHERAL - Gadget controller active
>>
> 
> Thanks for this series.
> Sorry, i was held up with something else so couldn't take a look at it.
> I will integrate this with my work, and add some basic extcon
> support to enable passing vbus and id events to dwc3 layer to test
> this out on msm platforms.

I already have this done for one of our platforms to workaround
a limitation with the OTG IP block on it.
I can post it today and you can give your comments.

cheers,
-roger
> 
> 
> Regards
> Vivek
> 
>> Couple of things to clarify:
>> - There is a small window where we can potentially miss an
>> event related to OTG. I've added a comment in the code where this
>> could happen. How can we prevent this? Is it better to just leave
>> the OTG events unmasked (but keep otg_irq on ARM GIC disabled)
>> so that any new events can be captured by the OTG event register
>> and interrupt re-triggered if it has not been serviced by the
>> previous interrupt.
>> - I'm running the entire dual-role state change logic inside
>> the threaded interrupt handler with dwc->lock (spinlock) held
>> but IRQs enabled. OTG events are very rare i.e. manual intervention
>> so I don't see this as a problem. Just wanted to double check.
>> - Some SoC's (e.g. Qualcomm MSM) do not have the OTG controller block
>> but do have both host and peripheral controllers and so can operate
>> in dual role mode. Current series does not address this case.
>> We can get dual-role to work with such SoCs if core.c can get
>> information about ID and VBUS somehow (private interface
>> from parent or directly read extcon?).
>>
>> cheers,
>> -roger
>>
>> Roger Quadros (8):
>>   usb: otg-fsm: Prevent build warning "VDBG" redefined
>>   usb: dwc3-omap: Fix missing break in dwc3_omap_set_mailbox()
>>   usb: dwc3: use BIT() macro where possible
>>   usb: dwc3: core.h: add some register definitions
>>   usb: dwc3: add dual-role support
>>   ARM: dts: dra7x-evm: Enable dual-role mode for USB1
>>   ARM: dts: am43xx: Enable dual-role mode for USB1
>>   ARM: dts: am57xx-idk: Enable dual-role mode for USB2
>>
>>  arch/arm/boot/dts/am437x-gp-evm.dts      |   2 +-
>>  arch/arm/boot/dts/am437x-sk-evm.dts      |   2 +-
>>  arch/arm/boot/dts/am43x-epos-evm.dts     |   2 +-
>>  arch/arm/boot/dts/am57xx-idk-common.dtsi |   2 +-
>>  arch/arm/boot/dts/dra7-evm.dts           |   2 +-
>>  arch/arm/boot/dts/dra72-evm-common.dtsi  |   2 +-
>>  drivers/usb/common/usb-otg-fsm.c         |   7 +
>>  drivers/usb/dwc3/core.c                  | 583 ++++++++++++++++++++++++++++++-
>>  drivers/usb/dwc3/core.h                  | 312 ++++++++++++-----
>>  drivers/usb/dwc3/dwc3-omap.c             |  49 +--
>>  drivers/usb/dwc3/gadget.c                |  18 +-
>>  drivers/usb/dwc3/gadget.h                |  20 +-
>>  drivers/usb/phy/phy-fsl-usb.c            |   7 +
>>  include/linux/usb/otg-fsm.h              |  15 -
>>  14 files changed, 848 insertions(+), 175 deletions(-)
>>
>> --
>> 2.7.4
>>
> 

-- 
cheers,
-roger
