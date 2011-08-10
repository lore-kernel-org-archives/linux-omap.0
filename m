From: Tony Lindgren <tony@atomide.com>
Subject: Re: Build failure: bisected: v3.1-rc1 with config ARCH_OMAP &&
 !ARCH_OMAP4 fails with linker error
Date: Wed, 10 Aug 2011 01:37:31 -0700
Message-ID: <20110810083731.GA1939@atomide.com>
References: <1312819724.14483.29.camel@morsingpad>
 <alpine.DEB.2.00.1108081435340.4764@utopia.booyaka.com>
 <20110809131453.GR1866@atomide.com>
 <alpine.DEB.2.00.1108092102580.12674@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1108092102580.12674@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Daniel Morsing <daniel.morsing@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [110809 20:01]:
> On Tue, 9 Aug 2011, Tony Lindgren wrote:
> 
> > Hmm, there are also these when CONFIG_ARCH_OMAP4 is not selected:
> > 
> > arch/arm/mach-omap2/built-in.o: In function `_enable_module':
> > arch/arm/mach-omap2/omap_hwmod.c:701: undefined reference to `omap4_cminst_module_enable'
> > arch/arm/mach-omap2/built-in.o: In function `_disable_module':
> > arch/arm/mach-omap2/omap_hwmod.c:726: undefined reference to `omap4_cminst_module_disable'
> > arch/arm/mach-omap2/built-in.o: In function `_wait_target_disable':
> > arch/arm/mach-omap2/omap_hwmod.c:1179: undefined reference to `omap4_cminst_wait_module_idle'
> > distcc[27594] ERROR: compile (null) on localhost failed
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > Care to take a look?
> 
> Weird, those don't show up on my n800 config (below) with CodeSourcery 
> 2010.09-50.  Looks like something isn't removing the dead code.  will post 
> a patch for this.
> 
> If you post which compiler you're using, I'll add it to my build tests 
> too...

Happens at least with this one:

gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203)

Tony
