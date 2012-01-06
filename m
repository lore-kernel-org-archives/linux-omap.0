From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 0/5] ARM: OMAP2+: Interrupt controllers adaptation
 to DT
Date: Fri, 06 Jan 2012 12:56:04 -0600
Message-ID: <4F0743C4.7000201@gmail.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com> <4EF44DFF.4090300@ti.com> <4F07239D.8000607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40383 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425Ab2AFS4H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jan 2012 13:56:07 -0500
Received: by yenm11 with SMTP id m11so806111yen.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Jan 2012 10:56:07 -0800 (PST)
In-Reply-To: <4F07239D.8000607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/06/2012 10:38 AM, Cousson, Benoit wrote:
> Hi Rob/Grant,
> 
> Gentle ping on that series too. This should the last one:-)
> 
Sorry about that. For the series:

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> Thanks,
> Benoit
> 
> On 12/23/2011 10:46 AM, Cousson, Benoit wrote:
>> Hi Rob,
>>
>> Are you OK with that update?
>>
>> Thanks,
>> Benoit
>>
>> On 12/20/2011 2:39 PM, Benoit Cousson wrote:
>>> Hi Tony and Rob,
>>>
>>> Here is the series to take advantage of the new DT interrupt init
>>> mechanism.
>>> Thanks to Marc's CONFIG_MULTI_IRQ_HANDLER series, OMAP4 just has to
>>> use the
>>> default GIC binding and does not need some OMAP specific hacks anymore.
>>> OMAP2 and 3 are using a simple interrupt controller that can thus expose
>>> a simpler binding.
>>>
>>> This update, compared to v1 [1], is introducing the IRQ domain for the
>>> OMAP2&3 INTC by default for both DT and none-DT build.
>>> Please note that in the near future that code can even be simplier
>>> with the
>>> introduction of the domain support inside generic irq chip.
>>>
>>> This series is based on lo/dt branch to get the needed cleanup and
>>> fixes for
>>> OMAP.
>>>
>>> The series is available here for reference:
>>> git://gitorious.org/omap-pm/linux.git for_3.3/2_dt_irq
>>>
>>> Regards,
>>> Benoit
>>>
>>> [1] http://www.spinics.net/lists/linux-omap/msg61152.html
>>>
>>>
>>> Benoit Cousson (5):
>>> arm/dts: OMAP4: Update DTS file with new GIC bindings
>>> ARM: OMAP2/3: intc: Add irqdomain support
>>> ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
>>> arm/dts: OMAP3: Add interrupt-controller bindings for INTC
>>> ARM: OMAP2+: board-generic: Use of_irq_init API
>>>
>>> .../devicetree/bindings/arm/omap/intc.txt | 27 +++++++++++
>>> arch/arm/boot/dts/omap3.dtsi | 6 ++-
>>> arch/arm/boot/dts/omap4.dtsi | 3 +-
>>> arch/arm/mach-omap2/board-generic.c | 30 +++++++------
>>> arch/arm/mach-omap2/common.h | 10 ++++
>>> arch/arm/mach-omap2/irq.c | 48 ++++++++++++++++++--
>>> 6 files changed, 103 insertions(+), 21 deletions(-)
>>> create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt
>>>
>>
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

