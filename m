From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 06/07] usb: rework musb suspend()/resume_early()
Date: Wed, 24 Jun 2009 13:34:58 -0700
Message-ID: <20090624203458.GB28516@suse.de>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se> <20090624092400.14276.94490.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51213 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754472AbZFXU4r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Jun 2009 16:56:47 -0400
Content-Disposition: inline
In-Reply-To: <20090624092400.14276.94490.sendpatchset@rx1.opensource.se>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, linux-usb@vger.kernel.org, akpm@linux-foundation.org, rjw@sisk.pl, stern@rowland.harvard.edu, ben-linux@fluff.org, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, felipe.balbi@nokia.com

On Wed, Jun 24, 2009 at 06:24:00PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch reworks platform driver power management code
> for musb from legacy callbacks to dev_pm_ops.
> 
> The callbacks are converted for CONFIG_SUSPEND like this:
>   suspend() -> suspend()
>   resume_early() -> resume_noirq()
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Untested but compiles fine.
> 
>  drivers/i2c/busses/i2c-pxa.c |   25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> --- 0001/drivers/usb/musb/musb_core.c

I think you need to look at the tools you used to create this series,
the diffstat doesn't seem to match up here :)

thanks,

greg k-h
