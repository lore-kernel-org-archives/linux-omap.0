From: Mathieu Poirier <mathieu.poirier@canonical.com>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Tue, 15 Jun 2010 16:43:06 -0600
Message-ID: <1276641786.2824.89.camel@black>
References: <875306.29888.qm@web180301.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:47724 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321Ab0FOWm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jun 2010 18:42:59 -0400
In-Reply-To: <875306.29888.qm@web180301.mail.gq1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Venkatraman S <svenkatr@ti.com>, linux-omap@vger.kernel.org

On Tue, 2010-06-15 at 14:55 -0700, David Brownell wrote:
> > > > When going from PREEMPT_VOLUNTARY to PREEMPT_NONE
> > the problem goes away.
> 
> Have you found whether this is a problem
> with the OMAP HSMMC driver
> versus the MMC/SD framework code
> 
Not yet - I'm in the code, investigating.


