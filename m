From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/2] ARM : OMAP4 : MUSB : Add USB support to 4430
 SDP board file
Date: Mon, 1 Feb 2010 14:17:21 -0800
Message-ID: <20100201221721.GF22747@atomide.com>
References: <1262265782-17672-1-git-send-email-x0082077@ti.com>
 <20100128194627.GH6647@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54263 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab0BAWRF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 17:17:05 -0500
Content-Disposition: inline
In-Reply-To: <20100128194627.GH6647@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Maulik Mankad <x0082077@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, David Brownell <david-b@pacbell.net>, Greg Kroah-Hartman <gregkh@suse.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Olof Johansson <olof@lixom.net>

* Felipe Balbi <felipe.balbi@nokia.com> [100128 11:46]:
> On Thu, Dec 31, 2009 at 02:23:02PM +0100, ext Maulik Mankad wrote:
> >ARM : OMAP4 : Add USB support to 4430 SDP board file
> >
> >This patch adds support for Mentor USB to 4430 SDP board
> >file.
> >
> >It also defines the base address for HS USB OTG controller
> >in OMAP4.
> >
> >Also updates platform specfic structure with base address
> >and IRQ details.
> >
> >Signed-off-by: Maulik Mankad <x0082077@ti.com>
> >Cc: Tony Lindgren <tony@atomide.com>
> >Cc: Felipe Balbi <felipe.balbi@nokia.com>
> >Cc: David Brownell <david-b@pacbell.net>
> >Cc: Greg Kroah-Hartman <gregkh@suse.de>
> >Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> >Cc: Olof Johansson <olof@lixom.net>
> 
> I'm ok with this patch, want to hear from Tony.

Looks good to me.
 
> Tony do you have any comment for this patch ? Will you take it or
> should Greg take it ? I believe it's better to come through your
> tree.

I can take them if you prefer that. If you want me to queue this
stuff, can you please pile all the arch/arm/*omap*/ USB patches
into a git branch for me against 2.6.33-rc6?

Regards,

Tony
