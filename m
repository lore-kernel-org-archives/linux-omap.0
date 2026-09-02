Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456D3E9C2B;
	Wed,  2 Sep 2026 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338076; cv=none; b=CNS4Iejgj+gWaSZNy6Xxhr7iO/2rNvg1p4Et6lGTkd5UeWV5ioMbJyiz9A7vkDxITHBdDM+n0hoy29g1hzBLL4JmEQqh4mMss27bptMz11YnD/LGBEBojZ2onXMgSdBWBekC3+op+BAbh86fhIbObMPA1+/ug1JF68UbWw1Uf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338076; c=relaxed/simple;
	bh=pnNUS8mWmhzCdDTdxo+urlGVuBOjkXrjTonoFRnkpRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPe2Vok0agKl2cO82BEb28+5T/0Y0dwk6md+SGPdgvjsNVwZkswuBr3/ybs8w1PrQLUKMgUfyX434xZbLiCWiPZ7f/m13iJGahCAmZsD46MvnYqXOISQBlNMUJbRdDKEYsK3Rgkjn3OhaeWIZRpb3Eq0qr5ITW/Co6sx/bfPPKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=LLW6JXV9; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="LLW6JXV9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=l7XpSW2eb4oLDc6eE3Z9RgxOJk8x+ZF6XYRM954FsY8=; t=1788338074; x=1789547674; 
	b=LLW6JXV9d9CdSdAtLT9EJs5pNQNukJ2+yOjs1X4HAAAXz457Sz3AENr8sj5tEdHH1yhhdQ/+s/K
	oIynr71bxeEaZXu4bKo3TTi1DFVi2y33nlVWC1FmIc/T4sLBnrw9dsVdiyE7uWMHflIAIjGJbuxCt
	evM3Ic3GGPQKAq6DaaoiyN+OTNZxLMx+K96MtT2WSB5xHZNWBVkjrjKI6Vwg/jetov1Z5cTGldSsz
	7v6fPIiN1Q6+5tM18YeTXH8bQPstFWQqXGKvmLlKwx+RbRkKplZHufWllZWkVjFDg5Ur/gWIL2lUm
	abZgCYg0VJImy721W0nN580W95+bzcVK3vwg==;
Date: Wed, 2 Sep 2026 10:34:25 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Tero Kristo <kristo@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney@redhat.com>, Tony Lindgren <tony@atomide.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>, =?UTF-8?B?R3LDqWdvcnk=?= Clement
 <gregory.clement@bootlin.com>, linux-omap@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldecilo.com
Subject: Re: [PATCH v2 0/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
Message-ID: <20260902103425.2cf41f15@kemnade.info>
In-Reply-To: <20260902082639.69643254@kemnade.info>
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
	<20260902082639.69643254@kemnade.info>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 08:26:39 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Hi,
> 
> this seems to produce on OMAP3 (DM3730), even with the init fix.
> 
> [    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff
> , max_idle_ns: 58327039986419 ns                                                
> [    0.000030] sched_clock: 32 bits at 33kHz, resolution 30517ns, wraps every 65
> 535999984741ns                                                                  
> [    0.013488] clk: failed to reparent gpt1_fck to omap_32k_fck: -22            
> [    0.019805] Failed to initialize '/ocp@68000000/target-module@48318000/timer@
> 0': -19                                                                         
> 

created a backrace with that -EINVAL:
[    0.030975]  clk_fetch_parent_index from clk_core_set_parent_nolock+0x7c/0x18
[    0.031005]  clk_core_set_parent_nolock from clk_set_parent+0x6c/0x18c       
[    0.031036]  clk_set_parent from of_clk_set_defaults+0x304/0x6e8             
[    0.031066]  of_clk_set_defaults from dmtimer_systimer_setup+0x5c/0x1cc      
[    0.031127]  dmtimer_systimer_setup from dmtimer_clkevt_init_common+0x78/0x10
[    0.031158]  dmtimer_clkevt_init_common from dmtimer_clockevent_init+0x80/0x8
[    0.031188]  dmtimer_clockevent_init from dmtimer_systimer_init+0x114/0x134  
[    0.031219]  dmtimer_systimer_init from timer_probe+0x68/0xf4                
[    0.031250]  timer_probe from start_kernel+0x19c/0x370                       
[    0.031280]  start_kernel from 0x0                                           

Maybe something is not ready yet for using indexes instead of names there.

> Regards,
> Andreas
> 
> On Mon, 27 Jul 2026 09:41:39 +0200
> Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com> wrote:
> 
> > This commit aims to solve an issue I've been describing a few months ago
> > on AM335x SoC [1]. I believe using the parent_data field of
> > clk_init_data structure is now the preferred way to convey that data,
> > and it should be more reliable than string comparisons.
> > 
> > [1]: https://lore.kernel.org/all/DI4RUFQNSSNP.2QMSSQWJW9I2O@bootlin.com/
> > 
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> > ---
> > Changes in v2:
> > - Also use clk_parent_data structure in composite.c.
> > - Rebase on v7.2-rc5.
> > - Link to v1: https://lore.kernel.org/r/20260715-mathieu-wdt-clock-theo-v1-1-da65bba1828b@bootlin.com
> > 
> > ---
> > Mathieu Dubois-Briand (2):
> >       clk: ti: mux: resolve parent clocks by DT index, not by name
> >       clk: ti: composite: resolve parent clocks by DT index, not by name
> > 
> >  drivers/clk/ti/composite.c | 26 ++++++++++++++------------
> >  drivers/clk/ti/mux.c       | 20 +++++++++++---------
> >  2 files changed, 25 insertions(+), 21 deletions(-)
> > ---
> > base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> > change-id: 20260713-mathieu-wdt-clock-theo-f0c5ba58e258
> > 
> > Best regards,  
> 
> 
> 

