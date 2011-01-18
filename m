From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 01/14] ARM: bitops: ensure set/clear/change bitops take a
 word-aligned pointer
Date: Tue, 18 Jan 2011 15:11:10 +0000
Message-ID: <AANLkTim+0nimacapGBuestYUkC4KuShSQdcHFCFa7O9b@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peudk-0003SJ-Aj@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1101180043140.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65397 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab1ARPLL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 10:11:11 -0500
Received: by iwn9 with SMTP id 9so5822426iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 18 Jan 2011 07:11:10 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101180043140.8580@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 18 January 2011 06:00, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:
>
>> Add additional instructions to our assembly bitops functions to ensu=
re
>> that they only operate on word-aligned pointers. =C2=A0This will be =
necessary
>> when we switch these operations to use the word-based exclusive
>> operations.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> This breaks the Thumb2 kernel build:
>
> =C2=A0AS =C2=A0 =C2=A0 =C2=A0arch/arm/lib/changebit.o
> arch/arm/lib/changebit.S: Assembler messages:
> arch/arm/lib/changebit.S:16: Error: Thumb does not support negative r=
egister indexing -- `strne r1,[r1,-r1]'
>
> I also wonder what happens with a misaligned ldrex/strex... Does the
> alignment trap get invoked?

According to the ARM ARM, unaligned ldrex/strex should generate an
alignment fault on ARMv6 (with SCTLR.U bit set) and ARMv7.

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
