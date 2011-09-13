From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 0/5 v8] mfd: omap: usb: Runtime PM support for EHCI and
 OHCI drivers
Date: Tue, 13 Sep 2011 20:12:53 +0530
Message-ID: <CAP05o4+0-=c-HAn=32kvNNFDiy4L=qhmbBdLF3OiQJrh2vuOYw@mail.gmail.com>
References: <1314255697-15411-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KGqbX6KzZjjpXEfyNk5RzYkgKRkn+P9GYvxLA9pgLOxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:49886 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754588Ab1IMOm5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Sep 2011 10:42:57 -0400
In-Reply-To: <CAP05o4KGqbX6KzZjjpXEfyNk5RzYkgKRkn+P9GYvxLA9pgLOxg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Sep 9, 2011 at 10:02 PM, Munegowda, Keshava
<keshava_mgowda@ti.com> wrote:
> On Thu, Aug 25, 2011 at 12:31 PM, Keshava Munegowda
> <keshava_mgowda@ti.com> wrote:
>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>
>> The Hwmod structures and Runtime PM features are implemented
>> For EHCI and OHCI drivers of OMAP3 and OMAP4.
>> The global suspend/resume of EHCI and OHCI
>> is validated on OMAP3430 sdp board with these patches.
>>
>> these patches are rebased to kevin's pm branch and
>> usbhs latest mainline kernel patches
>>
>> TODO:
>> =A0 - Adding pad configurations to Hwmods
>> =A0 - Aggressive clock cutting in usb bus suspends
>> =A0 - Remote Wakeup implementation using irq-chaining
>>
>>
>> Benoit Cousson (1):
>> =A0arm: omap: usb: ehci and ohci hwmod structures for omap4
>>
>> Keshava Munegowda (4):
>> =A0arm: omap: usb: ehci and ohci hwmod structures for omap3
>> =A0arm: omap: usb: register hwmods of usbhs
>> =A0arm: omap: usb: device name change for the clk names of usbhs
>> =A0mfd: omap: usb: Runtime PM support
>>
>> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 | =A0 26 +-
>> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0 | =A0 10 +-
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0281 +++++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0247 ++++++++++
>> =A0arch/arm/mach-omap2/usb-host.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0114 +=
+---
>> =A0arch/arm/plat-omap/include/plat/usb.h =A0 =A0 =A0| =A0 =A03 -
>> =A0drivers/mfd/omap-usb-host.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A07=
33 +++++++++++-----------------
>> =A0drivers/usb/host/ehci-omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 17=
 +-
>> =A0drivers/usb/host/ohci-omap3.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 18=
 +-
>> =A09 files changed, 891 insertions(+), 558 deletions(-)
>>
>>
>
> Hi Benoit Cousson
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 please ack this series; I am wait=
ing for your ack
> to lineup this USBHS runtime pm adaptions.
>
> regards
> keshava

Hi Benoit Cousson
               please ack this series; kevin has already given review
by for the Runtime pm adaptations;
balbi has recommended for you ack ; so,I request please give you ack
by so that sameo can take these
patches from my git tree : git://gitorious.org/~kmg/mirrors/kmg-usbhs-p=
m.git

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
