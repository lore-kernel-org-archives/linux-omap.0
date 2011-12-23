From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 0/5] ARM: OMAP2+: Interrupt controllers adaptation
 to DT
Date: Fri, 23 Dec 2011 10:46:39 +0100
Message-ID: <4EF44DFF.4090300@ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55656 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753766Ab1LWJqx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Dec 2011 04:46:53 -0500
In-Reply-To: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi Rob,

Are you OK with that update?

Thanks,
Benoit

On 12/20/2011 2:39 PM, Benoit Cousson wrote:
> Hi Tony and Rob,
>
> Here is the series to take advantage of the new DT interrupt init mechanism.
> Thanks to Marc's CONFIG_MULTI_IRQ_HANDLER series, OMAP4 just has to use the
> default GIC binding and does not need some OMAP specific hacks anymore.
> OMAP2 and 3 are using a simple interrupt controller that can thus expose
> a simpler binding.
>
> This update, compared to v1 [1], is introducing the IRQ domain for the
> OMAP2&3 INTC by default for both DT and none-DT build.
> Please note that in the near future that code can even be simplier with the
> introduction of the domain support inside generic irq chip.
>
> This series is based on lo/dt branch to get the needed cleanup and fixes for
> OMAP.
>
> The series is available here for reference:
> git://gitorious.org/omap-pm/linux.git for_3.3/2_dt_irq
>
> Regards,
> Benoit
>
> [1] http://www.spinics.net/lists/linux-omap/msg61152.html
>
>
> Benoit Cousson (5):
>    arm/dts: OMAP4: Update DTS file with new GIC bindings
>    ARM: OMAP2/3: intc: Add irqdomain support
>    ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
>    arm/dts: OMAP3: Add interrupt-controller bindings for INTC
>    ARM: OMAP2+: board-generic: Use of_irq_init API
>
>   .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++++
>   arch/arm/boot/dts/omap3.dtsi                       |    6 ++-
>   arch/arm/boot/dts/omap4.dtsi                       |    3 +-
>   arch/arm/mach-omap2/board-generic.c                |   30 +++++++------
>   arch/arm/mach-omap2/common.h                       |   10 ++++
>   arch/arm/mach-omap2/irq.c                          |   48 ++++++++++++++++++--
>   6 files changed, 103 insertions(+), 21 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt
>

