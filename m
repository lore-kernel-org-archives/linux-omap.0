From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] OMAPDSS: use DSI_FIFO_BUG workaround only for manual
 update displays
Date: Wed, 11 Jul 2012 08:46:02 -0700
Message-ID: <20120711154602.GA29122@kroah.com>
References: <1340272426-537-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44964 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab2GKPqG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 11:46:06 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so2176246pbb.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 08:46:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340272426-537-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: stable@vger.kernel.org, linux-omap@vger.kernel.org, Joe Woodward <jw@terrafix.co.uk>

On Thu, Jun 21, 2012 at 12:53:46PM +0300, Tomi Valkeinen wrote:
> This is a fix for v3.4 stable kernel. Mainline commit is
> 3568f2a46f2a73bab18c914df06afd98a97e0e0e. As a clarification to the original
> commit description below: when the bug happens the display does not show
> anything.

Now applied, thanks.

greg k-h
