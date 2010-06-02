From: Tony Lindgren <tony@atomide.com>
Subject: Re: beagleboard expansion boards, was Trying to understand how to
 use new OMAP mux code
Date: Wed, 2 Jun 2010 16:57:10 +0300
Message-ID: <20100602135709.GK5980@atomide.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
 <20100311224812.GU2900@atomide.com>
 <4C062DD4.2050701@cioinfoindus.fr>
 <20100602112130.GG5980@atomide.com>
 <20100602144606.4287c438.jhnikula@gmail.com>
 <3BC7A992-11AB-4EBF-B7A5-4C4B1498CC58@student.utwente.nl>
 <20100602161418.c6af218b.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51275 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757974Ab0FBN5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 09:57:21 -0400
Content-Disposition: inline
In-Reply-To: <20100602161418.c6af218b.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, Laurent Epinat <laurent.epinat@cioinfoindus.fr>, linux-omap@vger.kernel.org

* Jarkko Nikula <jhnikula@gmail.com> [100602 16:06]:
> On Wed, 2 Jun 2010 14:56:30 +0200
> Koen Kooi <koen@dominion.thruhere.net> wrote:
> 
> > > How about add-on cards for e.g. BeagleBoard? It would be nice feature
> > > if a kernel module for that particular add-on card can do the muxing
> > > without needing to specify them on cmdline. I.e. if you are switching
> > > between cards there is no need to figure out new cmdline for each of
> > > them. For me even "rootwait" is sometimes too difficult to remember :-)
> > 
> > What we (as in beagleboard.org) are currently doing is this:
> > 
> > u-boot:
> > 
> > http://gitorious.org/beagleboard-validation/u-boot/commit/70ed67cacbb1b7158e059b9b5d10308cce2d917a
> > http://gitorious.org/beagleboard-validation/u-boot/commit/74f700341c656e1636221a53347caccbfc07c224
> > 
> > kernel:
> > 
> > http://gitorious.org/beagleboard-validation/linux/commit/32fb278553a4cd6126c1791d70aa33df12f73d90
> > 
> > It's very ugly and needs a rethink before it can get posted to here, but it works great! The plan is to do this as part of the patchset to add support for the 37xx based beagleboardXM.
> > 
> Problem is that amount of expansion boards is practically unlimited so
> patching bootloader and board file could come quite maintenance effort.
> 
> Of course there are some lets say generic boards but bunch of in-house,
> DIY, etc. boards and there is no point to patch common bootloader and
> kernel board files because of them.

Just saveenv the kernel cmdline options in u-boot?

Tony
