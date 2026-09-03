Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB173380FEB;
	Thu,  3 Sep 2026 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429211; cv=none; b=o8sHO35ZmsCsyKdnH6WP1cjtfS+05Ur136qtEqpQ+smh7v+AYRdQugSJUkPZ9d/5u+++GljaXYDDok6IpXkQZnPU/op3O1+uOoUuPnBJRLkf8PrXbC7HfCAJYWEGGNIzh3vuiFe0c62YPQ1iMzPb2+9XesVI9L6RmU4iKPgkjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429211; c=relaxed/simple;
	bh=ftXwaCv2y7qnfipIV3PGFHvYnslMeEMwqnxNv7QNNYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e14vZbSALDmJ+KFPAAd+GiRObeJNaYjqn0vwU2v56Lq924NxbHrjZsJuXxa2S2SrvY2AXU+W1eC5nNQaJNoVT2u5HM4tiYnnot7IcrK/i3pX1XNRQm6l94XjHE/OsQI0SqMzABv1kGnPSIBS/9TMOSCwR3Fg6Hsrpq0ygTNFCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=6xB+WVkJ; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="6xB+WVkJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=SgusQL9+sFfWz7EnyqSnK6Hl35QyQiDKZkxIBkqLRtM=; t=1788429209; x=1789638809; 
	b=6xB+WVkJsIUalOCaucBsDvJnictFchcF2ta5j+bEARDVpQdEPc77yTITSM/JWLaUIPQhVPXHJ6t
	x/1O2OVzw1D+du5rJ1s9UgCQLm18N9VwuCfJ5FqagVhLmOFrvh/Pa7AYNXp/UmDOnrA3a8ZKOmBdJ
	U+1zLBLsMg6dkzgZYLdWiRlmv6aqHmb48BHNOPAPPDyjckAb9q3pxDI7VOxotllwuoYlYfUZ5hx3p
	L0G1TqeSBhFAKtL68WokvuGb66UEWWVQiR/vRDHn7cJ+6RaSMLq/Ztpn9xNDZlz/bTM3xyBLZX/fO
	BinYABvFfFPMAXQtayWGMh0Nr/jy4Q8D7kng==;
Date: Thu, 3 Sep 2026 11:53:08 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
Cc: "Tero Kristo" <kristo@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Brian
 Masney" <bmasney@redhat.com>, "Tony Lindgren" <tony@atomide.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, =?UTF-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>, =?UTF-8?B?R3LDqWdvcnk=?= Clement
 <gregory.clement@bootlin.com>, <linux-omap@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hns@goldelico.com>
Subject: Re: [PATCH v2 0/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
Message-ID: <20260903115308.2a569a30@kemnade.info>
In-Reply-To: <20260902111556.38645f32@kemnade.info>
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
	<20260902082639.69643254@kemnade.info>
	<DL4OUCXRGBEA.2G2WHI4FH2AY8@bootlin.com>
	<20260902111556.38645f32@kemnade.info>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 11:15:56 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> On Wed, 02 Sep 2026 10:30:02 +0200
> "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com> wrote:
> 
> > On Wed Sep 2, 2026 at 8:26 AM CEST, Andreas Kemnade wrote:  
> > > Hi,
> > >
> > > this seems to produce on OMAP3 (DM3730), even with the init fix.
> > >
> > > [    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff
> > > , max_idle_ns: 58327039986419 ns                                                
> > > [    0.000030] sched_clock: 32 bits at 33kHz, resolution 30517ns, wraps every 65
> > > 535999984741ns                                                                  
> > > [    0.013488] clk: failed to reparent gpt1_fck to omap_32k_fck: -22            
> > > [    0.019805] Failed to initialize '/ocp@68000000/target-module@48318000/timer@
> > > 0': -19                                                                         
> > >
> > > Regards,
> > > Andreas    
> > 
> > Hi Andreas,
> > 
> > That one will be a bit harder for me to debug, as I'm not sure I can
> > easily get this hardware. But looking at the device tree and the
> > reference manual, I suspect something is wrong in the omap3 device tree.
> > 
> > In omap3.dtsi, we have this node [1]:
> > 
> > &timer1_target {
> > 	ti,no-reset-on-init;
> > 	ti,no-idle;
> > 	timer@0 {
> > 		assigned-clocks = <&gpt1_fck>;
> > 		assigned-clock-parents = <&omap_32k_fck>;
> > 	};
> > };
> > 
> > I suspect that's the source of the error: __set_clk_parents() in
> > drivers/clk/clk-conf.c will try to set &omap_32k_fck as a parent of
> > &gpt1_fck. But looking at omap3xxx-clocks.dtsi [2], &omap_32k_fck is not
> > a valid parent:
> > 
> > 	gpt1_fck: gpt1_fck {
> > 		#clock-cells = <0>;
> > 		compatible = "ti,composite-clock";
> > 		clocks = <&gpt1_gate_fck>, <&gpt1_mux_fck>;
> > 	};
> >   
> the composite clock is meant to combine the two clocks into one,
> so you have one single clock with enable/disable functions and
> parents. At least that seems to be the idea.
> 
> If the system fully boots, you see:
> localhost:/sys/kernel/debug/clk/gpt1_fck# cat clk_possible_parents 
> omap_32k_fck sys_ck
>
after doing some hacks around gpt1, I could investigate a bit

We have:
localhost:/sys/kernel/debug/clk# grep '(' */clk_possible_parents 
clkout2_src_ck/clk_possible_parents:(missing) (missing) (missing) (missing)
gpt10_fck/clk_possible_parents:(missing) (missing)
gpt11_fck/clk_possible_parents:(missing) (missing)
gpt2_fck/clk_possible_parents:(missing) (missing)
gpt3_fck/clk_possible_parents:(missing) (missing)
gpt4_fck/clk_possible_parents:(missing) (missing)
gpt5_fck/clk_possible_parents:(missing) (missing)
gpt6_fck/clk_possible_parents:(missing) (missing)
gpt7_fck/clk_possible_parents:(missing) (missing)
gpt8_fck/clk_possible_parents:(missing) (missing)
gpt9_fck/clk_possible_parents:(missing) (missing)
mcbsp1_fck/clk_possible_parents:(missing) (missing)
mcbsp2_fck/clk_possible_parents:(missing) (missing)
mcbsp3_fck/clk_possible_parents:(missing) (missing)
mcbsp4_fck/clk_possible_parents:(missing) (missing)
mcbsp5_fck/clk_possible_parents:(missing) (missing)
sgx_fck/clk_possible_parents:(missing) (missing) (missing) (missing) (missing) (missing) (missing) (missing)
usim_fck/clk_possible_parents:(missing) (missing) (missing) (missing) (missing) (missing) (missing) (missing) (missing) (missing)
localhost:/sys/kernel/debug/clk# 

All these clocks are composite clocks.

so the early-registration of timer-ti-dm-systimer seems not to be
the main issue here. Looking around what might be affected,
mux clocks build into composite clocks:
:~/linux/arch/arm/boot/dts/ti/omap$ grep -l ti,composite-mux *.dts*
omap2420-clocks.dtsi
omap2430-clocks.dtsi
omap24xx-clocks.dtsi
omap36xx-am35xx-omap3430es2plus-clocks.dtsi
omap36xx-omap3430es2plus-clocks.dtsi
omap3xxx-clocks.dtsi
omap44xx-clocks.dtsi
omap54xx-clocks.dtsi

So havoc all over the place, just worst in omap3 because more critical
clocks are affected.

So I think we need either a revert of these patches or a some
kind of quirk in clk_hw_register_composite_pdata to pass throuch something
between the mux component and the composite.

Regrads,
Andreas
