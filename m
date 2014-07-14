From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: l2c: squelch warning dump on power
 control setting
Date: Mon, 14 Jul 2014 09:25:52 -0700
Message-ID: <20140714162551.GG20068@atomide.com>
References: <d081bdbeebec0e7f2a292a11513f96375aa35bd4.1405343188.git.nsekhar@ti.com>
 <53C3E9BD.9010104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48799 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884AbaGNQ1Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jul 2014 12:27:16 -0400
Content-Disposition: inline
In-Reply-To: <53C3E9BD.9010104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [140714 07:33]:
> On Monday 14 July 2014 09:13 AM, Sekhar Nori wrote:
> > On OMAP SOCs using PL310 controllers, power_ctrl register is not
> > accessible from non-secure software even on PL310 versions which
> > support it. The secure code takes care of setting it up correctly
> > and power transitions are proven on these devices.
> > 
> > For example, AM437x has L2C-310 version r3p3 and ROM code on that
> > device does not support writing to L2C-310 power control register.
> > The L2C driver, however, tries writing to this register for all
> > revisions >= r3p0.
> > 
> > This leads to a warning dump on boot which leads most users to believe
> > that L2 cache is non-functional.
> > 
> > Since the problem is understood, and cannot be addressed through
> > software, replace the warning with a pr_info() while maintaining the
> > WARN_ON() for other truly unexpected scenarios.
> > 
> > Reported-by: Nishanth Menon <nm@ti.com>
> > Tested-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > ---
> > Only description updated since v1
> > 
> Thanks for update.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 

Thanks applying into omap-for-v3.16/fixes.

Tony 
