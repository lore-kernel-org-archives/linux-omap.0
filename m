From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.27-omap-git 0/6] the last planned twl4030 core IRQ
	updates
Date: Thu, 16 Oct 2008 13:06:06 -0700
Message-ID: <20081016200606.GQ15820@atomide.com>
References: <200810101419.12192.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56918 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYJPUGJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 16:06:09 -0400
Content-Disposition: inline
In-Reply-To: <200810101419.12192.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081010 14:31]:
> Following this are six patches:
> 
>  - Split PIH irq support into a separate file
>  - Change SIH initialization scheme, enabling data re-use
>  - Add sharable SIH irq_chip support
>  - Replace unshared pwrirq irq_chip (gains IRQ trigger controls)
>  - Replace unshared gpio irq_chip (no functional changes)
>  - Remove more CPP symbols
> 
> The high level summary:  shrink the code, remove a task, and
> have the SIH support code ready for mainline merge.
> 
> With SIH support merged, the RTC driver will also become
> mergeable.  I think most of the other child drivers aren't
> quite ready yet though.

Pushing these today.

Tony

> 
> - Dave
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
