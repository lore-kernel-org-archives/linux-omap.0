From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next,
 working on 3.2
Date: Fri, 5 Oct 2012 09:32:07 +0200
Message-ID: <CAAwP0s1+_GT=TtVKg8ARtfqDYm_AZ-D34KG_j3SLWz0yzZKJtQ@mail.gmail.com>
References: <20120504155255.140b4e3f@skate> <87397fewso.fsf@ti.com>
 <20120504175124.GI5613@atomide.com> <878vh78q7b.fsf@ti.com>
 <20121004180747.3b342904@skate> <87vcequpf7.fsf@deeprootsystems.com>
 <20121004221118.4316181d@skate> <CAKQ2WVp71=ULs_yK7Tkuo=8F4hATq0YCQ6RtV0ziJQQmnrib_g@mail.gmail.com>
 <20121004225704.0c08c862@skate> <87wqz5u97g.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56057 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab2JEHc2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 03:32:28 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1399272obb.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Oct 2012 00:32:28 -0700 (PDT)
In-Reply-To: <87wqz5u97g.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@iseebcn.com>, linux-omap@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>

On Fri, Oct 5, 2012 at 1:08 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:
>
>> On Thu, 4 Oct 2012 22:30:58 +0200, Enric Balletb=C3=B2 i Serra wrote=
:
>>
>>> I recently tested kernel 3.6-rc5 and worked for me. Let me check to=
morrow
>>> kernel 3.6. Which u-boot version are you using?
>>
>> 2011.12 + a few patches to make the NAND of the IGEPv2 rev6 work. Le=
t
>> me try to build a recent U-Boot (which now includes the SPL for the
>> IGEP) and see if it improves the situation.
>>
>> However, I believe that the rule is that the kernel shouldn't depend
>> too much on initialization done by the bootloader, so it still seems
>> like an issue to me.
>
> Correct, if the kernel is relying on any bootloader assumptions, it
> should be considered a kernel bug.
>
> We'd really like to remove any bootloader assumptions from the kernel=
=2E
> This will allow the kernel to be bootloader independent, and make it
> easier to support reboot via kexec.
>
> Kevin
>

Hi Thomas,

As Enric said, u-boot has SPL and NAND support for IGEP since
v2012.10-rc1. I just tried kernel a 3.6 with u-boot v2012.10-rc2 and
it works for me.

But I agree that the kernel shouldn't do any assumptions about the
bootloader setting correctly the omap mux. Could you please share your
bootloader that makes the kernel to fail (or your IGEP NAND patches on
top of u-boot U-boot 2011.12) so I can reproduce the issue and try to
fix it?

Thanks a lot and best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
