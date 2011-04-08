From: Li Li <eggonlea@gmail.com>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
 check for it on V6
Date: Fri, 8 Apr 2011 21:35:48 +0800
Message-ID: <BANLkTinEnn1C8_mKtL6P2YXdPSt1eaUzKA@mail.gmail.com>
References: <20100623133636.GC7058@shareable.org>
	<20100629141836.GM2822@atomide.com>
	<alpine.LFD.2.00.1006291355520.24097@xanadu.home>
	<20100630110828.GZ2822@atomide.com>
	<20100630131737.GF2822@atomide.com>
	<alpine.LFD.2.00.1006301011520.24097@xanadu.home>
	<20100701092510.GH2822@atomide.com>
	<20100701174051.GA8786@shareable.org>
	<alpine.LFD.2.00.1007012226170.26524@xanadu.home>
	<20100702103744.GJ6632@atomide.com>
	<20100705135526.GF15951@atomide.com>
	<BANLkTim4TTf3KXGYzjcvQ2n-hNbdSQM1eg@mail.gmail.com>
	<alpine.LFD.2.00.1104080911520.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38390 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824Ab1DHNft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2011 09:35:49 -0400
Received: by yxs7 with SMTP id 7so1426052yxs.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Apr 2011 06:35:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1104080911520.28032@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Jamie Lokier <jamie@shareable.org>, linux-arm-kernel@lists.infradead.org

Nicolas,

Thanks for the explanation. :)

I noticed what you mentioned. Actually, Kconfig says TLS EMU might be
used in some "old" (e.g. pre-armv6) SMP platforms without TLS
register. In such a case, could we still ensure it's SMP safe by a
single ldr?

Thanks,
Lea

On Fri, Apr 8, 2011 at 9:19 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 8 Apr 2011, Li Li wrote:
>
>> Dears,
>>
>> I cannot understand how TLS EMU ensure it's SMP safe, because get_tl=
s
>> helper (at 0xffff0fe0) just read the value from 0xffff0ff0. But all
>> SMP cores should have the exact same mapping to the vectors page (at
>> 0xffff0000). So various threads running on different SMP cores at th=
e
>> same time would get the same emulated TLS value (instead of thread
>> specific value set via set_tls). Could anybody explain this a little
>> bit?
>
> On SMP the hardware TLS register is always available, therefore the T=
LS
> value is not stored at 0xffff0ff0. =A0The code actually installed at
> 0xffff0fe0 is modified at boot time by kuser_get_tls_init to select
> either the ldr or the mrc instruction to retrieve the TLS value.
>
>
> Nicolas
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
