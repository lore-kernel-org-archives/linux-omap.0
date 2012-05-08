From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: dmtimer: remove redundant sysconfig
 context restore
Date: Tue, 8 May 2012 16:18:45 -0700
Message-ID: <20120508231845.GQ5088@atomide.com>
References: <1334223827-28812-1-git-send-email-tarun.kanti@ti.com>
 <87wr5lhvve.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:13361 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab2EHXSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 19:18:47 -0400
Content-Disposition: inline
In-Reply-To: <87wr5lhvve.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com

* Kevin Hilman <khilman@ti.com> [120412 07:26]:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > Since hwmod framework now manages sysconfig context save/restore
> > there is no more need to touch this register in driver. Hence,
> > remove restore of sysconfig register in omap_timer_restore_context.
> > This was causing incorrect context restore of sysconfig register.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > ---
> > v2: removed tiocp_cfg from struct timer_regs {}
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Applying into cleanup branch.

Tony
