From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/5] staging: tidspbridge: for 3.9
Date: Mon, 21 Jan 2013 12:49:21 +0300
Message-ID: <20130121094921.GT4584@mwanda>
References: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
 <20130118004746.GA8897@kroah.com>
 <20130121072524.GR4584@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:27773 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3AUJtd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 04:49:33 -0500
Content-Disposition: inline
In-Reply-To: <20130121072524.GR4584@mwanda>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, Chen Gang <gang.chen@asianux.com>, linux-omap@vger.kernel.org

On Mon, Jan 21, 2013 at 10:25:24AM +0300, Dan Carpenter wrote:
> On Thu, Jan 17, 2013 at 04:47:46PM -0800, Greg Kroah-Hartman wrote:
> > On Thu, Jan 10, 2013 at 03:36:57AM -0600, Omar Ramirez Luna wrote:
> > > Patches for staging-next, fixing comments and suggestions provided
> > > by Chen Gang.
> > > 
> > > There is an additional scm patch, that removes hardcoded defines
> > > related to direct register handling for SCM, it was dependent on
> > > changes that already made it to mainline.
> > 
> > What is the status on getting this out of the staging tree?  What needs
> > to be done still?
> > 
> 
> Why can't tidspbridge be built as a module?
> 
> The Kconfig help files aren't very informative.

Huh.  Ignore me.  I don't know what I was looking at before.  Both
the things I said were wrong.

Sorry for the noise.

regards,
dan carpenter

