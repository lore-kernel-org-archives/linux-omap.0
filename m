From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH] ARM: Avoid discarding sections that might have SMP_ON_UP fixups
Date: Thu, 10 Feb 2011 18:29:41 +0000
Message-ID: <AANLkTiks_8hXd=7cKN0jNw=1QGcb=5ZyFu1sEFc0G=Px@mail.gmail.com>
References: <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
	<20110125174636.GE17286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101251618230.8580@xanadu.home>
	<AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
	<20110126124452.GB4232@n2100.arm.linux.org.uk>
	<20110126172535.GA15983@arm.com>
	<20110209142211.GA11460@n2100.arm.linux.org.uk>
	<20110210125624.GA3652@n2100.arm.linux.org.uk>
	<AANLkTin3+4pwxQRz1J_1B6dJxJm0_5ou0OWteDFZNbo9@mail.gmail.com>
	<AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com>
	<20110210144617.GD3652@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50333 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1BJS3n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 13:29:43 -0500
Received: by wyb28 with SMTP id 28so1644280wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 10:29:42 -0800 (PST)
In-Reply-To: <20110210144617.GD3652@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 10, 2011 at 2:46 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 10, 2011 at 02:13:13PM +0000, Dave Martin wrote:
>> On Thu, Feb 10, 2011 at 2:11 PM, Dave Martin <dave.martin@linaro.org=
> wrote:
>> > Hi, apologies-- didn't see my mail for a bit.
>> >
>> > I get the problem with this tree and config (which builds with
>> > SMP_ON_UP and THUMB2_KERNEL for omap3/4):
>> >
>> > Tree: git://git.linaro.org/people/dmart/linux-2.6-arm.git
>> > dirty/arm/omap-thumb2+merged
>> > Config: http://people.linaro.org/~dmart/arm_omap-thumb2+v2_config
>
> Thanks for the config.
>
>> Note that this tree contains some extra patches (though I believe
>> nothing is there which should cause the problem), and does not conta=
in
>> everything from rmk/devel -- so it's possible this has been fixed in
>> the meantime or no longer occurs for some other reason...
>
> No need - I now have some modules which contain SMP alternatives, so =
we
> do need to fix the module loader for this, and keep the SMP alternati=
ves
> replacement code around. =A0It's not worth eliminating the code as if=
 we
> include an informative printk() to say why we're refusing to load the
> module, the string would be larger than the code it eliminates. =A0So=
, I
> think we need to merge the patch below to avoid run-time problems.

I thought the problem was not caused by removal of the fixup code, but
rather by the removal of code referenced by fixups?

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
