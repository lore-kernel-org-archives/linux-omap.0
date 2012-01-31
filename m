From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Tue, 31 Jan 2012 07:31:10 +0000
Message-ID: <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com>
References: <20120116131329.GA928@n2100.arm.linux.org.uk> <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com> <4F277A6E.9070107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:54994 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab2AaHbb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 02:31:31 -0500
Received: by qafk1 with SMTP id k1so2280561qaf.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 23:31:30 -0800 (PST)
In-Reply-To: <4F277A6E.9070107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On 31 January 2012 05:21, Aneesh V <aneesh@ti.com> wrote:
> On Friday 27 January 2012 11:00 PM, Catalin Marinas wrote:
>> On Fri, Jan 20, 2012 at 08:57:11AM +0000, Joe Woodward wrote:
>>>> So I re-iterate that we need to have solution to this problem.
>>>
>>> ... I don't want to be a pain, but it seems to me that this dicussi=
on
>>> didn't reach a full conclussion?
>>
>> Probably not, because it depends on many variables. See below my tak=
e on
>> this.
>>
>>> I think it was left with the open options being:
>>> 1) Leave the L2/outer cache enabled in the bootloader (not ideal an=
d
>>> may cause problems with future devices)
>>
>> This depends on whether the L2 is inner or outer:
>>
>> L2 inner - leave it enabled in the boot loader
>> L2 outer - leave it disabled in the boot loader
>>
>>> 2) Turn the L2/outer cache on for OMAP3 later in the kernel boot wh=
en
>>> the device is known
>>
>> Same as above:
>>
>> L2 inner - don't do anything, it gets used when SCTLR.M is enabled
>> L2 outer - enabled at boot time via the platform code (later, after =
MMU
>> =A0 =A0 =A0 =A0was enabled).
>
> What is the reasoning behind this recommendation? Why the distinction
> between L2 being inner or outer. I don't see anything to this effect =
in
> the Cortex-A8 TRM? In fact the only recommendation I could find(secti=
on
> 8.3) is asking to set L2EN to 1 before setting C bit to 1 irrespectiv=
e
> of inner/outer?

Actually you have a good point. I was thinking about outer caches like
PL310 or L220 that Linux enables later during platform initialisation.
They could be left enabled or disabled at boot time but they must be
cleaned/invalidated (you would need to flush after disabling just to
make sure there are no further lines fetched; alternatively, there
shouldn't be any cacheable mappings).

So I would say in the context of A8, just leave the L2 enabled in the
boot loader. As long as the MMU is disabled, it won't be used. The
alternative is to enable L2 slightly later in Linux in the platform
code to avoid SoC-dependent code in proc-v7.S.

So in summary, either option is possible. You could take the approach
of the cache-l2x0.c - check whether it is already enabled and, if not,
issue an SMC from the platform code to enable the L2 cache.

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
