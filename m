From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check for it on V6
Date: Tue, 22 Jun 2010 18:00:20 +0100
Message-ID: <20100622170020.GF4371@shareable.org>
References: <20100621133749.24299.36154.stgit@baageli.muru.com> <20100621135120.24299.98499.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:55260 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab0FVRAX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 13:00:23 -0400
Content-Disposition: inline
In-Reply-To: <20100621135120.24299.98499.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren wrote:
>  __kuser_get_tls:				@ 0xffff0fe0
> -
> -#if !defined(CONFIG_HAS_TLS_REG) && !defined(CONFIG_TLS_REG_EMUL)
> -	ldr	r0, [pc, #(16 - 8)]		@ TLS stored at 0xffff0ff0
> -#else
> -	mrc	p15, 0, r0, c13, c0, 3		@ read TLS register
> -#endif
> +	ldr     r0, [pc, #(20 - 8)]		@ software TLS set in 0xffff0ff4?
> +	cmp	r0, #0				@ hardware TLS if flag not set
> +	mrceq	p15, 0, r0, c13, c0, 3		@ read hardware TLS register
> +	ldrne	r0, [pc, #(12 - 8)]		@ software TLS val at 0xffff0ff8
>  	usr_ret	lr
> -
> -	.rep	5
> -	.word	0			@ pad up to __kuser_helper_version
> -	.endr
> +	.word	0				@ non-zero for software TLS
> +	.word	0				@ software TLS value

It'd be nice not to waste instructions checking for HWCAP_TLS on archs
which definitely don't have it.  I guess it doesn't matter elsewhere;
I'd expect this to be a warm path for some programs making extensive
use of TLS (I haven't measured though).

As it's only a single instruction, and the code is in a writable page
already (copied at init), how about just patching the instruction
when ELF_HWCAP is set?

-- Jamie
