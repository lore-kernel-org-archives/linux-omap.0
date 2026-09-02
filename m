Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41E36C5A9;
	Wed,  2 Sep 2026 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340567; cv=none; b=rdf8bSaPeI2cJsqquDFLRToTGAKzuPKUCfzxLpsXGtEujJBmGXJ2DBBrb/P9US77HXt0NpOVjq2S6epGUFxyno1l03znpH4aV85fay9XavtcpLyNLTNSooQ1WTalPuniSVfHHhT5fNWWNoSNJY/rnKH+kjciOZ8KOBg9umr0+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340567; c=relaxed/simple;
	bh=JoMhVv6yIf1gEaMaouJvLtaKPVopl2hWNZ36X+/vxRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4KBkXEDevmtv7VXvcV2Op13OI6XhXTVgom3XEvjnY8EOIhKuqyNkcypO4SJKajHa/FymbNWJZBLSLSEHZBLZkjIdNz+p8LSfC5WCdO6L+J4u+jsO37CD/mCCad7zjq5LTXnhfD4FKTSsAoidokptRZYKPlGlipg+Ac5s+V9Fp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=xd82kYNx; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="xd82kYNx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=M4NMTdV3IHm8hRgXIpAtFSGNZ5r4VFwtMQPSnqoarrM=; t=1788340565; x=1789550165; 
	b=xd82kYNxRFgGdRr0jb3wR7GszZ+91ouOHUUbR0EP907z/7Vxbvzu2xj+1+SI//ejbpgJ+uVNezg
	qzaHShiujzefd/+clif++pIOt61CEE0he/GyVT4VD/EBLQrUGuQohcMpQ74nQ680NL2e/0fKQu26Z
	gQAJNvD8vmS40QpKXXOcNJL8IgjPc6VTAkQ7NPr3p+vqipwvdkysdJf/v2CwTWCn0ctHrBi7XEkLe
	uaaOQ64UlNXQL0H4v1JWj4cPwRsRZt6XviFJpIr8dDk0SoQuxSlNgqMCBuuF7cMQHvOQUnIPPrIhF
	HAjV9ho5XJLvcMWmDNaVLAWRR2rnM6j/cdlw==;
Date: Wed, 2 Sep 2026 11:15:56 +0200
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
Message-ID: <20260902111556.38645f32@kemnade.info>
In-Reply-To: <DL4OUCXRGBEA.2G2WHI4FH2AY8@bootlin.com>
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
	<20260902082639.69643254@kemnade.info>
	<DL4OUCXRGBEA.2G2WHI4FH2AY8@bootlin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Sep 2026 10:30:02 +0200
"Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com> wrote:

> On Wed Sep 2, 2026 at 8:26 AM CEST, Andreas Kemnade wrote:
> > Hi,
> >
> > this seems to produce on OMAP3 (DM3730), even with the init fix.
> >
> > [    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff
> > , max_idle_ns: 58327039986419 ns                                                
> > [    0.000030] sched_clock: 32 bits at 33kHz, resolution 30517ns, wraps every 65
> > 535999984741ns                                                                  
> > [    0.013488] clk: failed to reparent gpt1_fck to omap_32k_fck: -22            
> > [    0.019805] Failed to initialize '/ocp@68000000/target-module@48318000/timer@
> > 0': -19                                                                         
> >
> > Regards,
> > Andreas  
> 
> Hi Andreas,
> 
> That one will be a bit harder for me to debug, as I'm not sure I can
> easily get this hardware. But looking at the device tree and the
> reference manual, I suspect something is wrong in the omap3 device tree.
> 
> In omap3.dtsi, we have this node [1]:
> 
> &timer1_target {
> 	ti,no-reset-on-init;
> 	ti,no-idle;
> 	timer@0 {
> 		assigned-clocks = <&gpt1_fck>;
> 		assigned-clock-parents = <&omap_32k_fck>;
> 	};
> };
> 
> I suspect that's the source of the error: __set_clk_parents() in
> drivers/clk/clk-conf.c will try to set &omap_32k_fck as a parent of
> &gpt1_fck. But looking at omap3xxx-clocks.dtsi [2], &omap_32k_fck is not
> a valid parent:
> 
> 	gpt1_fck: gpt1_fck {
> 		#clock-cells = <0>;
> 		compatible = "ti,composite-clock";
> 		clocks = <&gpt1_gate_fck>, <&gpt1_mux_fck>;
> 	};
> 
the composite clock is meant to combine the two clocks into one,
so you have one single clock with enable/disable functions and
parents. At least that seems to be the idea.

If the system fully boots, you see:
localhost:/sys/kernel/debug/clk/gpt1_fck# cat clk_possible_parents 
omap_32k_fck sys_ck

> Yet the &gpt1_mux_fck is a mux, and one of the parent is indeed
> &omap_32k_fck [3]. So I suspect the correct assigned clock parent in
> timer@0 should be &gpt1_mux_fck.
> 
> Can you try it that way?
> 
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz                        
[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xfffffffs
[    0.000000] sched_clock: 32 bits at 33kHz, resolution 30517ns, wraps every 6s
[    0.013458] dmtimer_systimer_setup: clock source init failed: -517           

The system does not boot much further.

> Now, I have doubts about how this was working correctly so far. You
> don't see any error at all without my changes?
> 
No error at all.

Regards,
Andreas
