From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check for it on V6
Date: Thu, 1 Jul 2010 18:40:51 +0100
Message-ID: <20100701174051.GA8786@shareable.org>
References: <20100621135120.24299.98499.stgit@baageli.muru.com> <20100622170020.GF4371@shareable.org> <20100623073912.GA12255@atomide.com> <20100623133636.GC7058@shareable.org> <20100629141836.GM2822@atomide.com> <alpine.LFD.2.00.1006291355520.24097@xanadu.home> <20100630110828.GZ2822@atomide.com> <20100630131737.GF2822@atomide.com> <alpine.LFD.2.00.1006301011520.24097@xanadu.home> <20100701092510.GH2822@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:38445 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab0GARkx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 13:40:53 -0400
Content-Disposition: inline
In-Reply-To: <20100701092510.GH2822@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren wrote:
> +static void __init kuser_get_tls_init(unsigned long vectors)
> +{
> +	/*
> +	 * vectors + 0xfe0 = __kuser_get_tls
> +	 * vectors + 0xfe8 = hardware TLS instruction at 0xffff0fe8
> +	 */
> +	if (tls_emu || has_tls)
> +		memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfe8, 4);
> +}

Just a little opinion: Perhaps has_tls_reg would be a clearer name.
All variants "have TLS" after all.

Also - and this isn't directly related to your change so feel free to
ignore it - wouldn't it make more sense for the tls_emu case to use
the memory version (and update the memory location), so that even on
tls_emu systems, user programs which call the kuser code will run faster?
With that change, there would be no real penalty to enabling tls_emu
for any system that finds it useful.

-- Jamie
