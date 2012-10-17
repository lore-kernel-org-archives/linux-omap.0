From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Wed, 17 Oct 2012 16:50:46 -0700
Message-ID: <20121017235045.GB30550@atomide.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:43149 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752708Ab2JQXuu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 19:50:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Richard Cochran <richardcochran@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mugunthan V N <mugunthanvnm@ti.com>

* Paul Walmsley <paul@pwsan.com> [121017 16:39]:
> Hi Richard
> 
> On Wed, 17 Oct 2012, Richard Cochran wrote:
> 
> > Would you please take this bugfix for 3.7-rc2? The suggestion to mail
> > you came from Toni Lindgren. The context where it came from is here:
> > 
> > http://lists.arm.linux.org.uk/lurker/message/20121015.191630.bdae3c50.en.html
> 
> This patch appears to add a new feature, correct?  I don't think the CPSW 
> could have worked in the past without this data present.  So it looks to 
> me like this is 3.8 material, unless Tony would like it to go in sooner?

Yeah unless it fixes something, we should just queue it for v3.8 merge
window.

Regards,

Tony
