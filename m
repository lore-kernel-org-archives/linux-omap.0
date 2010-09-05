From: =?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?= <m.nazarewicz@samsung.com>
Subject: Re: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init
 testing
Date: Sun, 05 Sep 2010 03:53:55 +0200
Message-ID: <op.vijd75a97p4s8u@localhost>
References: <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com> <20100902161846.GK11597@atomide.com>
 <20100902170830.GW26319@n2100.arm.linux.org.uk>
 <20100902174244.GU11597@atomide.com> <20100902192659.GW11597@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:31876 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab0IEByj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Sep 2010 21:54:39 -0400
Received: from eu_spt1 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0L89003IT3YW8320@mailout4.w1.samsung.com> for
 linux-omap@vger.kernel.org; Sun, 05 Sep 2010 02:54:36 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0L890007F3YVWI@spt1.w1.samsung.com> for
 linux-omap@vger.kernel.org; Sun, 05 Sep 2010 02:54:31 +0100 (BST)
In-reply-to: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bryan Wu <bryan.wu@canonical.com>

On Fri, 03 Sep 2010 14:12:22 +0200, Shilimkar, Santosh <santosh.shilimk=
ar@ti.com> wrote:
> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/s=
mp_plat.h
> index 8db3512..82bc488 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -39,4 +39,11 @@ static inline int cache_ops_need_broadcast(void)
>  #define UP(instr...)	_str(instr)
>  #endif
> +static inline int smp_cpu(void)
> +{
> +        u32 mpidr;
> +        asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=3Dr" (mpidr));
> +        return (mpidr >> 31) ? !(mpidr >> 30) : 0;

This always returns 0.  If (mpdir >> 31) is true then (mpidr >> 30) is
either 2 or 3.  Did you mean:

+	return (mpidr >> 30) =3D=3D 2;

> +}
> +

--=20
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=3D./ `o
| Computer Science,  Micha=C5=82 "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
