From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: omap-serial: fix signess error
Date: Tue, 12 Oct 2010 13:21:05 -0700
Message-ID: <20101012202105.GW25462@atomide.com>
References: <1286731715-17908-1-git-send-email-segooon@gmail.com>
 <8739sb1cif.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60147 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab0JLUVK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Oct 2010 16:21:10 -0400
Content-Disposition: inline
In-Reply-To: <8739sb1cif.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vasiliy Kulikov <segooon@gmail.com>, kernel-janitors@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [101012 11:30]:
> [adding linux-omap list]
> 
> Vasiliy Kulikov <segooon@gmail.com> writes:
> 
> > "ret" is unsigned, so check for (ret < 0) made no sense.
> > Made it signed.
> >
> > Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
> > ---
> >  I cannot compile this driver, so it is not tested.
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Since the original driver is being queued via the omap tree, we can
> queue this one as well.
> 
> Tony, can you add this one to the 2.6.37 queue?

Thanks, adding into omap-for-linus.

Regards,

Tony
