From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: check for module address space
 during init
Date: Tue, 8 Oct 2013 11:09:36 -0700
Message-ID: <20131008180936.GE8313@atomide.com>
References: <1380819546-53631-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26042 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab3JHSJj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 14:09:39 -0400
Content-Disposition: inline
In-Reply-To: <1380819546-53631-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Afzal Mohammed <afzal@ti.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>, Nishant Menon <nm@ti.com>, linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [131003 10:07]:
> The hwmod init sequence involves initializing and idling all the
> hwmods during bootup. If a module class has sysconfig, the init
> sequence utilizes the module register base for performing any
> sysc configuration.
> 
> The module address space is being removed from hwmod database and
> retrieved from the <reg> property of the corresponding DT node.
> If a hwmod does not have its corresponding DT node defined and the
> memory address space is not defined in the corresponding
> omap_hwmod_ocp_if, then the module register target address space
> would be NULL and any sysc programming would result in a NULL
> pointer dereference and a kernel boot hang.

Hmm so is this needed as a fix for the -rcy cycle?
 
Other than that looks OK to me, Paul should queue or ack this one:

Acked-by: Tony Lindgren <tony@atomide.com>
