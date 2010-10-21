From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] omap: am3517: fix build break
Date: Thu, 21 Oct 2010 11:35:42 -0700
Message-ID: <20101021183542.GA17174@kroah.com>
References: <1287652806-1067-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:53056 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754974Ab0JUSkR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Oct 2010 14:40:17 -0400
Content-Disposition: inline
In-Reply-To: <1287652806-1067-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>

On Thu, Oct 21, 2010 at 02:50:06PM +0530, Anand Gadiyar wrote:
> Patch usb-am35x-add-musb-support.patch in greg's USB queue
> adds backan include of <plat/control.h>. This file was renamed
> by another commit in the omap tree and the file was already
> fixed to reflect this.
> 
> Remove this include to fix up a build break.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> Build break observed with linux-next as of 20101021.
> 
> Greg, okay with me to fold this into the original patch
> if the others in copy agree. It's a trivial enough change.

I've folded it in with the original patch.

thanks,

greg k-h
