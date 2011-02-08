From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 6/9] omap: dpll: Add allow_idle/deny_idle support for
 all DPLL's
Date: Mon, 7 Feb 2011 21:16:25 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102072115350.21991@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com> <1296813544-25170-7-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1102071952300.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41104 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab1BHEQ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 23:16:26 -0500
In-Reply-To: <alpine.DEB.2.00.1102071952300.21991@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, 7 Feb 2011, Paul Walmsley wrote:

> Looks like you add the allow_idle/deny_idle functions for the OMAP3 CORE 
> DPLL, but you don't change mach-omap2/pm34xx.c.  Any reason for this?  It 
> seems that the current OMAP3 PM code doesn't enable CORE DPLL autoidle.  

Never mind - as Rajendra pointed out via private E-mail, that is done 
along with the PER DPLL autoidle in pm34xx.c.  So, the original patch is 
okay in this regard.


- Paul
