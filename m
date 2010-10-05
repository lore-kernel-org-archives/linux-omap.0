From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] omap: add dsp platform device
Date: Tue, 5 Oct 2010 09:28:30 -0700
Message-ID: <20101005162830.GI3117@atomide.com>
References: <1286208555-8829-1-git-send-email-felipe.contreras@gmail.com>
 <1286208555-8829-2-git-send-email-felipe.contreras@gmail.com>
 <20101005155656.GA27130@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101005155656.GA27130@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>
List-Id: linux-omap@vger.kernel.org

* Greg KH <greg@kroah.com> [101005 09:01]:
> On Mon, Oct 04, 2010 at 07:09:14PM +0300, Felipe Contreras wrote:
> > Otherwise tidspbridge cannot work.
> > 
> > It looks like this was dropped in the conversion to staging. I took the
> > liberty of doing some cleaning up.
> > 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  arch/arm/mach-omap2/Makefile          |    4 ++
> >  arch/arm/mach-omap2/dsp.c             |   85 +++++++++++++++++++++++++++++++++
> >  arch/arm/plat-omap/common.c           |    2 +
> >  arch/arm/plat-omap/devices.c          |   30 ++++++++++++
> >  arch/arm/plat-omap/include/plat/dsp.h |   31 ++++++++++++
> 
> I need an ack from some omap maintainers before I can take this into the
> staging tree.

Looks good to me

Acked-by: Tony Lindgren <tony@atomide.com>
