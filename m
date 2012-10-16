From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RESEND PATCH 2/2] ARM: kexec: Check segment memory addresses
Date: Tue, 16 Oct 2012 18:16:01 +0100
Message-ID: <20121016171601.GL23979@mudshark.cambridge.arm.com>
References: <1348157018-31059-1-git-send-email-will.deacon@arm.com>
 <1348157018-31059-2-git-send-email-will.deacon@arm.com>
 <20121016161020.GA1613@blackmetal.musicnaut.iki.fi>
 <20121016163226.GG23979@mudshark.cambridge.arm.com>
 <20121016170900.GB1613@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50280 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753976Ab2JPRQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Oct 2012 13:16:16 -0400
Content-Disposition: inline
In-Reply-To: <20121016170900.GB1613@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Oct 16, 2012 at 06:09:00PM +0100, Aaro Koskinen wrote:
> On Tue, Oct 16, 2012 at 05:32:26PM +0100, Will Deacon wrote:
> > Interesting, it sounds like kexec thinks that you don't have contiguous
> > memory from 0x80008000 to 0x803ad000. Can you provide some more information
> > about your physical memory map please?
> 
> Well, I think it's because the patch is wrong. Shouldn't it be:
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index e29c333..a80192e 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -47,7 +47,7 @@ int machine_kexec_prepare(struct kimage *image)
>  
>  		err = memblock_is_region_memory(current_segment->mem,
>  						current_segment->memsz);
> -		if (err)
> +		if (!err)
>  			return - EINVAL;
>  
>  		err = get_user(header, (__be32*)current_segment->buf);

Oops, that's a howler! Thanks for spotting it. We should probably reflow the
code a bit because !err sounds like everything should be ok.

Fancy reworking the patch or do you want me to take care of this?

Cheers,

Will
