From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Thu, 18 Oct 2012 20:44:43 +0200
Message-ID: <20121018184443.GD2350@netboy.at.omicron.at>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43353 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab2JRSo4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 14:44:56 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so5201112wey.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 11:44:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mugunthan V N <mugunthanvnm@ti.com>

On Thu, Oct 18, 2012 at 03:46:15AM +0000, Paul Walmsley wrote:
> 
> Probably the driver was submitted before any SoC integration support was 
> available.  Grepping for 'cpsw' under arch/ turns up only AM33xx.  AM335x 
> didn't have device enumeration support in the mainline kernel until 3.7, 
> via commit a2cfc509bc4eeef9f5c4607b1203f17f22ea2a36 ("ARM: OMAP3+: hwmod: 
> Add AM33XX HWMOD data").  So I don't see how it could have worked with 
> mainline.

...

> But it seems that the CPSW has never worked in the mainline kernel.  So 
> this particular patch is not fixing a regression.  Therefore we shouldn't 
> send it upstream during the -rc time period.  Instead we'll schedule it to 
> be sent a few weeks later, during the 3.8 merge window.

Let's think about this some more:

The driver's commit is from March and is included in v3.4-rc1.

You say it will be working in 3.8, after 3.7 comes out, in about
December.

So how long does it take between merging code and actually getting it
working?

Sorry to harp on this so much, but I try out my patches with the tip
of the appropriate tree before sending them, or when I cannot, at
least I put into the log "compile tested only" or something like that.

Thanks,
Richard
