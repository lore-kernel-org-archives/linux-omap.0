From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Mon, 16 Jan 2012 13:43:03 +0100
Message-ID: <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
References: <WC20120116100344.4204CC@terrafix.co.uk> <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
 <20120116105949.GG16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:44632 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752066Ab2APMn0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jan 2012 07:43:26 -0500
Received: by mail-qy0-f177.google.com with SMTP id o7so1578821qcs.36
        for <linux-omap@vger.kernel.org>; Mon, 16 Jan 2012 04:43:25 -0800 (PST)
In-Reply-To: <20120116105949.GG16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>

On Mon, Jan 16, 2012 at 11:59 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 16, 2012 at 11:18:21AM +0100, Shilimkar, Santosh wrote:
>> + linux-arm, Russell and Catalin
>>
>> On Mon, Jan 16, 2012 at 11:03 AM, Joe Woodward <jw@terrafix.co.uk> w=
rote:
>> > The latest uBoot release (2011.12) disables the L2/outer cache dur=
ing boot on OMAP boards.
>> >
>> > uBoot commit: "armv7: disable L2 cache in cleanup_before_linux()" =
on 6th Dec 2011 by Aneesh V adds the following to
>> > uBootSources/arch/arm/cpu/armv7/cpu.c:cleanup_before_linux():
>> > =A0...
>> > =A0v7_out_cache_disable();
>> >
>> > The commit message implies this change was to make booting reliabl=
e on OMAP4 by disabling L2 cache before jumping to Linux. Sadly
>> > this commit also affects OMAP3-based boards...
>> >
>> > Since switching to uBoot 2011.12 I'm seeing about half the perform=
ance on my GUSMTIX Overo (OMAP3530).
>> >
>> > In the kernel sources there seem to be OMAP4 specific functions fo=
r re-enabling the L2 cache (omap4-common.c:omap_l2_cache_init()),
>> > but none for OMAP3.
>> >
>> > So my question is... do we expect that Linux should be re-enabling=
 the L2/outer cache during boot after uBoot has disabled it on OMAP3?
>> >
>> Yes. Kernel already does enabled L2 on A8 CPU's but OMAP3 needs a
>> secure call and then the patching becomes
>> that much difficult.
>>
>> We need some kind of generic hook in proc*_setup() function where in
>> such secure bits can be turned ON.
>
> You can't have that kind of hook: there is no stack here to call othe=
r
> functions, plus we aren't running with the MMU on at that point so
> only carefully crafted assembly could be used.
>
This code will be in assembly and that's what I have
been using. Not having stack shoudn't be a blocker
and can be work-around in this code. And this API
has to be anyway called before MMU is enabled.

> Why is it soo difficult to issue the secure call?
>
Nothing difficult.
It is just that there is no place today where platform
can call these secure API's Call where ?

> This just proves my point that the lack of consistent secure monitor =
API
> for these kinds of basic service _are_ a big problem, one which ARM L=
td
> should have addressed when they invented this stuff. =A0My view conti=
nues
> to be that the secure monitor API is a total abortion, one which shou=
ld
> never have been allowed to happen.

Am not sure what you mean because secure API
as such isn't a problem. If you mean one standard interface
for all the ARM SOC's then that's something won't be
easy to handled because it is tied up the security architecture
which can vary across SoCs.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
