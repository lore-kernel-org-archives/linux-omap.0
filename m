From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next, working on 3.2
Date: Thu, 04 Oct 2012 16:08:19 -0700
Message-ID: <87wqz5u97g.fsf@deeprootsystems.com>
References: <20120504155255.140b4e3f@skate> <87397fewso.fsf@ti.com>
	<20120504175124.GI5613@atomide.com> <878vh78q7b.fsf@ti.com>
	<20121004180747.3b342904@skate> <87vcequpf7.fsf@deeprootsystems.com>
	<20121004221118.4316181d@skate>
	<CAKQ2WVp71=ULs_yK7Tkuo=8F4hATq0YCQ6RtV0ziJQQmnrib_g@mail.gmail.com>
	<20121004225704.0c08c862@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50304 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab2JDXIQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 19:08:16 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so989127pad.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 16:08:16 -0700 (PDT)
In-Reply-To: <20121004225704.0c08c862@skate> (Thomas Petazzoni's message of
	"Thu, 4 Oct 2012 22:57:04 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Enric =?utf-8?Q?Balletb=C3=B2?= i Serra <eballetbo@iseebcn.com>, linux-omap@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Gregory =?utf-8?Q?Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> On Thu, 4 Oct 2012 22:30:58 +0200, Enric Balletb=C3=B2 i Serra wrote:
>
>> I recently tested kernel 3.6-rc5 and worked for me. Let me check tom=
orrow
>> kernel 3.6. Which u-boot version are you using?
>
> 2011.12 + a few patches to make the NAND of the IGEPv2 rev6 work. Let
> me try to build a recent U-Boot (which now includes the SPL for the
> IGEP) and see if it improves the situation.
>
> However, I believe that the rule is that the kernel shouldn't depend
> too much on initialization done by the bootloader, so it still seems
> like an issue to me.

Correct, if the kernel is relying on any bootloader assumptions, it
should be considered a kernel bug. =20

We'd really like to remove any bootloader assumptions from the kernel.
This will allow the kernel to be bootloader independent, and make it
easier to support reboot via kexec.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
