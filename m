From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [APPLIED] [PATCH 2/4-V1] AM3517: Enable TSC2004 driver support
 for AM3517EVM
Date: Wed, 10 Feb 2010 14:50:34 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A96D51E@dbde02.ent.ti.com>
References: <1263190802-1101-3-git-send-email-hvaibhav@ti.com>
 <notify-1265331939@atomide.com>
 <19F8576C6E063C45BE387C64729E7394044A775FEA@dbde02.ent.ti.com>
 <20100205163857.GJ22747@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58899 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657Ab0BJJUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 04:20:41 -0500
In-Reply-To: <20100205163857.GJ22747@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, February 05, 2010 10:09 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [APPLIED] [PATCH 2/4-V1] AM3517: Enable TSC2004 driver
> support for AM3517EVM
> 
> * Hiremath, Vaibhav <hvaibhav@ti.com> [100204 21:31]:
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > > Sent: Friday, February 05, 2010 6:35 AM
> > > To: linux-omap@vger.kernel.org
> > > Subject: [APPLIED] [PATCH 2/4-V1] AM3517: Enable TSC2004 driver
> > > support for AM3517EVM
> > >
> > > This patch has been applied to the linux-omap
> > > by youw fwiendly patch wobot.
> > >
> > [Hiremath, Vaibhav] Tony,
> >
> > Please revert this single commit. Actually I had a discussion with
> Dmitry Torokhov and the conclusion is, as of now for TSC2004 we can
> reuse TSC2007, and once they start diverging we can split them. I
> will be submitting patches for this support shortly.
> 
> >
> > So please revert hits commit.
> 
> Yeah noticed that as they did not compile with omap3_defconfig.
> 
> Reverted all of them except patch "AM3517: Enable basic I2C
> Support".
> 
[Hiremath, Vaibhav] Tony,
The issue was only with TSC2004 support patch, all other patches should go in, since the driver is already being supported in Linux kernel, it was just hookup part.

So can you please merge all other patches expect TSC2004 support?

Thanks,
Vaibhav
> Regards,
> 
> Tony
