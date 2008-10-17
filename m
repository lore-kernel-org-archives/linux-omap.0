From: Tony Lindgren <tony@atomide.com>
Subject: Re: beagle won't boot.
Date: Fri, 17 Oct 2008 14:12:06 -0700
Message-ID: <20081017211206.GT15820@atomide.com>
References: <E1KquQr-0002qg-Sg@amazonia.comcast.net> <5A47E75E594F054BAF48C5E4FC4B92AB02D5F9A67A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51350 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbYJQVML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:12:11 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02D5F9A67A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "rick@efn.org" <rick@efn.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [081017 12:01]:
> > Hi,
> > 
> >   I got the lastest code on Oct 16 via:
> > 
> > git clone git://source.mvista.com/git/linux-omap-2.6.git
> > cd linux-omap-2.6
> > make omap3_beagle_defconfig
> > make uImage CROSS_COMPILE="arm-angstrom-linux-gnueabi-" CC="ccache arm-angstrom-linux-gnueabi-gcc-4.2.1+csl-arm-2007q3-53" LD="arm-angstrom-linux-gnueabi-ld"
> > 
> >   and it doesn't seem to want to cooperate with my beagleboard.  As
> > far as I can tell, it's stuck in
> > 
> > the while loop in omap_start_ehc().  I think because this bit never
> > got set:
> > 
> > CM_FCLKEN3_CORE->EN_USBTLL (page 472 of the OMAP3 pdf).
> > 
> >   Might have something to do with "usbtll_fck".
> > 
> >   Any help greatly appreciated.
> 
> Quick and simple solution,
> 1. "make menuconfig"
> 2. Go to Device Drivers -> USB Support
> 3. Disable EHCI HCD
> 4. Rebuild and boot
> 
> EHCI doesn't work anyway on beagle. Why bother having it built in in defconfig?
> 
> - Anand
> *Extremely frustrated with EHCI and clock control at the moment*

I've disabled EHCI for now in all board configs.

Tony


> 
> > 
> >   Thanks,
> > 
> >   Rick
> > --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
