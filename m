From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH v2 1/3] staging: tidspbridge: fix mgr_enum_node_info
Date: Fri, 05 Nov 2010 18:17:55 +0200
Message-ID: <1288973875.9931.17.camel@atlantis.mindbit.ro>
References: <1288970148-22191-1-git-send-email-ionut.nicu@mindbit.ro>
	 <1288970148-22191-2-git-send-email-ionut.nicu@mindbit.ro>
	 <AANLkTimgHvTz9sSG+opnnkeGQ2LH7hVV5x-iJOMvffgE@mail.gmail.com>
	 <20101105160904.GA28784@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:38571 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760Ab0KEQSI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 12:18:08 -0400
In-Reply-To: <20101105160904.GA28784@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Ionut Nicu <ionut.nicu@gmail.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, 2010-11-05 at 09:09 -0700, Greg KH wrote:
> On Fri, Nov 05, 2010 at 06:01:47PM +0200, Felipe Contreras wrote:
> > On Fri, Nov 5, 2010 at 5:15 PM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> > > The current code was always returning a non-zero status value
> > > to userspace applications when this ioctl was called.
> > >
> > > The error code was ENODATA, which isn't actually an error,
> > > it's always returned by dcd_enumerate_object() when it hits the
> > > end of list.
> > >
> > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
> > 
> > You should leave the original author (me).
> 
> Ick, yes, that is very bad.
> 
> Ionut, please go re-read Documentation/SubmittingPatches for how to
> properly attribute the original author of the patch.  Please resend all
> of these patches after ensuring that you have the proper authors
> credited.
> 

Oops. Sorry about that. I put my sign off on this patch because the fix
was also in v1 of this series, but it was combined with patch 3/3.

I definitely don't want to take credit for other people's work, so I
will re-submit this series.

Thanks,
Ionut. 



