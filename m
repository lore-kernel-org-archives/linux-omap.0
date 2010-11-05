From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 1/3] staging: tidspbridge: fix mgr_enum_node_info
Date: Fri, 5 Nov 2010 09:24:03 -0700
Message-ID: <20101105162403.GA29178@kroah.com>
References: <1288970148-22191-1-git-send-email-ionut.nicu@mindbit.ro> <1288970148-22191-2-git-send-email-ionut.nicu@mindbit.ro> <AANLkTimgHvTz9sSG+opnnkeGQ2LH7hVV5x-iJOMvffgE@mail.gmail.com> <20101105160904.GA28784@kroah.com> <1288973875.9931.17.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:59071 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753203Ab0KEQXb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 12:23:31 -0400
Content-Disposition: inline
In-Reply-To: <1288973875.9931.17.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Ionut Nicu <ionut.nicu@gmail.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Nov 05, 2010 at 06:17:55PM +0200, Ionut Nicu wrote:
> On Fri, 2010-11-05 at 09:09 -0700, Greg KH wrote:
> > On Fri, Nov 05, 2010 at 06:01:47PM +0200, Felipe Contreras wrote:
> > > On Fri, Nov 5, 2010 at 5:15 PM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> > > > The current code was always returning a non-zero status value
> > > > to userspace applications when this ioctl was called.
> > > >
> > > > The error code was ENODATA, which isn't actually an error,
> > > > it's always returned by dcd_enumerate_object() when it hits the
> > > > end of list.
> > > >
> > > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > > Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
> > > 
> > > You should leave the original author (me).
> > 
> > Ick, yes, that is very bad.
> > 
> > Ionut, please go re-read Documentation/SubmittingPatches for how to
> > properly attribute the original author of the patch.  Please resend all
> > of these patches after ensuring that you have the proper authors
> > credited.
> > 
> 
> Oops. Sorry about that. I put my sign off on this patch because the fix
> was also in v1 of this series, but it was combined with patch 3/3.
> 
> I definitely don't want to take credit for other people's work, so I
> will re-submit this series.

I now have to ask if your other series also all came from you, did it?
If not, please resend it as well.

thanks,

greg k-h
