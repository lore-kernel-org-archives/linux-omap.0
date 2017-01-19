From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Thu, 19 Jan 2017 14:15:24 +0200
Message-ID: <16136231-7dfd-2f84-064f-f78a6ffe073b@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2>
 <8737o8qd00.fsf@linux.intel.com> <20160621060517.GA5108@shlinux2>
 <877fdjovef.fsf@linux.intel.com> <20160621090738.GD5108@shlinux2>
 <87h9cmoo4s.fsf@linux.intel.com> <20160621130512.GF5108@shlinux2>
 <87por9lnjd.fsf@linux.intel.com> <576A4321.6020209@ti.com>
 <87fus5ljwf.fsf@linux.intel.com> <576A4C95.4080202@ti.com>
 <CAFp+6iEpnHTWQe196zWPJu3vqb+L=47rfU_8nfuUNC=Gjvc8Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFp+6iEpnHTWQe196zWPJu3vqb+L=47rfU_8nfuUNC=Gjvc8Gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, Felipe Balbi <balbi@kernel.org>
Cc: Peter Chen <hzpeterchen@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, peter.chen@freescale.com, Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@linuxfoundation.org>, dan.j.williams@intel.com, Mathias Nyman <mathias.nyman@linux.intel.com>, Joao.Pinto@synopsys.com, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, jun.li@freescale.com, grygorii.strashko@ti.com, Rob Herring <robh@kernel.org>, nsekhar@ti.com, b-liu@ti.com, Joe Perches <joe@perches.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Vivek,

On 19/01/17 13:56, Vivek Gautam wrote:
> Hi,
> 
> 
> On Wed, Jun 22, 2016 at 2:00 PM, Roger Quadros <rogerq@ti.com> wrote:
> 
> Luckily hit this thread while checking about DRD role functionality for DWC3.
> 
>> On 22/06/16 11:14, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Roger Quadros <rogerq@ti.com> writes:
>>>>>>>>>>>> For the real use case, some Carplay platforms need it.
>>>>>>>>>>>
>>>>>>>>>>> Carplay does *NOT* rely on OTG. Apple has its own proprietary and closed
>>>>>>>>>>> specification which is not OTG-compliant.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Yes, it is not OTG-compliant, but it can co-work with some standard OTG FSM
>>>>>>>>>> states to finish role swap.
>>>>>>>>>
>>>>>>>>> What are you referring to as "finish role swap"? I don't get that.
>>>>>>>>
>>>>>>>> Change current role from host to peripheral.
>>>>>>>
>>>>>>> Okay, we have two scenarios here:
>>>>>>>
>>>>>>> 1. You need full OTG compliance
>>>>>>>
>>>>>>>   For this, granted, you need the state machine if your HW doesn't
>>>>>>>   track it. This is a given. With only one user, however, perhaps
>>>>>>>   we don't need a generic layer. There are not enough different
>>>>>>>   setups to design a good enough generic layer. We will end up
>>>>>>>   with a pseudo-generic framework which is coupled with its only
>>>>>>>   user.
>>>>>>>
>>>>>>> 2. Dual-role support, without OTG compliance
>>>>>>>
>>>>>>>   In this case, you don't need a stack. All you need is a signal
>>>>>>>   to tell you state of ID pin and another to tell you state of
>>>>>>>   VBUS level. If you have those, you don't need to walk an OTG
>>>>>>>   state machine at all. You don't need any of those quirky OTG
>>>>>>>   timers, agreed?
>>>>>>>
>>>>>>>   Given the above, why would you even want to use a subset of OTG
>>>>>>>   state machine to implement something that's _usually_ as simple
>>>>>>>   as:
>>>>>>>
>>>>>>> 8<----------------------------------------------------------------------
>>>>>>>   vbus = read(VBUS_STATE); /* could be a gpio_get_value() */
>>>>>>>         id = read(ID_STATE); /* could be a gpio_get_value() */
>>>>>>>
>>>>>>>         set_role(id);
>>>>>>>         set_vbus(vbus);
>>>>>>> ------------------------------------------------------------------------
>>>>>>>
>>>>>>
>>>>>> In fact, the individual driver can do it by itself. The chipidea driver
>>>>>> handles OTG and dual-role well currently. By considering this OTG/DRD
>>>>>> framework is worthwhile or not, we would like to see if it can
>>>>>> simplify DRD design for each driver, and can benefit the platforms which
>>>>>> has different drivers for host and peripheral to finish the role switch
>>>>>> well.
>>>>>
>>>>> simplify how?  By adding unnecessary workqueues and a level indirection
>>>>> that just goes back to the same driver?
>>>>
>>>> What do you mean by same driver?
>>>
>>> dwc3 registers to OTG layer. dwc3 also registers as UDC to UDC
>>> layer. When dwc3 OTG IRQ fires, dwc3 tells OTG layer about it and OTG
>>> layer jumps to a callback that goes back to dwc3 to e.g. start
>>> peripheral side.
>>>
>>> See ?!? Starts on dwc3, goes to OTG layer, goes back to DWC3.
>>>
>>>> Gadget driver, host driver and PHY (or MUX) driver (for ID/VBUS) can
>>>> be 3 totally independent drivers unlike dwc3 where you have a single
>>>> driver in control of both host and gadget.
>>>
>>> That's a totally different issue and one not being tackled by OTG
>>> layer, because there are no such users yet. We can't design anything
>>> based solely on speculation of what might happen.
>>>
>>> If there aren't enough users, there is no way to design a good generic
>>> layer.
>>>
>>>> Questions not clear to me are:
>>>>
>>>> 1) Which driver handles ID/VBUS events and makes a decision to do the
>>>> role swap?  Probably the PHY/MUX driver?
>>>
>>> This is implementation dependent. For TI's USB subsystem, we have PMIC
>>> sampling VBUS/ID that and using EXTCON to tell dwc3-omap to program UTMI
>>> mailbox. The same mailbox can be used in HW-mode (see AM437x) where SW
>>> has no intervention.
>>>
>>> For Intel's USB subsystem, we have PMIC sampling VBUS/ID with an
>>> internal mux (much like TI's UTMI mailbox, but slightly different) to
>>> switch between a separate XHCI or a separate dwc3. The same mux can be
>>> put in HW-mode where SW has no intervention.
>>>
>>> In any case, for Intel's stuff most of the magic happens in ASL. Our PHY
>>> driver just detects role (at least for Type-C based plats) and executes
>>> _DSM with correct arguments [1]. _DSM will program internal MUX, toggle
>>> VBUS and, for type-C, toggle VCONN when needed.
>>>
>>>> 2) How does it perform the role swap? Probably a register write to the
>>>> PHY/MUX without needing to stop/start controllers? Easy case is both
>>>> controllers can run in co-existence without interference. Is there any
>>>> platform other than dwc3 where this is not the case?
>>>
>>> Again speculation. But to answer your question, only dwc3 is in such a
>>> case today. But even for dwc3 we can have DRD with a much, much simpler
>>> setup as I have already explained.
>>>
>>>> 3) Even if host and gadget controllers can operate in coexistence,
>>>> there is no need for both to be running for embedded applications
>>>> which are usually power conservative.  How can we achieve that?
>>>
>>> Now you're also speculating that you're running on embedded applications
>>> and that we _can_ power off parts of the IP. I happen to know that we
>>> can't power off XHCI part of dwc3 in TI's SoC because that's fed by same
>>> Clocks and power rails as the peripheral side.
>>>
>>> [1] https://lkml.org/lkml/2016/6/21/658
>>>
>> For TI's case it is dwc3 and you are implementing the role swap in the dwc3
>> driver where you do intend to remove the XHCI platform device. So I'm not
>> much concerned about that.
>>
>> I was concerned about other platforms. I guess I'll let the other platform
>> people speak up as to what they need.
> 
> I will talk about the msm platforms using dwc3 hardware.
> DWC3 controller on msm doesn't seem to have full otg functionality,
> and the driver makes use of switching between host and device
> using PRTCAPDIR register in of the core [1].
> 
> We plan to support this DRD role switching (swapping host and device
> functionality based on id/vbus interrupts) in upstream.
> 
> Do we see a valid case to have this framework?

Felipe wanted to have a minimal dual-role logic inside dwc3 which is
independent of any DRD/OTG framework.

I have implemented this and will send out patches today for review.

> Or, may be add a 'drd' layer for dwc3 that handles
> role switching (using PRTCAPDIR) based on the id/vbus extcon notifications.
> 
> 
> [1] https://source.codeaurora.org/quic/la/kernel/msm-3.18/tree/drivers/usb/dwc3/dwc3-msm.c?h=msm-3.18
>      "dwc3_otg_start_host()"
>      "dwc3_otg_start_peripheral()"
> 
> 

regards,
-roger
