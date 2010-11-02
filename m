From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [PATCH v2] McBSP: Fix the free variable update at remove.
Date: Tue, 2 Nov 2010 16:35:20 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF767E64@dbde02.ent.ti.com>
References: <1288693488-10200-1-git-send-email-shubhrajyoti@ti.com>
 <20101102123256.b6bee4b7.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33870 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302Ab0KBLF0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 07:05:26 -0400
In-Reply-To: <20101102123256.b6bee4b7.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Jarkko Nikula [mailto:jhnikula@gmail.com]
> Sent: Tuesday, November 02, 2010 4:03 PM
> To: Datta, Shubhrajyoti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v2] McBSP: Fix the free variable update at remove.
> 
> On Tue,  2 Nov 2010 15:54:48 +0530
> shubhrajyoti@ti.com wrote:
> 
> > From: Shubhrajyoti D <shubhrajyoti@ti.com>
> >
> > At remove the free variable is wrongly updated.Attempting to solve the
> same.
> >
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > ---
> > -[v2] Instead of using 0/1 use a macro
> >
> >  arch/arm/plat-omap/include/plat/mcbsp.h |    3 +++
> >  arch/arm/plat-omap/mcbsp.c              |   10 +++++-----
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-
> omap/include/plat/mcbsp.h
> > index b87d83c..8988733 100644
> > --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> > +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> > @@ -37,6 +37,9 @@ static struct platform_device omap_mcbsp##port_nr = {
> 	\
> >  	.id	= OMAP_MCBSP##port_nr,			\
> >  }
> >
> > +#define TRUE			1
> > +#define FALSE			0
> > +
> Use 'true' & 'false' in the code instead and then there is no need to
> redefine these. They are defined in include/linux/stddef.h which is
> probably included already by some another file.
> 
Yes missed it. Will fix that.
> 
> --
> Jarkko
