From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Regulator: Registering USB internal LDOs for
 TWL4030
Date: Thu, 11 Mar 2010 14:22:47 -0800
Message-ID: <20100311222247.GN2900@atomide.com>
References: <1263201918-8185-1-git-send-email-anuj.aggarwal@ti.com>
 <20100111105612.GA20717@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321B9DE1E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63826 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756936Ab0CKWV2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 17:21:28 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321B9DE1E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>

* Aggarwal, Anuj <anuj.aggarwal@ti.com> [100301 22:21]:
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> > Sent: Monday, January 11, 2010 4:26 PM
> > To: Aggarwal, Anuj
> > Cc: linux-omap@vger.kernel.org; lrg@slimlogic.co.uk
> > Subject: Re: [PATCH 1/1] Regulator: Registering USB internal LDOs for
> > TWL4030
> > 
> > On Mon, Jan 11, 2010 at 02:55:18PM +0530, Anuj Aggarwal wrote:
> > > Adding member variables for USB internal LDOs in twl4030_platform_data
> > > and registering them in twl-core.c if the variables are populated
> > > from board-evm file.
> > 
> > > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Tony,
> 
> Can you pull this patch? I have tried it on for-next tip, it applies
> cleanly.

This needs to go to Samuel, see MAINTAINERS file for MFD.

Tony
