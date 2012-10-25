From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH V4 1/5] ARM: dts: OMAP: Add timer nodes
Date: Thu, 25 Oct 2012 14:08:21 +0200
Message-ID: <50892BB5.1010000@ti.com>
References: <1350658744-13509-1-git-send-email-jon-hunter@ti.com> <1350658744-13509-2-git-send-email-jon-hunter@ti.com> <50880C19.2090508@ti.com> <79CD15C6BA57404B839C016229A409A83EB4A738@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33747 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab2JYMIg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 08:08:36 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB4A738@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav,

On 10/25/2012 02:05 PM, Hiremath, Vaibhav wrote:
> On Wed, Oct 24, 2012 at 21:11:13, Cousson, Benoit wrote:
>> Hi Jon,
>>
>> On 10/19/2012 04:59 PM, Jon Hunter wrote:
>>> Add the 12 GP timers nodes present in OMAP2.
>>> Add the 12 GP timers nodes present in OMAP3.
>>> Add the 11 GP timers nodes present in OMAP4.
>>> Add the 7 GP timers nodes present in AM33xx.
>>>
>>> Add documentation for timer properties specific to OMAP.
>>>
>>> Thanks to Vaibhav Hiremath for creating the AM33xx timer nodes. I have modified
>>> Vaibhav's original nodes adding information on which timers support a PWM
>>> output.
>>>
>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>
>> I updated the patch to remove the interrupt-parent from the DTS nodes and the documentation, as discussed on the list in the context of OMAP5 DTS for GPIO.
>>
>> If you are OK with that version, I'll push it to Tony along with the others DTS patches.
>>
>> Regards,
>> Benoit
>>
>> ---
>> From 531cc8142ecd6da7929628772c4035dcf7996fef Mon Sep 17 00:00:00 2001
>> From: Jon Hunter <jon-hunter@ti.com>
>> Date: Fri, 19 Oct 2012 09:59:00 -0500
>> Subject: [PATCH] ARM: dts: OMAP: Add timer nodes
>>
>> Add the 12 GP timers nodes present in OMAP2.
>> Add the 12 GP timers nodes present in OMAP3.
>> Add the 11 GP timers nodes present in OMAP4.
>> Add the 7 GP timers nodes present in AM33xx.
>>
>> Add documentation for timer properties specific to OMAP.
>>
>> Thanks to Vaibhav Hiremath for creating the AM33xx timer nodes. I have modified
>> Vaibhav's original nodes adding information on which timers support a PWM
>> output.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> [b-cousson@ti.com: Remove the interrupt-parent from nodes]
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> ---
>>  .../devicetree/bindings/arm/omap/timer.txt         |   31 +++++++
>>  arch/arm/boot/dts/am33xx.dtsi                      |   54 +++++++++++
>>  arch/arm/boot/dts/omap2.dtsi                       |   85 +++++++++++++++++
>>  arch/arm/boot/dts/omap2420.dtsi                    |    8 ++
>>  arch/arm/boot/dts/omap2430.dtsi                    |    8 ++
>>  arch/arm/boot/dts/omap3.dtsi                       |   95 ++++++++++++++++++++
>>  arch/arm/boot/dts/omap4.dtsi                       |   86 ++++++++++++++++++
>>  7 files changed, 367 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt
>>
> 
> Benoit,
> 
> I have boot tested this on BeagleBone, so,
> 
> Tested-By: Vaibhav Hiremath <hvaibhav@ti.com>

Excellent, thanks.

Regards,
Benoit

