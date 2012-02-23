From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: fix mailbox init code
Date: Thu, 23 Feb 2012 11:27:39 -0800
Message-ID: <20120223192739.GB18185@atomide.com>
References: <1329987215-28227-1-git-send-email-ohad@wizery.com>
 <B5906170F1614E41A8A28DE3B8D12143317AD2B7@DBDE01.ent.ti.com>
 <CAK=WgbYsV4M6RYYyA85=FyJcEW-8O3yiqZit2ev2AW-mG+0-8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41965 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab2BWT1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 14:27:45 -0500
Content-Disposition: inline
In-Reply-To: <CAK=WgbYsV4M6RYYyA85=FyJcEW-8O3yiqZit2ev2AW-mG+0-8A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>, Hiroshi Doyu <hdoyu@nvidia.com>

* Ohad Ben-Cohen <ohad@wizery.com> [120223 08:32]:
> On Thu, Feb 23, 2012 at 11:18 AM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> > Instead of adding more #ifs can they be completely removed please?
> 
> Care to propose something specific (which is viable for the -rc cycle) ?

This is pretty much the minimal change for -rc cycle so I'll apply
this into fixes.

Regards,

Tony
