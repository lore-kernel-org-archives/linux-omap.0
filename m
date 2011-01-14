From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Fri, 14 Jan 2011 17:34:00 +0000
Message-ID: <20110114173400.GB22505@n2100.arm.linux.org.uk>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com> <20110114155806.GA22505@n2100.arm.linux.org.uk> <AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33132 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757625Ab1ANReQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 12:34:16 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Fri, Jan 14, 2011 at 05:13:01PM +0100, Jean Pihet wrote:
> Is the name 'omap_sram_push' wrong then?
> What about the following?
> @@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned long size)
> 
>        omap_sram_ceil -= size;
>        omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
>  -     memcpy((void *)omap_sram_ceil, start, size);
>  -     flush_icache_range((unsigned long)omap_sram_ceil,
>  -             (unsigned long)(omap_sram_ceil + size));
> 
>  -     return (void *)omap_sram_ceil;
>  +    return fncpy((void *)omap_sram_ceil, start, size);

It's more correct, but still missing out on the type safety which we've
tried to provide with fncpy.  Note also the other issue with Dave Martin
has raised though - this isn't ready for merging yet.
