From: Tony Lindgren <tony@atomide.com>
Subject: Re: beagleboard expansion boards, was Trying to understand how to
 use new OMAP mux code
Date: Wed, 2 Jun 2010 17:45:48 +0300
Message-ID: <20100602144547.GM5980@atomide.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
 <20100311224812.GU2900@atomide.com>
 <4C062DD4.2050701@cioinfoindus.fr>
 <20100602112130.GG5980@atomide.com>
 <20100602144606.4287c438.jhnikula@gmail.com>
 <3BC7A992-11AB-4EBF-B7A5-4C4B1498CC58@student.utwente.nl>
 <20100602161418.c6af218b.jhnikula@gmail.com>
 <20100602135709.GK5980@atomide.com>
 <20100602171427.5024be97.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50902 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468Ab0FBOp5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 10:45:57 -0400
Content-Disposition: inline
In-Reply-To: <20100602171427.5024be97.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, Laurent Epinat <laurent.epinat@cioinfoindus.fr>, linux-omap@vger.kernel.org

* Jarkko Nikula <jhnikula@gmail.com> [100602 17:06]:
> On Wed, 2 Jun 2010 16:57:10 +0300
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > > Problem is that amount of expansion boards is practically unlimited so
> > > patching bootloader and board file could come quite maintenance effort.
> > > 
> > > Of course there are some lets say generic boards but bunch of in-house,
> > > DIY, etc. boards and there is no point to patch common bootloader and
> > > kernel board files because of them.
> > 
> > Just saveenv the kernel cmdline options in u-boot?
> > 
> I meant that if kernel module could do muxing then there is no need the
> user to change muxings for different add-on boards.
> 
> Works fine if you have one board but how about when amount of expansion
> boards grow?

Yeah having the modules do the platform device init and registration will
lead into nasty conflicts. The platform device registration really needs
to happen in the board-*.c files, not in the drivers.

Tony
