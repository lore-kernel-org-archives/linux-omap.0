From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap changes
Date: Fri, 13 Jan 2012 19:12:31 +0200
Message-ID: <CAMP44s2XNnOAiDCf1mbtpRV5MAk4LLFdgBpuOQg=pc9aakiDEQ@mail.gmail.com>
References: <20120112184256.GA2287@atomide.com>
	<alpine.LFD.2.02.1201121441580.2722@xanadu.home>
	<alpine.LFD.2.02.1201121447270.2722@xanadu.home>
	<20120112195951.GB2287@atomide.com>
	<20120113140520.GE16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57278 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752998Ab2AMRMd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 12:12:33 -0500
Received: by lago2 with SMTP id o2so396598lag.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 09:12:31 -0800 (PST)
In-Reply-To: <20120113140520.GE16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On Fri, Jan 13, 2012 at 4:05 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> +phys_addr_t arm_memblock_steal(phys_addr_t size, phys_addr_t align)
> +{
> + =C2=A0 =C2=A0 =C2=A0 phys_addr_t phys;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!arm_memblock_steal_permitted)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 panic("arm_membloc=
k_steal used in an unsafe manner\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 phys =3D memblock_alloc(size, align);
> + =C2=A0 =C2=A0 =C2=A0 memblock_free(phys, size);
> + =C2=A0 =C2=A0 =C2=A0 memblock_remove(phys, size);
> +
> + =C2=A0 =C2=A0 =C2=A0 return phys;
> +}

Excellent! I think I suggested a function like that at some point.

But I wonder about the 'align' argument. I think most people just
copy-pasted SZ_1M, although I think originally you suggested SZ_2M,
maybe it would make sense to align 'align' to SZ_1M, or set SZ_1M if
it's 0 for convenience.

Also, what about people that need memblock_alloc_base? AFAIK OMAP 3
secure ram needs to be below certain area (I wonder why the current
code is not handling that).

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
