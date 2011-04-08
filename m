From: Li Li <eggonlea@gmail.com>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
 check for it on V6
Date: Fri, 8 Apr 2011 22:40:12 +0800
Message-ID: <BANLkTimEzTk2CCVRZMcR_jmWJGkvm1vvdQ@mail.gmail.com>
References: <20100630131737.GF2822@atomide.com>
	<alpine.LFD.2.00.1006301011520.24097@xanadu.home>
	<20100701092510.GH2822@atomide.com>
	<20100701174051.GA8786@shareable.org>
	<alpine.LFD.2.00.1007012226170.26524@xanadu.home>
	<20100702103744.GJ6632@atomide.com>
	<20100705135526.GF15951@atomide.com>
	<BANLkTim4TTf3KXGYzjcvQ2n-hNbdSQM1eg@mail.gmail.com>
	<alpine.LFD.2.00.1104080911520.28032@xanadu.home>
	<BANLkTinEnn1C8_mKtL6P2YXdPSt1eaUzKA@mail.gmail.com>
	<20110408143541.GU26912@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56706 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756889Ab1DHOkN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2011 10:40:13 -0400
Received: by gxk21 with SMTP id 21so1449312gxk.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Apr 2011 07:40:13 -0700 (PDT)
In-Reply-To: <20110408143541.GU26912@shareable.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Ah, I see. That's why I saw abnormal behavior when I enabled TLS EMU
on an ARMv7 SMP SOC. Many thanks! :)

On Fri, Apr 8, 2011 at 10:35 PM, Jamie Lokier <jamie@shareable.org> wro=
te:
> Li Li wrote:
>> Nicolas,
>>
>> Thanks for the explanation. :)
>>
>> I noticed what you mentioned. Actually, Kconfig says TLS EMU might b=
e
>> used in some "old" (e.g. pre-armv6) SMP platforms without TLS
>> register. In such a case, could we still ensure it's SMP safe by a
>> single ldr?
>
> In that case, the hardware TLS 'mcr' is used, which traps and is
> emulated by the undefined instruction handler. =A0It's not fast but
> presumably those platforms don't really matter.
>
> See CONFIG_TLS_REG_EMUL in arch/arm/kernel/traps.c, and 'tls_emu'.
>
> 'tls_emu' is a constant, so if a kernel built for TLS emulation is ru=
n
> on something which has the TLS register, it will not work properly.
>
> -- JAmie
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
