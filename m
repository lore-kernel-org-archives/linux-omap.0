From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] arm: omap: gpmc-smsc911x: minor style fixes
Date: Tue, 3 May 2011 00:42:55 -0700
Message-ID: <20110503074254.GK2092@atomide.com>
References: <4DB6E937.7090904@compulab.co.il>
 <1303835156-14516-1-git-send-email-grinberg@compulab.co.il>
 <BANLkTim-cu5_-pt5VxBunjqLWiHyHuo2xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:38395 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751074Ab1ECHm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 03:42:59 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTim-cu5_-pt5VxBunjqLWiHyHuo2xg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Mike Rapoport <mike@compulab.co.il>, Tim Nordell <tim.nordell@logicpd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Menon, Nishanth <nm@ti.com> [110426 14:05]:
> On Tue, Apr 26, 2011 at 11:25, Igor Grinberg <grinberg@compulab.co.il> wrote:
> >
> > replace "printk(KERN_ERR" by "pr_err("
> > and fix needlessly multi-lined #ifdef
> >
> > Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> 
> Acked-by: Nishanth Menon <nm@ti.com>

Thanks, will queue this too. One line negative diffstat, whee!

Tony
