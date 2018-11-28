From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 08/17] soc: ti: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
Date: Wed, 28 Nov 2018 09:46:24 -0600
Message-ID: <421ca9ad-1816-021e-76af-b719f80a5531@lechnology.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-9-git-send-email-rogerq@ti.com>
 <af2f8ce3-923b-aa27-59b2-2ebb848c28c9@lechnology.com>
 <5BFD651C.7020903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5BFD651C.7020903@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/27/18 9:39 AM, Roger Quadros wrote:
> 
> On 26/11/18 23:17, David Lechner wrote:
>> On 11/22/18 5:39 AM, Roger Quadros wrote:
>>> From: Suman Anna <s-anna@ti.com>
>>>
>>> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
>>> interrupt controller (INTC) that can handle various system input
>>> events and post interrupts back to the device-level initiators.
>>> The INTC can support upto 64 input events with individual control
>>> configuration and hardware prioritization. These events are mapped
>>> onto 10 interrupt signals through two levels of many-to-one mapping
>>> support. Different interrupt signals are routed to the individual
>>> PRU cores or to the host CPU.
>>>
>>> The PRUSS INTC platform driver manages this PRUSS interrupt
>>> controller and implements an irqchip driver to provide a Linux
>>> standard way for the PRU client users to enable/disable/ack/
>>> re-trigger a PRUSS system event. The system events to interrupt
>>> channels and host interrupts relies on the mapping configuration
>>> provided through a firmware resource table for now. This will be
>>> revisited and enhanced in the future for a better interface. The
>>> mappings will currently be programmed during the boot/shutdown
>>> of the PRU.
>>
>> Does this mapping table take up space in the PRU IRAM or DRAM? If
>> so, that can be a problem on the AM18xx because it has such limited
>> resources - every byte counts.
> 
> Currently the entire resource table is being placed in DRAM.
> But that is only because the current rpmsg vdev implementation depends on the
> rpmsg channel information and vring buffers to be in DRAM.
> 
> I think the right way is to split up the 2 things.
> i.e. separate out rpmgs channel DRAM allocation from resource table
> and don't copy the resource table to DRAM.
> 
> This way if there is no rpmsg channel in the resource table we won't eat
> any DRAM.
> 
> I'm not sure if there are any bottlenecks. I will only know when I work on it.

Sounds good to me.
