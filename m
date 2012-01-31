From: Aneesh V <aneesh@ti.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
 by uBoot)?
Date: Tue, 31 Jan 2012 10:51:50 +0530
Message-ID: <4F277A6E.9070107@ti.com>
References: <20120116131329.GA928@n2100.arm.linux.org.uk> <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com> <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com> <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com> <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com> <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:43236 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751754Ab2AaFV6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 00:21:58 -0500
Received: by dadi2 with SMTP id i2so4187229dad.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 21:21:57 -0800 (PST)
In-Reply-To: <20120127173029.GA3281@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Catalin,

On Friday 27 January 2012 11:00 PM, Catalin Marinas wrote:
> On Fri, Jan 20, 2012 at 08:57:11AM +0000, Joe Woodward wrote:
>>> So I re-iterate that we need to have solution to this problem.
>>
>> ... I don't want to be a pain, but it seems to me that this dicussion
>> didn't reach a full conclussion?
>
> Probably not, because it depends on many variables. See below my take on
> this.
>
>> I think it was left with the open options being:
>> 1) Leave the L2/outer cache enabled in the bootloader (not ideal and
>> may cause problems with future devices)
>
> This depends on whether the L2 is inner or outer:
>
> L2 inner - leave it enabled in the boot loader
> L2 outer - leave it disabled in the boot loader
>
>> 2) Turn the L2/outer cache on for OMAP3 later in the kernel boot when
>> the device is known
>
> Same as above:
>
> L2 inner - don't do anything, it gets used when SCTLR.M is enabled
> L2 outer - enabled at boot time via the platform code (later, after MMU
> 	was enabled).
>

What is the reasoning behind this recommendation? Why the distinction
between L2 being inner or outer. I don't see anything to this effect in
the Cortex-A8 TRM? In fact the only recommendation I could find(section
8.3) is asking to set L2EN to 1 before setting C bit to 1 irrespective
of inner/outer?

br,
Aneesh
