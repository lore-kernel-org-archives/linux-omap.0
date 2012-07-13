From: Tony Lindgren <tony@atomide.com>
Subject: Re: dtb for pandaboard
Date: Thu, 12 Jul 2012 23:57:00 -0700
Message-ID: <20120713065700.GK1122@atomide.com>
References: <20120708173259.592552c1@pegasus.ausil.us>
 <20120709090848.GD1122@atomide.com>
 <20120710181119.27faf235@pegasus.ausil.us>
 <20120711074232.GE1122@atomide.com>
 <20120711084855.5887c9ea@pegasus.ausil.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:43386 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab2GMG5F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 02:57:05 -0400
Content-Disposition: inline
In-Reply-To: <20120711084855.5887c9ea@pegasus.ausil.us>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dennis Gilmore <dennis@ausil.us>
Cc: linux-omap@vger.kernel.org

* Dennis Gilmore <dennis@ausil.us> [120711 06:53]:
> On Wed, 11 Jul 2012 00:42:33 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> > 
> > Sounds like it's some kind of issue with dtb getting overwritten
> > by something. We had an issue where kernel BSS was overlapping dtb
> > in some cases, but those should be fixed.
> 
> seems that they are not all fixed appending the dtb allows me to boot i
> could try loading the dtb at a different address. 

OK sounds like that's the issue then, hopefully moving the dtb around
helps.
 
> > Maybe try to leave out ARCH_OMAP2 and ARCH_OMAP3 and maybe CONFIG_NET
> > from your .config to make the kernel smaller and see if that makes
> > a difference?
> > 
> > If that works, then moving the dtb address in uEnv.txt should help.
> > 
> > Also, please check if the same issue happens with appended dtb:
> with the appended dtb image im back to where i was not using a dtb file
> at all.  that is that omap is not being autoloaded. and the sdcard so
> rootfs never shows up.  i get dropped to a dracut rescue shell where if
> i manually modprobe omap  nothing is happening. 

If the SD card is not detected with appended dtb either, the card
voltages may not be supported. I believe Rajendra mentioned in some
mail that we're still missing some voltage settings for the DT case
for omap_hsmmc.c. In that case the card should work for the non-DT
booting though.

Regards,

Tony
