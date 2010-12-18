From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap1: pm_bus: Fix compilation warning.
Date: Fri, 17 Dec 2010 18:05:04 -0800
Message-ID: <20101218020504.GM5941@atomide.com>
References: <1291641828-19909-1-git-send-email-marek.belisko@open-nandra.com>
 <87lj41jk8p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22418 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756950Ab0LRCFU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 21:05:20 -0500
Content-Disposition: inline
In-Reply-To: <87lj41jk8p.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Marek Belisko <marek.belisko@open-nandra.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [101207 14:13]:
> Marek Belisko <marek.belisko@open-nandra.com> writes:
> 
> > Fix following compilation warning:
> > arch/arm/mach-omap1/pm_bus.c: In function 'omap1_pm_runtime_resume':
> > arch/arm/mach-omap1/pm_bus.c:51: warning: unused variable 'ret'
> >
> > Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Taking these except for the mailbox one which is already fixed.

Tony
