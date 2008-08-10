From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] usb: musb: get rid of MUSB_LOGLEVEL and use parameter
Date: Sun, 10 Aug 2008 10:53:19 -0700
Message-ID: <20080810175319.GA24358@suse.de>
References: <1218370846-9312-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34077 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbYHJRyE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 10 Aug 2008 13:54:04 -0400
Content-Disposition: inline
In-Reply-To: <1218370846-9312-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Anand Gadiyar <gadiyar@ti.com>, Bryan Wu <bryan.wu@analog.com>, David Brownell <david-b@pacbell.net>

On Sun, Aug 10, 2008 at 03:20:46PM +0300, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> We can change debugging level on the fly via
> /sys/module/musb_hdrc/parameters/debug, there's no
> need for an extra command in the proc entry.

Why are there any proc files in this driver?  Drivers should not add
proc files.  Hm, should have reviewed this code a bit better, sorry...

Can you please just remove them all?

thanks,

greg k-h
