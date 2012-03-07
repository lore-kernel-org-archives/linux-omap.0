From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/7] OMAPDSS: HDMI: hot plug detect fix
Date: Wed, 7 Mar 2012 12:01:46 -0800
Message-ID: <20120307200146.GA26451@kroah.com>
References: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
 <1330604795-29156-8-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51252 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932142Ab2CGUBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 15:01:51 -0500
Received: by gghe5 with SMTP id e5so2407174ggh.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 12:01:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1330604795-29156-8-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: stable@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Rob Clark <rob@ti.com>

On Thu, Mar 01, 2012 at 02:26:35PM +0200, Tomi Valkeinen wrote:
> From: Rob Clark <rob@ti.com>
> 
> The "OMAPDSS: HDMI: PHY burnout fix" commit switched the HDMI driver
> over to using a GPIO for plug detect.  Unfortunately the ->detect()
> method was not also updated, causing HDMI to no longer work for the
> omapdrm driver (because it would actually check if a connection was
> detected before attempting to enable display).
> 
> Signed-off-by: Rob Clark <rob@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

You forgot to tell me what the git commit id is for this patch (it's
ca888a7958b3d808e4efd08ceff88913f4212c69, right?)

And why isn't this needed for the 3.0 kernel as well?

thanks,

greg k-h
