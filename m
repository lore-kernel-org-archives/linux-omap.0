From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Thu, 14 Feb 2019 15:51:24 +0000
Message-ID: <aaff678a-820c-279e-632e-1ad25953029d@arm.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
 <9c58bc48-90bf-8ac5-7fbd-0f6443e3fc5e@ti.com>
 <CACRpkdb4Q0efW5MaDmPTmewq-RFwXOTp15DCE1VpPf6g216iBw@mail.gmail.com>
 <5C65490E.6000800@ti.com> <86ef8asfap.wl-marc.zyngier@arm.com>
 <5C658CE4.5030307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5C658CE4.5030307@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, "Davis, Andrew" <afd@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, ext Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, David Lechner <david@lechnology.com>, "Nori, Sekhar" <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, nsaulnier@ti.com, jreeder@ti.com, Murali Karicheri <m-karicheri2@ti.com>, woods.technical@gmail.com, Linux-OMAP <linux-omap@vger.kernel.org>, linux-remoteproc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.or>
List-Id: linux-omap@vger.kernel.org

On 14/02/2019 15:44, Roger Quadros wrote:
> On 14/02/19 14:52, Marc Zyngier wrote:
>> On Thu, 14 Feb 2019 10:55:10 +0000,
>> Roger Quadros <rogerq@ti.com> wrote:
>>>
>>>
>>> On 14/02/19 10:37, Linus Walleij wrote:
>>>> On Thu, Feb 14, 2019 at 4:13 AM Suman Anna <s-anna@ti.com> wrote:
>>>>> [Me]
>>>>
>>>>>> To be able to use hierarchical interrupt domain in the kernel, the top
>>>>>> interrupt controller must use the hierarchical (v2) irqdomain, so
>>>>>> if this is anything else than the ARM GIC it will be an interesting
>>>>>> undertaking to handle this.
>>>>>
>>>>> These are interrupt lines coming towards the host processor running
>>>>> Linux and are directly connected to the ARM GIC. This INTC module is
>>>>> actually an PRUSS internal interrupt controller that can take in 64 (on
>>>>> most SoCs) external events/interrupt sources and multiplexing them
>>>>> through two layers of many-to-one events-to-intr channels &
>>>>> intr-channels-to-host interrupts. Couple of the host interrupts go to
>>>>> the PRU cores themselves while the remaining ones come out of the IP to
>>>>> connect to other GICs in the SoC.
>>>>
>>>> If the muxing is static (like set up once at probe) so that while
>>>> the system is running, there is one and one only event mapped to
>>>> the GIC from the component below it, then it is hierarchical.
>>>
>>> This is how it looks.
>>>
>>> [GIC]<---8---[INTC]<---64---[events from peripherals]
>>>
>>> The 8 interrupt lines from INTC to the GIC are 1:1 mapped and fixed
>>> per SoC.  The muxing between 64 inputs to INTC and its 8 outputs are
>>> programmable and might not necessarily be static per boot/probe as
>>> it depends on what firmware is loaded on the PRU.
>>
>> But the point is that at any given time, there are at most 8 out of 64
>> inputs that are used, right? You *never* end-up with two (or more) of
>> these "events" being multiplexed on a single output line.
>>
> 
> Since the INTC's internal logic allows assigning more than one event each outputs,
> at most all 64 events can be assigned to one output or distributed among the 8 outputs.

OK. Do you get individual masking and status bits for each input?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
