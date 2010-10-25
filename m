From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: RE: [PATCH 3/4] staging: tidspbridge: remove gb bitmap
 implementation
Date: Mon, 25 Oct 2010 10:54:45 +0300
Message-ID: <1287993285.17003.14.camel@atlantis.mindbit.ro>
References: <1287752251-5847-1-git-send-email-ionut.nicu@mindbit.ro>
	 <1287752251-5847-4-git-send-email-ionut.nicu@mindbit.ro>
	 <AANLkTikNO53eTTNE1Ed1Tt6Km8BBMah+Rqb6soAQYvCe@mail.gmail.com>
	 <1287756522.17937.9.camel@atlantis.mindbit.ro>
	 <D2943F03B81C9C458E44DFB213905E0201035D465A@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:48511 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab0JYHy4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Oct 2010 03:54:56 -0400
In-Reply-To: <D2943F03B81C9C458E44DFB213905E0201035D465A@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Rene,

On Sat, 2010-10-23 at 15:28 -0500, Sapiens, Rene wrote:
> Hi Ionut,
> On Friday, October 22, 2010 9:09 AM Ionut Nicu wrote:
> > Most likely I will have to break patch 4/4 from this series (which I
> > also believe is way too big) into multiple patches and re-submit.
> > 
> > I'm expecting some advices from the maintainers/list on how to split
> > patch 4 (lst_list removal).
> 
> I have a version of this patch but yours did it first :). You can break
> it by functionality so that you don't break nor affect bridge's behavior
> i.e.
> 
> Patch 1 can include the removing of the wrapper from:
> drivers/staging/tidspbridge/core/_msg_sm.h
> drivers/staging/tidspbridge/core/chnl_sm.c
> drivers/staging/tidspbridge/core/io_sm.c
> drivers/staging/tidspbridge/core/msg_sm.c
> drivers/staging/tidspbridge/include/dspbridge/_chnl_sm.h
> drivers/staging/tidspbridge/include/dspbridge/cmmdefs.h
> The above files share some of the lists.
> 
> Patch 2:
> drivers/staging/tidspbridge/pmgr/cmm.c
> 
> Patch 3:
> drivers/staging/tidspbridge/pmgr/dev.c
> drivers/staging/tidspbridge/rmgr/drv.c
> drivers/staging/tidspbridge/rmgr/node.c
> drivers/staging/tidspbridge/rmgr/proc.c
> 
> Patch 4:
> drivers/staging/tidspbridge/rmgr/rmm.c
> 
> Patch 5:
> Removing of the not needed files.
> 

Thanks for your suggestions. I will try to do this split-up in version 2
of this series.

Best regards,
Ionut.

