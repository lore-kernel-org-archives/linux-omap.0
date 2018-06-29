From: David Lechner <david@lechnology.com>
Subject: Re: New remoteproc driver for TI PRU
Date: Fri, 29 Jun 2018 12:44:12 -0500
Message-ID: <8fc18d40-72f5-9215-26f0-1492e3a6c0e7@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
 <e0a883af-8228-5b06-3186-f57d8f898aaa@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e0a883af-8228-5b06-3186-f57d8f898aaa@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, "Anna, Suman" <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On 06/29/2018 04:58 AM, Roger Quadros wrote:
> +Suman & Tero
> 
> Hi David,
> 
> On 24/06/18 00:08, David Lechner wrote:
>>
>> Date: Sat, 23 Jun 2018 15:43:59 -0500
>> Subject: [PATCH 0/8] New remoteproc driver for TI PRU
>>
>> This series adds a new remoteproc driver for the TI Programmable Runtime Unit
>> (PRU) that is present in some TI Sitara processors. This code has been tested
>> working on AM1808 (LEGO MINDSTORMS EV3) and AM3358 (BeagleBone Green).
> 
> This is great. We have been working on something similar and I think it would
> be great if we can collaborate to get all our needs addressed.

Yes, I have used the PRU with the TI kernel on BeagleBone so I've seen the TI
implementation. My primary interest is in the AM1808, which has a far simpler
PRU than other SoCs. So, I was hoping I could get away with just implementing
the basic stuff that I need and let TI add the more complex stuff later.

> 
> Our primary requirement is that it should be possible for a user (e.g. kernel driver) to
> - request a specific PRU core load a specific firmware blob and boot/stop the PRU.

For this, I was thinking of suggesting a generic remoteproc provider/consumer
binding that is similar to other subsystems. For example:

Provider node has:

	#remoteproc-cells = <1>;

And consumer has:

	remoteprocs = <&pruss 0>, <&pruss 1>;
	remoteproc-names = "pru0", "pru1";

The consumer device would be responsible for determining the firmware file
and for calling the rproc boot function.


> - configure INTC interrupt mapping based on either resource table or DT
> - use request_irq to request and use an interrupt.

I didn't consider creating a new interrupt controller in device tree, but
that makes sense. I will have to look into it some more.


> - request access to DRAM/SRAM

Can the existing device tree bindings for reserved-memory be used for this?
I would expect the consumer nodes to use this and not the PRUSS provider node.


> - configure gpimode/miirt/xfr (CFG space)

I have no idea what this stuff is. :-)

(This is what I was referring to when I said I was hoping that someone
else could add more later).
