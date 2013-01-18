From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] staging: tidspbridge: for 3.9
Date: Thu, 17 Jan 2013 18:01:22 -0800
Message-ID: <20130118020122.GB15361@atomide.com>
References: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
 <20130118004746.GA8897@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59558 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752776Ab3ARCB1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jan 2013 21:01:27 -0500
Content-Disposition: inline
In-Reply-To: <20130118004746.GA8897@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Omar Ramirez Luna <omar.ramirez@copitl.com>, devel@driverdev.osuosl.org, Chen Gang <gang.chen@asianux.com>, linux-omap@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [130117 16:51]:
> On Thu, Jan 10, 2013 at 03:36:57AM -0600, Omar Ramirez Luna wrote:
> > Patches for staging-next, fixing comments and suggestions provided
> > by Chen Gang.
> > 
> > There is an additional scm patch, that removes hardcoded defines
> > related to direct register handling for SCM, it was dependent on
> > changes that already made it to mainline.
> 
> What is the status on getting this out of the staging tree?  What needs
> to be done still?

Omar, please correct me if I'm wrong. This thing should be reimplemented
using remoteproc AFAIK.

But I doubt that anybody is working on making it happen?

Regards,

Tony
