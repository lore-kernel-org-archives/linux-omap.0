From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq and _od_resume_noirq
Date: Thu, 18 Oct 2012 13:58:02 -0700
Message-ID: <87hapr4hwl.fsf@deeprootsystems.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
	<1350488043-5053-2-git-send-email-balbi@ti.com>
	<871ugvivso.fsf@deeprootsystems.com>
	<20121018165525.GA6385@arwen.pp.htv.fi>
	<87ipa7d6cy.fsf@deeprootsystems.com>
	<20121018175027.GA7917@arwen.pp.htv.fi>
	<87vce77hba.fsf@deeprootsystems.com>
	<20121018193440.GA8609@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49031 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464Ab2JRU5q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 16:57:46 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so8700400pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 13:57:46 -0700 (PDT)
In-Reply-To: <20121018193440.GA8609@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Thu, 18 Oct 2012 22:34:40 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Felipe Balbi <balbi@ti.com> writes:

[...]

> ps: I'll continue reading the code and further test my series to see
> if I can understand what you say here.

OK.  And please get it working in cases where drivers are using I2C in
their suspend/resume (and even late/early) paths, and also where device
runtime PM is disabled from userspace.  All of that works with today's
code and will not work with your proposed code.

Kevin
