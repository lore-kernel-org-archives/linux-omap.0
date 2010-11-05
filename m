From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 1/3] staging: tidspbridge: fix mgr_enum_node_info
Date: Fri, 5 Nov 2010 09:09:04 -0700
Message-ID: <20101105160904.GA28784@kroah.com>
References: <1288970148-22191-1-git-send-email-ionut.nicu@mindbit.ro> <1288970148-22191-2-git-send-email-ionut.nicu@mindbit.ro> <AANLkTimgHvTz9sSG+opnnkeGQ2LH7hVV5x-iJOMvffgE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:52945 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab0KEQIt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 12:08:49 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimgHvTz9sSG+opnnkeGQ2LH7hVV5x-iJOMvffgE@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Ionut Nicu <ionut.nicu@gmail.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

On Fri, Nov 05, 2010 at 06:01:47PM +0200, Felipe Contreras wrote:
> On Fri, Nov 5, 2010 at 5:15 PM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> > The current code was always returning a non-zero status value
> > to userspace applications when this ioctl was called.
> >
> > The error code was ENODATA, which isn't actually an error,
> > it's always returned by dcd_enumerate_object() when it hits the
> > end of list.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
> 
> You should leave the original author (me).

Ick, yes, that is very bad.

Ionut, please go re-read Documentation/SubmittingPatches for how to
properly attribute the original author of the patch.  Please resend all
of these patches after ensuring that you have the proper authors
credited.

thanks,

greg k-h
