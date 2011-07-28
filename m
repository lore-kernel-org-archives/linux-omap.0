From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
Date: Thu, 28 Jul 2011 19:08:11 +0200
Message-ID: <4E31977B.2000809@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com> <4E14B820.6070202@ti.com> <20110707055549.GC15815@atomide.com> <E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE32@staex7mb2.telecom.sna.samsung.com> <20110707121040.GF15815@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42703 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755737Ab1G1RIV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jul 2011 13:08:21 -0400
In-Reply-To: <20110707121040.GF15815@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Martin Fouts <mfouts@sta.samsung.com>, "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 7/7/2011 2:10 PM, Tony Lindgren wrote:
> * Martin Fouts<mfouts@sta.samsung.com>  [110707 10:20]:
>>> Do we really need to do that patching right now to add base 4460
>>> support?
>>
>> It should be done sometime, but I see no need for it to be right
>> now.
>>
>>> If we're just doing a bunch of renames all over the place to add
>>> support for a new processor variant, something is wrong. This is
>>> exactly the kind of "crazy churn" Linus was complaining about. In
>>> this case the crazy churn is "let's rename 4430 to 44XX all over
>>> the place".
>>
>> To me, this is not 'crazy churn', but rather, correcting an earlier
>> oversight. I did not understand Linus to say "never fix a naming
>> oversight", but "don't change names without a good reason."
>
> I think this is crazy churn. It does not fix the problem we have,
> which is "how can we support lots of SoCs in a sane way". It just
> postpones fixing the problem until the next SoC variant comes around.
> And now we already have the exact same problem with both the am3505
> support and 4460 support.

It does help. How can you make the difference between a register that is
4430 only, vs one that is available on both 4430 and 4460?
We need to have 44XX for common stuff and 4430 /4460 for specific one.
Assuming that every 4430 registers will be there on future device,
including OMAP5, is far from obvious.
Having today some OMAP2420 defines used in OMAP3430 code is rather
confusing for my point of view.

> The second problem we have here is "why does adding 4460 support
> depend on a cosmetic clean-up patch". That dependency should not
> exist at all as it seems the 4460 patches should work even without
> this patch.

It does exist only because they both modify the same file and thus might
lead to merge conflict.
It seems to me much better to do the cleanup first before adding new
feature instead of adding features on a crappy file.

Otherwise, there is no real dependency.

>>> To me it's sane to assume that we can have most of 4430 features
>>> on 4460 and don't need to rename 4430 to 44XX for that. Adding
>>> 4460 should be just add few new 4460 defines, then do an
>>> arch_initcall to fixup things between 4430 and 4460.
>>
>> This is a topic upon which mileage varies.  My experience has made
>> we wary of making such assumptions, because too often they have
>> turned out to be wrong.  It is much better to make it clear that
>> the same code supports both than to leave people guessing.  Saying
>> so in the filename is useful. It is also consistent with the naming
>> scheme used in much of the kernel.
>>
>> I don't feel a sense of urgency to correct this, nor a need to hit
>> a merge window, but from my mileage, I would prefer that it be
>> corrected within a reasonable time frame.
>>
>> It seems to me that there is also a bullet to bite here. To achieve
>> the sort of rationalization across the arm architecture that is
>> envisioned, inconsistencies in naming styles between platforms will
>> have to be reconciled and resolved, lest the habit continue.
>
> Sure things should be fixed, but things should be fixed properly.
> Here we are repeating the CHIP_IS flag in hundreds of places where it
> really should be only checked once after SoC is detected. And then
> based on that a SoC specifc list of devices can then be initialized.

For that part, DT will clearly help us a lot. We will have the ability 
to define a common subset (omap44xx.dtsi) or even a superset and then 
disable nodes or add extra nodes in dedicated file for each OMAP 
(omap4430.dts or omap4460.dts).

Regards,
Benoit

