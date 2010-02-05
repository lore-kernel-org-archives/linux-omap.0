From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [PATCH 2/4-V1] AM3517: Enable TSC2004 driver support
 for AM3517EVM
Date: Fri, 5 Feb 2010 08:38:58 -0800
Message-ID: <20100205163857.GJ22747@atomide.com>
References: <1263190802-1101-3-git-send-email-hvaibhav@ti.com>
 <notify-1265331939@atomide.com>
 <19F8576C6E063C45BE387C64729E7394044A775FEA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54471 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0BEQi2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 11:38:28 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A775FEA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [100204 21:31]:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Friday, February 05, 2010 6:35 AM
> > To: linux-omap@vger.kernel.org
> > Subject: [APPLIED] [PATCH 2/4-V1] AM3517: Enable TSC2004 driver
> > support for AM3517EVM
> > 
> > This patch has been applied to the linux-omap
> > by youw fwiendly patch wobot.
> > 
> [Hiremath, Vaibhav] Tony,
> 
> Please revert this single commit. Actually I had a discussion with Dmitry Torokhov and the conclusion is, as of now for TSC2004 we can reuse TSC2007, and once they start diverging we can split them. I will be submitting patches for this support shortly.
> 
> So please revert hits commit.

Yeah noticed that as they did not compile with omap3_defconfig.

Reverted all of them except patch "AM3517: Enable basic I2C Support".

Regards,

Tony
