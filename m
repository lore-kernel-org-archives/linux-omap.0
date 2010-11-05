From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: omap1: remove unused variables
Date: Fri, 5 Nov 2010 09:47:15 -0700
Message-ID: <20101105164715.GM9264@atomide.com>
References: <1287473455-25773-1-git-send-email-balbi@ti.com>
 <1287473455-25773-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62899 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0KEQrb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 12:47:31 -0400
Content-Disposition: inline
In-Reply-To: <1287473455-25773-3-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

* Felipe Balbi <balbi@ti.com> [101019 00:22]:
> Get rid of the following warnings:
> 
> arch/arm/mach-omap1/pm_bus.c: In function 'omap1_pm_runtime_resume':
> arch/arm/mach-omap1/pm_bus.c:51: warning: unused variable 'ret'
> arch/arm/mach-omap1/mailbox.c: In function 'omap1_mbox_probe':
> arch/arm/mach-omap1/mailbox.c:148: warning: unused variable 'i'

Assuming Hiroshi will queue up this one.

Tony
