From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: OMAP camera with BT-656 sensor
Date: Mon, 27 Jul 2009 15:14:52 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A16F0AC@dlee02.ent.ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50538 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522AbZG0ULR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 16:11:17 -0400
In-Reply-To: <4A6E070B.8090203@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Gary Thomas [mailto:gary@mlbassoc.com]
> Sent: Monday, July 27, 2009 2:59 PM
> To: Aguirre Rodriguez, Sergio Alberto
> Cc: linux-omap@vger.kernel.org
> Subject: Re: OMAP camera with BT-656 sensor
> 
> Aguirre Rodriguez, Sergio Alberto wrote:
> >
> >> -----Original Message-----
> >> From: Gary Thomas [mailto:gary@mlbassoc.com]
> >> Sent: Monday, July 27, 2009 2:11 PM
> >> To: Aguirre Rodriguez, Sergio Alberto
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: OMAP camera with BT-656 sensor
>    ... snip
> 
> >> Bottom line, I'm confused as to how I should go about getting
> >> my driver/system working.  Do I use your work, or just stick
> >> with the PSP base (why?)??
> >
> > What I do feel is that the PSP base will fulfill better your immediate
> needs, but in the future, as I'm getting aware of Vaibhav changes, I'll be
> interested in making them part of my tree aswell, so Vaibhav could avoid
> rebasing the BT646 support internally everytime...
> 
> Is there a GIT tree for this?

AFAIK, this is the latest tree Vaibhav is exposing:

http://arago-project.org/git/people/vaibhav/ti-psp-omap-video.git

He maintains a camera and a DSS2 branch exactly to make both work on his 3530EVM.

> 
> A [hopefully] minor complication is that I'm using Tomi's DSS2
> tree for the base of my port.  How can I move/merge the PSP
> based support into it?  Can I just pick up the whole drivers/media
> subtree and put in in place of what I have?

I recommend looking at the git tree above... I think that job is already done...

> 
> Thanks for your help - this myriad of trees and very disparate
> support levels is really confusing to those of us on the outside...

I know, and the lack of proper documentation is one of the first issues for me to look at...

You're welcome.
> 
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------

