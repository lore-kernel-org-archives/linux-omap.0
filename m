From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] omap: Disable VGA console for omaps
Date: Tue, 29 Jun 2010 17:21:45 +0300
Message-ID: <20100629142144.GN2822@atomide.com>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
 <20100629114720.16008.84291.stgit@baageli.muru.com>
 <20100629120724.GA23884@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52523 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919Ab0F2OVh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 10:21:37 -0400
Content-Disposition: inline
In-Reply-To: <20100629120724.GA23884@oksana.dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

* Anton Vorontsov <cbouatmailru@gmail.com> [100629 15:04]:
> On Tue, Jun 29, 2010 at 02:47:20PM +0300, Tony Lindgren wrote:
> > Otherwise we have to disable it manually to avoid compile errors.
> > 
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> We'll need this for mach-cns3xxx too. And doing that change for
> every ARM subarch is going to produce lots of rejects.
> 
> I'd suggest to disable (or make it 'default n') for all ARMs,
> except these:
> 
> $ git grep VGA_CONSOLE= arch/arm/configs/
> arch/arm/configs/footbridge_defconfig:CONFIG_VGA_CONSOLE=y
> arch/arm/configs/integrator_defconfig:CONFIG_VGA_CONSOLE=y
> arch/arm/configs/netwinder_defconfig:CONFIG_VGA_CONSOLE=y

Good idea, will post a modified patch tomorrow.

Tony
