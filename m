From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ARM: multi_v7: Enabled omap4430 sdp nfsroot
Date: Mon, 22 Jul 2013 19:47:39 -0700
Message-ID: <20130723024739.GB15637@quad.lixom.net>
References: <20130715075816.GN7656@atomide.com>
 <20130715132326.GA12025@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:37085 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab3GWCrh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 22:47:37 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so7756849pab.31
        for <linux-omap@vger.kernel.org>; Mon, 22 Jul 2013 19:47:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130715132326.GA12025@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Mon, Jul 15, 2013 at 04:23:26PM +0300, Felipe Balbi wrote:
> On Mon, Jul 15, 2013 at 12:58:17AM -0700, Tony Lindgren wrote:
> > Author: Tony Lindgren <tony@atomide.com>
> > Date:   Mon Jul 15 00:39:41 2013 -0700
> > 
> >     ARM: multi_v7: Enabled omap4430 sdp nfsroot
> >     
> >     By adding support for OCP2SCP, SPI and KS8851 I can also boot test
> >     multi_v7_defconfig easily.
> >     
> >     Note that if using an older u-boot, CONFIG_ARM_ATAG_DTB_COMPAT=y
> >     may also be needed for the appended DTB based booting.
> >     
> >     Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> We will also use OCP2SCP driver to enable USB3 on OMAP5 uEVM, good it's
> already enabled in multi_v7 after this patch.
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Applied to fixes for 3.11 since it gives us networking on panda.


-Olof
