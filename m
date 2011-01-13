From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] adding gpmc configuration functions, west bridge
 related
Date: Thu, 13 Jan 2011 15:44:28 -0800
Message-ID: <20110113234428.GA17904@kroah.com>
References: <524702.86777.qm@web121609.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:59440 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187Ab1AMXtK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 18:49:10 -0500
Content-Disposition: inline
In-Reply-To: <524702.86777.qm@web121609.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sutharsan Ramamoorthy <sutharsan.ramamoorthy@yahoo.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, david.cross@cypress.com, srmt@cypress.com

On Thu, Jan 13, 2011 at 03:23:14PM -0800, Sutharsan Ramamoorthy wrote:
> This patch implements gpmc configuration functions needed by westbridge
> device controller driver in staging tree. These functions currently 
> implemented in staging tree. This patch is part of the effort to bring 
> westbridge device controller driver out of staging tree.
> 
> Signed-off by: Sutharsan Ramamoorthy <sutharsan.ramamoorthy@yahoo.com>

Close, but not quite.

Why remove your cypress.com email address here?  That's who really is
"signing off" on this patch, right?

Also, please note my previous comments about "lots more needs to be done
to the driver before this can even start to move out of the staging
tree".  Moving these functions should be one of the _last_ things that
happens, not the first.

Please work on cleaning up the code in the drivers/staging/westbridge/
directory first.  When that is all done, _then_ we can start moving it
out.

Ok?

thanks,

greg k-h
