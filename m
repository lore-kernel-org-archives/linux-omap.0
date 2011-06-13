From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Mon, 13 Jun 2011 06:35:43 -0700
Message-ID: <20110613133542.GD3352@atomide.com>
References: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com>
 <201105181539.46959.peter.ujfalusi@ti.com>
 <20110531075701.GN11352@atomide.com>
 <201106081051.27234.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:22872 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752961Ab1FMNfs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jun 2011 09:35:48 -0400
Content-Disposition: inline
In-Reply-To: <201106081051.27234.peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [110608 00:46]:
> Hi Tony,
> 
> On Tuesday 31 May 2011 10:57:02 Tony Lindgren wrote:
> > Sure, but that's the only option we have to merge any new code.
> 
> So this patch will be not taken (even if without this patch OMAP4 McBSP is 
> broken), unless we move the McBSP code out from plat-omap?
> 
> I have discussed with Jarkko, and internally about the mcbsp code move. This 
> will certainly take some time to figure out a sane way to do this.
> To be hones I would be surprised if we can do this for 3.1...

Sure we can merge fixes, but let's get the move done before adding
new features.

Regards,

Tony
