From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 10/14] PM / MIPS: Use struct syscore_ops instead of sysdevs for PM
Date: Mon, 18 Apr 2011 22:03:15 +0200
Message-ID: <201104182203.16171.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172312.35060.rjw@sisk.pl> <20110418101218.GA25325@linux-mips.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:32918 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348Ab1DRUCp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 16:02:45 -0400
In-Reply-To: <20110418101218.GA25325@linux-mips.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Mike Frysinger <vapier@gentoo.org>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Jiri Kosina <jkosina@suse.cz>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

On Monday, April 18, 2011, Ralf Baechle wrote:
> This patch breaks the Alchemy kernel compile; below patch on top of it fixes
> that again.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Thanks!  If you don't mind, I'd like to fold your patch into [10/14].

Rafael


> ---
>  arch/mips/alchemy/common/irq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-mips/arch/mips/alchemy/common/irq.c
> ===================================================================
> --- linux-mips.orig/arch/mips/alchemy/common/irq.c
> +++ linux-mips/arch/mips/alchemy/common/irq.c
> @@ -619,8 +619,8 @@ static struct syscore_ops alchemy_ic_sys
>  
>  static int __init alchemy_ic_syscore_init(void)
>  {
> -	alchemy_ic_data[0].base = ioremap(icbase[IC0_PHYS_ADDR], 0x1000);
> -	alchemy_ic_data[1].base = ioremap(icbase[IC1_PHYS_ADDR], 0x1000);
> +	alchemy_ic_data[0].base = ioremap(IC0_PHYS_ADDR, 0x1000);
> +	alchemy_ic_data[1].base = ioremap(IC1_PHYS_ADDR, 0x1000);
>  
>  	register_syscore_ops(&alchemy_ic_syscore_ops);
>  
> 
> 

