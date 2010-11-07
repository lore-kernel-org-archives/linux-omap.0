From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/6] omap: iommu: remove redundant clock usage
Date: Sun, 7 Nov 2010 09:55:25 -0600
Message-ID: <AANLkTik3Qkf5cyYq-sP9gq0sG8fnYGHq7zvD7VuB-Vxy@mail.gmail.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-2-git-send-email-omar.ramirez@ti.com>
	<4CD5A846.4020607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44119 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753309Ab0KGPz0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 10:55:26 -0500
Received: by mail-iw0-f175.google.com with SMTP id 42so5029381iwn.6
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 07:55:25 -0800 (PST)
In-Reply-To: <4CD5A846.4020607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Nov 6, 2010 at 2:11 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
>>
>> iommu driver is meant to provide control of mmu hardware blocks
>
> A dot is missing here, and a capital letter should follow.

Actually it is a comma, it is meant to be part of the same paragraph.

>
>> its current users (MMUs) are part of larger subsystems and do not
>> have a dedicated clock as the one they use is shared with the
>> entire subsystem, it doesn't make sense to enable/disable on each
>> register read/write operation as the driver using its interface
>> should also be handling the same clock.
>>
>> iommu should only enable/disable the clock on mmu request/free from
>> the driver wanting to use it.
>
> Mmm, I'm not necessarily convinced by that explanation.
> If in a next revision, we change the clock partitioning and provide a
> dedicated clock for the mmu, it will not work anymore.
> I don't thing you should assume anything about the current partitioning.

HW wise, only one clock feeds the mmu, iva2_ck is used to generate
three clocks but this inside the IVA2 module. I'm assuming omap4 dsp
is the same.

ISP also depends on cam_ick (among others), and mmu is inside ISP module afaik.

>From what I have checked on omap4 TRM it is the same, mmu doesn't have
a direct clock, it relies on the main ipu clock to function, but it is
my first glance to omap4 and I might be wrong.

> That being said, when you will change that code to switch to runtime PM, you
> will end up managing the module state in the ISR context.

Mainly this patch was sent on my laziness to add device enable/disable
calls on all the parts the code is using clk disable/enable, given
that they are not really needed.

Regards,

Omar
