From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 08/12] staging: tidspbridge: convert rmgr to
	list_head
Date: Sat, 6 Nov 2010 11:26:10 -0700
Message-ID: <20101106182610.GA7306@kroah.com>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro> <1288969996-22103-9-git-send-email-ionut.nicu@mindbit.ro> <AANLkTinvM3W1WRNjw8zd=Yi6_J6uEw-h0efLjMrndCgn@mail.gmail.com> <1289067507.9931.95.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:54003 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654Ab0KFSZi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 6 Nov 2010 14:25:38 -0400
Content-Disposition: inline
In-Reply-To: <1289067507.9931.95.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: "Sapiens, Rene" <rene.sapiens@ti.com>, Ionut Nicu <ionut.nicu@gmail.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Sat, Nov 06, 2010 at 08:18:27PM +0200, Ionut Nicu wrote:
> Hi Rene,
> 
> On Fri, 2010-11-05 at 18:07 -0600, Sapiens, Rene wrote:
> > Hi Ionut,
> > 
> > On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> > > Convert the rmgr module of the tidspbridge driver
> > > to use struct list_head instead of struct lst_list.
> > >
> > > Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
> > 
> > <snip>
> > 
> > > diff --git a/drivers/staging/tidspbridge/rmgr/drv.c b/drivers/staging/tidspbridge/rmgr/drv.c
> > 
> > <snip>
> > 
> > > @@ -492,16 +465,17 @@ u32 drv_get_next_dev_object(u32 hdev_obj)
> > >        u32 dw_next_dev_object = 0;
> > >        struct drv_object *pdrv_obj;
> > >        struct drv_data *drv_datap = dev_get_drvdata(bridge);
> > > +       struct list_head *curr;
> > >
> > >        DBC_REQUIRE(hdev_obj != 0);
> > 
> > can we remove the DBC_REQUIRE and always check for !hdev_obj?
> > 
> 
> Sounds ok to me.
> 
> As a general remark, I personally think that the DBC_* macros should be
> replaced with BUG_ON, WARN_ON, but that's a subject for other patches.
> What do you think? 

They should probably be deleted, I will not add any BUG_ON to a driver,
nor should anyone else.  That's just rude behavior to crash the system,
don't you think?

thanks,

greg k-h
