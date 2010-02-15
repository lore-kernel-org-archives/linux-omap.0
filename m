From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3evm: Doesn't boot at 4fa42e46
Date: Mon, 15 Feb 2010 20:56:24 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E274EF74@dbde02.ent.ti.com>
References: <20100210173401.GV21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48412 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755638Ab0BOP0b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 10:26:31 -0500
In-Reply-To: <20100210173401.GV21755@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Wednesday, February 10, 2010 11:04 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: omap3evm: Doesn't boot at 4fa42e46
> 
> * Premi, Sanjeev <premi@ti.com> [100210 09:09]:
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org 
> > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Premi, Sanjeev
> > > Sent: Tuesday, February 09, 2010 9:34 PM
> > > To: linux-omap@vger.kernel.org
> > > Subject: RE: omap3evm: Doesn't boot at 4fa42e46
> > > 
> > > > -----Original Message-----
> > > > From: linux-omap-owner@vger.kernel.org 
> > > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> > > Premi, Sanjeev
> > > > Sent: Tuesday, February 09, 2010 9:02 PM
> > > > To: linux-omap@vger.kernel.org
> > > > Subject: omap3evm: Doesn't boot at 4fa42e46
> > > > 
> > > > Hi all,
> > > > 
> > > > Just updated my repo to the commit:
> > > > 
> > > > commit 4fa42e4679324b0e3c54fb509535eea3923ccb63
> > > > Merge: e599f12 c446167
> > > > Author: Tony Lindgren <tony@atomide.com>
> > > > Date:   Thu Feb 4 20:07:44 2010 -0800
> > > > 
> > > > The kernel builds fine; but doesn't boot on the OMAP3EVM.
> > > > 
> > > > I have been able to trace the code until rest_init(); but 
> > > > will need to restart debugging.
> > > > There seems to be an exception during execution.
> > > > 
> > > > Will continue to dig further. This is just an FYI.
> > > > 
> > > 
> > > The kernel panics during I2C init in function omap3_evm_i2c_init()
> > > during this call:
> > > 
> > >     omap_register_i2c_bus(2, 400, NULL, 0);
> > > 
> > > I see that there isn't any difference between omap3_evm_i2c_init()
> > > and omap3430_i2c_init(). Has anyone tried the booting 3430SDP at
> > > this commit?
> > > 
> > > ...just trying to understand if this is a board specific issue
> > > OR is it a generic OMAP3 issue before I try bisect.
> > > 
> > > ~sanjeev
> > 
> > uImage created with omap3_defconfig at the HEAD boots fine on the
> > EVM. I couldn't find much differences between this defconfig and
> > my .config - related to i2c where the failure occurs.
> 
> Maybe post the diff -u of the configs?
>  
> > Unfortunately bisect didn't help much :( I just know the last
> > commit where the EVM boots fine (with defconfig).
> > 
> >   9b17b59 : Add devkit8000_defconfig
> > 
> > Just a snapshot of git-bisect from my command history:
> > 
> > premi # git-bisect bad f9ffaa9
> > Some good revs are not ancestor of the bad rev.
> > git bisect cannot work properly in this case.
> > Maybe you mistake good and bad revs?
> > premi #
> > premi # history | grep bisect | grep good
> >    512  git-bisect good c6348aa
> >    518  git-bisect good a9861b5
> >    523  git-bisect good 9b17b59
> > premi #
> > premi # history | grep bisect | grep bad
> >    507  git-bisect bad 4fa42e4
> >    533  git-bisect bad 0b421ec
> >    538  git-bisect bad fc76be4
> >    543  git-bisect bad 66ddfc6
> >    547  git-bisect bad f9ffaa9
> > premi #
> 
> Can you try bisecting the omap for-next branch starting at
> 9ba874506b7b3883d78b8cad61eba39c4bb09885?
> 
> If 9ba874506b7b3883d78b8cad61eba39c4bb09885 does not boot,
> then you have to start at 4f4e65d2484811210a2826fa9d59712c7fcf1b49.

Had to step away from the problem fore few days. Started bisecting now.

~sanjeev

> 
> Otherwise you'll end up bisecting all kinds of merges..
> 
> Regards,
> 
> Tony
> 