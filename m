From: Tony Lindgren <tony@atomide.com>
Subject: Re: SMP_ON_UP? - Build break with custom minimal defconfig
Date: Tue, 21 Sep 2010 08:54:00 -0700
Message-ID: <20100921155400.GR4611@atomide.com>
References: <AANLkTim-mQjFnqGo_G971yTbU9FLnUja2t_axytGM5LN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57466 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757209Ab0IUPx6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 11:53:58 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTim-mQjFnqGo_G971yTbU9FLnUja2t_axytGM5LN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [100921 08:41]:
> Hi all,
> 
> I was trying to use current linux-omap master to put together a custom
> minimal defconfig for a beagleboard, and I'm seeing a compile error:
> 
>   CC      init/main.o
> In file included from include/linux/highmem.h:9,
>                  from include/linux/pagemap.h:10,
>                  from include/linux/mempolicy.h:70,
>                  from init/main.c:50:
> /home/userdata/a0393673/kernels/tony/linux-omap-2.6/arch/arm/include/asm/cacheflush.h:
> In function '__flush_icache_all':
> /home/userdata/a0393673/kernels/tony/linux-omap-2.6/arch/arm/include/asm/cacheflush.h:332:
> error: implicit declaration of function '__flush_icache_preferred'
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2
> 
> I think this is related to the recent SMP_ON_UP patches.
> 
> The reduced .config I'm using (generated using `make savedefconfig`) is below.
> 
> I'll try and debug in a while, but just reporting for now.

Yes that sounds like a bug in a smp_on_up related patch. Will try your
defconfig here too.

Thanks,

Tony
