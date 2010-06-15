From: David Brownell <david-b@pacbell.net>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Tue, 15 Jun 2010 14:55:52 -0700 (PDT)
Message-ID: <875306.29888.qm@web180301.mail.gq1.yahoo.com>
References: <1276636633.2824.88.camel@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n6-vm0.bullet.mail.gq1.yahoo.com ([98.137.26.79]:42277 "HELO
	n6-vm0.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754688Ab0FOVzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Jun 2010 17:55:53 -0400
In-Reply-To: <1276636633.2824.88.camel@black>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>, Mathieu Poirier <mathieu.poirier@canonical.com>
Cc: linux-omap@vger.kernel.org


> > > When going from PREEMPT_VOLUNTARY to PREEMPT_NONE
> the problem goes away.

Have you found whether this is a problem
with the OMAP HSMMC driver
versus the MMC/SD framework code

