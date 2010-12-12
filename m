From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH 1/2] staging: tidspbridge: rmgr/node.c code cleanup
Date: Sun, 12 Dec 2010 16:20:29 +0200
Message-ID: <1292163629.2375.5.camel@atlantis.mindbit.ro>
References: <1291931258-30744-1-git-send-email-ionut.nicu@mindbit.ro>
	 <1291931258-30744-2-git-send-email-ionut.nicu@mindbit.ro>
	 <1291933352.23672.52.camel@atlantis.mindbit.ro>
	 <AANLkTikLoNf-NDb6kCQnVHB95zrTKi2f9CU6m_u0A+KB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:53436 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150Ab0LLOUj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Dec 2010 09:20:39 -0500
In-Reply-To: <AANLkTikLoNf-NDb6kCQnVHB95zrTKi2f9CU6m_u0A+KB@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Sapiens Rene <rene.sapiens@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Thu, 2010-12-09 at 17:03 -0600, Ramirez Luna, Omar wrote:
> Hi Ionut,
> 
> On Thu, Dec 9, 2010 at 4:22 PM, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
> > Hi Omar,
> >
> > On Thu, 2010-12-09 at 23:47 +0200, Ionut Nicu wrote:
> >> Reorganized some code in rmgr/node.c to increase its
> >> readability. Most of the changes reduce the code
> >> indentation level and simplifiy the code. No functional
> >> changes were done.
> >
> > <snip>
> >
> >>       /*
> >>        * Check stream mode. Default is STRMMODE_PROCCOPY.
> >>        */
> >> -     if (!status && pattrs) {
> >> -             if (pattrs->strm_mode != STRMMODE_PROCCOPY)
> >> -                     status = -EPERM;        /* illegal stream mode */
> >> -
> >> -     }
> >> -     if (status)
> >> -             goto func_end;
> >> +     if (pattrs && pattrs->strm_mode != STRMMODE_PROCCOPY)
> >> +             return -EPERM;  /* illegal stream mode */
> >>
> >
> > While cleaning up and reviewing the code I saw this check,  which unless
> > it's intentional I think it looks like a bug. See comment below.
> >
> > <snip>
> >> +             strm_mode = pattrs ? pattrs->strm_mode : STRMMODE_PROCCOPY;
> >> +             switch (strm_mode) {
> >> +             case STRMMODE_RDMA:
> >
> > ...
> >
> >> +
> >> +             case STRMMODE_ZEROCOPY:
> >
> > ...
> >
> >> +             case STRMMODE_PROCCOPY:
> >
> > It looks like all modes are handled here although the only one that
> > could escape the validation from above is STRMMODE_PROCCOPY.
> >
> > I tried removing the first check and tested with the
> > userspace-dspbridge strmcopy application, but I noticed the DSP hangs if
> > I try to use it with anything else than the copy mode.
> >
> > Are the other modes (rdma, zerocopy) not supported at all?
> 
> No, those modes are not supported... the only one working for dsp
> streams is proc-copy.
> 

Is there any plan to make them work? If not, maybe the code that handles
them should be removed...

Thanks,
Ionut.

