From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP camera with BT-656 sensor
Date: Tue, 28 Jul 2009 09:44:30 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940432A6DC5D@dbde02.ent.ti.com>
References: <a187869d0907270546m2be3542cla72366acfc62fb64@mail.gmail.com>
	 <a187869d0907270725n7fce759bs6bcaeed70bd7f872@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16EC65@dlee02.ent.ti.com>
	 <a187869d0907270859l313b86d3nea833c7a019d35be@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16ECD1@dlee02.ent.ti.com>
	 <a187869d0907270911j74ee55b9nc872687eb32aecce@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16ED18@dlee02.ent.ti.com>
	 <a187869d0907271036meb56ce9r32c5f5e823465e87@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16EE88@dlee02.ent.ti.com>
	 <a187869d0907271145i177dcf52jb75aee758300878@mail.gmail.com>
 <a187869d0907271146q66112fc8l85aa37c8b1512d68@mail.gmail.com>
 <4A6DFBBE.6020805@mlbassoc.com>
 <A24693684029E5489D1D202277BE89444A16F057@dlee02.ent.ti.com>
 <4A6E070B.8090203@mlbassoc.com>
 <A24693684029E5489D1D202277BE89444A16F0AC@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59577 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbZG1EOj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jul 2009 00:14:39 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444A16F0AC@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aguirre Rodriguez, Sergio
> Alberto
> Sent: Tuesday, July 28, 2009 1:45 AM
> To: Gary Thomas
> Cc: linux-omap@vger.kernel.org
> Subject: RE: OMAP camera with BT-656 sensor
> 
> 
> 
> > -----Original Message-----
> > From: Gary Thomas [mailto:gary@mlbassoc.com]
> > Sent: Monday, July 27, 2009 2:59 PM
> > To: Aguirre Rodriguez, Sergio Alberto
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: OMAP camera with BT-656 sensor
> >
> > Aguirre Rodriguez, Sergio Alberto wrote:
> > >
> > >> -----Original Message-----
> > >> From: Gary Thomas [mailto:gary@mlbassoc.com]
> > >> Sent: Monday, July 27, 2009 2:11 PM
> > >> To: Aguirre Rodriguez, Sergio Alberto
> > >> Cc: linux-omap@vger.kernel.org
> > >> Subject: OMAP camera with BT-656 sensor
> >    ... snip
> >
> > >> Bottom line, I'm confused as to how I should go about getting
> > >> my driver/system working.  Do I use your work, or just stick
> > >> with the PSP base (why?)??
> > >
> > > What I do feel is that the PSP base will fulfill better your
> immediate
> > needs, but in the future, as I'm getting aware of Vaibhav changes,
> I'll be
> > interested in making them part of my tree aswell, so Vaibhav could
> avoid
> > rebasing the BT646 support internally everytime...
> >
> > Is there a GIT tree for this?
> 
> AFAIK, this is the latest tree Vaibhav is exposing:
> 
> http://arago-project.org/git/people/vaibhav/ti-psp-omap-video.git
> 
> He maintains a camera and a DSS2 branch exactly to make both work on
> his 3530EVM.
> 
[Hiremath, Vaibhav] Thanks Sergio for taking this up. Just to add on top of Sergio's comments, the current status of above tree is, DSS2 is already merged to latest kernel (Even on PM branch) baseline.

http://arago-project.org/git/people/?p=vaibhav/ti-psp-omap-video.git;a=shortlog;h=refs/heads/ti_display

http://arago-project.org/git/people/?p=vaibhav/ti-psp-omap-video.git;a=shortlog;h=refs/heads/pm


The next PSP release will contain 2.6.31(PM) + DSS2 + Camera + Resizer modules together in one release. I have started with Camera modules merging on top of 2.6.31 + DSS2; hopefully I should be able to complete this by next week (provided that I don't get any interrupts)

You should be looking to Arago tree for all the developments which I do under Arago.

Please let me know if you have any issues/doubts OR if you are looking for some quick solutions.

Thanks,
Vaibhav

> >
> > A [hopefully] minor complication is that I'm using Tomi's DSS2
> > tree for the base of my port.  How can I move/merge the PSP
> > based support into it?  Can I just pick up the whole drivers/media
> > subtree and put in in place of what I have?
> 
> I recommend looking at the git tree above... I think that job is
> already done...
> 
> >
> > Thanks for your help - this myriad of trees and very disparate
> > support levels is really confusing to those of us on the
> outside...
> 
> I know, and the lack of proper documentation is one of the first
> issues for me to look at...
> 
> You're welcome.
> >
> > --
> > ------------------------------------------------------------
> > Gary Thomas                 |  Consulting for the
> > MLB Associates              |    Embedded world
> > ------------------------------------------------------------
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

