From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH v3] OMAP: Fix for bus width which improves SD card's peformance.
Date: Tue, 6 Apr 2010 11:16:01 -0500
Message-ID: <003901cad5a4$730264d0$544ff780@am.dhcp.ti.com>
References: <004701caab40$68b576e0$544ff780@am.dhcp.ti.com> <x2q7f9d1ffb1003302307nb8e91be0o55da59c3375f1720@mail.gmail.com> <v2yce9ab5791003302327hc67deb3akc7d18146534038f9@mail.gmail.com> <h2p7f9d1ffb1003310003z508e21dbqe37b6e1cad425866@mail.gmail.com> <003b01cad0f0$6ea78040$544ff780@am.dhcp.ti.com> <g2s7f9d1ffb1003312331o149df218g651c3e4349ac9a77@mail.gmail.com> <003c01cad1b1$da2cdbf0$544ff780@am.dhcp.ti.com> <m2n7f9d1ffb1004050556o1ed2eec8ief66d60fc85f96de@mail.gmail.com> <20100405164839.GB17388@gandalf> <007c01cad4e4$26c5a700$544ff780@am.dhcp.ti.com> <20100406050035.GA32537@gandalf>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43888 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755845Ab0DFQQM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Apr 2010 12:16:12 -0400
In-Reply-To: <20100406050035.GA32537@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: 'kishore kadiyala' <kishorek.kadiyala@gmail.com>, 'Vimal Singh' <vimal.newwork@gmail.com>, tony@atomide.com, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.lavinen@nokia.com



> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com]
> Sent: Tuesday, April 06, 2010 12:01 AM
> To: Madhusudhan
> Cc: me@felipebalbi.com; 'kishore kadiyala'; 'Vimal Singh';
> tony@atomide.com; svenkatr@ti.com; linux-omap@vger.kernel.org; linux-
> kernel@vger.kernel.org; jarkko.lavinen@nokia.com
> Subject: Re: [PATCH v3] OMAP: Fix for bus width which improves SD card's
> peformance.
> 
> Hi,
> 
> On Mon, Apr 05, 2010 at 12:19:29PM -0500, Madhusudhan wrote:
> > Since the first if command already checks for the 8-bit the second check
> > like >= 4 is definitely not readable in my opinion.
> 
> how come ???
> 
> > Functionally do you see anything wrong with this patch??
> 
> functionally no, but (hypothetical situation) and if on
> omap4/5/6/whatever, omap controller supports a bigger bus width then
> you'll have to add a line like:
> 
> +	if (mmc_slot(host).wires == 16)
> +		mmc->caps |= (MMC_CAP_16_BIT_DATA | MMC_CAP_8_BIT_DATA |
> +				MMC_CAP_4_BIT_DATA);
> -	if (mmc_slot(host).wires == 8)
> +	else if (mmc_slot(host).wires == 8)
> 
> do you see the problem ?? In my opinion it doesn't scale well.
> 

The point we should note here is that MMC spec supports a max bus width of
8-bit. So anything beyond 8-bit is not in the picture as of today.

But, my bad on miss interpreting the snippet Felipe sent earlier.

if (mmc_slot(host).wires >= 8)
	mmc->caps |= MMC_CAP_8_BIT_DATA;
if (mmc_slot(host).wires >= 4)
	mmc->caps |= MMC_CAP_4_BIT_DATA;

I missed the fact that you removed the setting of 4-bit from the first
check.

I am okay with the above snippet as it is a trivial change that we are
trying to patch here which fixes an important issue.

Regards,
Madhu
> --
> balbi

