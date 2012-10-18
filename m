From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Thu, 18 Oct 2012 05:06:54 +0200
Message-ID: <20121018030654.GE2867@netboy.at.omicron.at>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37791 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab2JRDHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 23:07:06 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1478602wib.1
        for <linux-omap@vger.kernel.org>; Wed, 17 Oct 2012 20:07:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121017235045.GB30550@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mugunthan V N <mugunthanvnm@ti.com>

On Wed, Oct 17, 2012 at 04:50:46PM -0700, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [121017 16:39]:
> > Hi Richard
> > 
> > On Wed, 17 Oct 2012, Richard Cochran wrote:
> > 
> > > Would you please take this bugfix for 3.7-rc2? The suggestion to mail
> > > you came from Toni Lindgren. The context where it came from is here:
> > > 
> > > http://lists.arm.linux.org.uk/lurker/message/20121015.191630.bdae3c50.en.html
> > 
> > This patch appears to add a new feature, correct?  I don't think the CPSW 
> > could have worked in the past without this data present.  So it looks to 
> > me like this is 3.8 material, unless Tony would like it to go in sooner?
> 
> Yeah unless it fixes something, we should just queue it for v3.8 merge
> window.

So there has been this cpsw driver since v3.4-rc1~177^2~5

   df82859 netdev: driver: ethernet: Add TI CPSW driver

and four people signed off on it, so it must have been working at one
point. Since the device tree make-over, the driver is a derelict, and
thus the present patch is fixing a regression.

I just want the already merged driver to work with the vanilla
kernel. Is that too much to ask?

Thanks,
Richard
