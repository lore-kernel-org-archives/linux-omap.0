From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: tidspbridge in drivers/staging
Date: Sun, 22 Apr 2012 15:19:53 -0700
Message-ID: <20120422221953.GA21320@kroah.com>
References: <20120422095717.GA25053@n2100.arm.linux.org.uk>
 <4f946a04b4288_274134788452074@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36777 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab2DVWT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Apr 2012 18:19:57 -0400
Received: by pbcun15 with SMTP id un15so3140572pbc.19
        for <linux-omap@vger.kernel.org>; Sun, 22 Apr 2012 15:19:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4f946a04b4288_274134788452074@nysa.mail>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, =?iso-8859-1?Q?V=EDctor_Manuel_J=E1quez?= Leal <vjaquez@igalia.com>

On Sun, Apr 22, 2012 at 11:28:52PM +0300, Felipe Contreras wrote:
> Hi,
> 
> Russell King - ARM Linux wrote:
> > I've noticed these failure from time to time in my omap4 randconfig builds:
> > 
> > drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_start':
> > drivers/staging/tidspbridge/core/tiomap3430.c:425: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'
> > drivers/staging/tidspbridge/core/wdt.c: In function 'dsp_wdt_init':
> > drivers/staging/tidspbridge/core/wdt.c:56: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'
> > 
> > Looking at git, it looks like there is some activity with tidspbridge
> > (by V??ctor).  Is there any interest in fixing these errors for v3.4
> > (or even v3.4-rc5)?
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Tony asked us to take a look last Friday. I sent him a simple patch right away
> that fixes the build for me. There's also a patch from Omar.

I have one patch from Omar that handles the ioremap stuff in my queue,
I'll apply it this week.

> I wonder why the list wasn't among the receipients. Well, here they are:

<snip>

If you don't send patches to me, how will they ever get merged?  It
seems to me that now that the driver is in the kernel.org tree, no one
is willing to spend the time to get it out of staging.  Note, that
unless it starts to show real progress to get merged out of staging, I'm
going to have to delete it from the tree.

So, someone better step up...

greg k-h
