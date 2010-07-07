From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v3]OMAP:GPTIMER:1ms tick generation correction
Date: Wed, 7 Jul 2010 05:33:06 -0700 (PDT)
Message-ID: <502992.73818.qm@web180316.mail.gq1.yahoo.com>
References: <20100707115946.GM1920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n4-vm0.bullet.mail.gq1.yahoo.com ([67.195.9.7]:36376 "HELO
	n4-vm0.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754527Ab0GGMdI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 08:33:08 -0400
In-Reply-To: <20100707115946.GM1920@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>



--- On Wed, 7/7/10, Tony Lindgren <tony@atomide.com> wrote:


> Or can we somehow calculate this drift once during init?

If it's set up in the gentime framework, yes; very
standard.  AT91 is one model (they all have
32K clocks used to generate the system tick).


