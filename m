From: Tony Lindgren <tony@atomide.com>
Subject: Re: Working with Linux-Omap GIT Tree
Date: Tue, 9 Sep 2008 12:17:56 -0700
Message-ID: <20080909191756.GV29054@atomide.com>
References: <1f11a5490809041150y69023b30ub166cc34615744b5@mail.gmail.com> <A24693684029E5489D1D202277BE894411A86A45@dlee02.ent.ti.com> <1f11a5490809091152j767d9032jecdeeace5b2d40bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57466 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYIITSA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 15:18:00 -0400
Content-Disposition: inline
In-Reply-To: <1f11a5490809091152j767d9032jecdeeace5b2d40bb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Ashwin Bihari <abihari@gmail.com> [080909 11:52]:
> A quick question about the OMAP GIT trees as I'm playing with them
> right now. There are two trees that I can see, one at
> http://git.omapzoom.org/repo/omapkernel and another at
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git.
> The OMAPZoom tree seems to have a few of the files that are missing
> from the git.kernel.org tree that I was looking to modify..
> 
> Which tree should I be using to put my board-support files into? Or is
> it a combination of the two?

Create patches against linux-omap. And hopefully against the mainline
tree soonish.

Tony

> 
> Regards
> 
> On Thu, Sep 4, 2008 at 3:04 PM, Aguirre Rodriguez, Sergio Alberto
> <saaguirre@ti.com> wrote:
> > And one more thing...
> >
> > If you have a driver which was previously including a header like this:
> >
> > #include <arch/arm/clock.h>
> >
> > You have to change it to:
> >
> > #include <mach/clock.h>
> >
> > To point to the new location.
> >
> > Regards,
> > Sergio
> >
> > -----Original Message-----
> > From: Ashwin Bihari [mailto:abihari@gmail.com]
> > Sent: Thursday, September 04, 2008 1:51 PM
> > To: Aguirre Rodriguez, Sergio Alberto
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: Working with Linux-Omap GIT Tree
> >
> > On Thu, Sep 4, 2008 at 2:44 PM, Aguirre Rodriguez, Sergio Alberto
> > <saaguirre@ti.com> wrote:
> >> Hi Ashwin,
> >>
> >> The folder you're looking for has been moved to arch/arm/plat-omap/include/
> >>
> >> This has to have the same contents you had in that version + the following changes to them.
> >>
> >> Hope this helped you.
> >>
> >> Regards,
> >> Sergio
> >
> > Hi Sergio,
> >
> > Thanks for the pointer on the move. I should've spent more time poking
> > around the trees I guess. Sorry for the noise..
> >
> > ~ Ashwin
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
