From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] usb: musb: get rid of MUSB_LOGLEVEL and use parameter
Date: Sun, 10 Aug 2008 20:56:51 +0300
Message-ID: <20080810175650.GI7574@frodo>
References: <1218370846-9312-1-git-send-email-me@felipebalbi.com> <20080810175319.GA24358@suse.de>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36318 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYHJR47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Aug 2008 13:56:59 -0400
Content-Disposition: inline
In-Reply-To: <20080810175319.GA24358@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Anand Gadiyar <gadiyar@ti.com>, Bryan Wu <bryan.wu@analog.com>, David Brownell <david-b@pacbell.net>

On Sun, Aug 10, 2008 at 10:53:19AM -0700, Greg KH wrote:
> On Sun, Aug 10, 2008 at 03:20:46PM +0300, Felipe Balbi wrote:
> > From: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > We can change debugging level on the fly via
> > /sys/module/musb_hdrc/parameters/debug, there's no
> > need for an extra command in the proc entry.
> 
> Why are there any proc files in this driver?  Drivers should not add
> proc files.  Hm, should have reviewed this code a bit better, sorry...

We needed a quick way to export the testmodes to userland. And it's been
used for that.

> Can you please just remove them all?

Yeah, I'm moving them to debugfs. I can remove everything and later add
only the debugfs if you like.

-- 
balbi
