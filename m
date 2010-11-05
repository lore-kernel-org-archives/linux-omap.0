From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: dsp: remove shm from normal memory
Date: Fri, 5 Nov 2010 11:16:36 -0700
Message-ID: <20101105181636.GP9264@atomide.com>
References: <1287473844-6228-1-git-send-email-felipe.contreras@gmail.com>
 <1287473844-6228-2-git-send-email-felipe.contreras@gmail.com>
 <20101105163417.GI9264@atomide.com>
 <AANLkTi=4cT=JByCHmRiHBimoN55Kidt+deUhQLozGvez@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51645 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab0KESQ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 14:16:57 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=4cT=JByCHmRiHBimoN55Kidt+deUhQLozGvez@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>

* Felipe Contreras <felipe.contreras@gmail.com> [101105 10:44]:
> On Fri, Nov 5, 2010 at 6:34 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Felipe Contreras <felipe.contreras@gmail.com> [101019 00:28]:
> >> Also, don't be picky about the location.
> >
> > As this code is in CONFIG_TIDSPBRIDGE block and AFAIK that is
> > not working, this should probably wait for the next merge window?
> 
> I plan to send a patch to revert the iommu changes to staging so that
> it does work... But this patch would be needed as well.

OK. Let's wait and see what your minimal set of fixes to make it
work looks.

Regards,

Tony
