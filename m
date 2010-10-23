From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: RE: [PATCH 3/4] staging: tidspbridge: remove gb bitmap
 implementation
Date: Sat, 23 Oct 2010 15:28:42 -0500
Message-ID: <D2943F03B81C9C458E44DFB213905E0201035D465A@dlee04.ent.ti.com>
References: <1287752251-5847-1-git-send-email-ionut.nicu@mindbit.ro>
	 <1287752251-5847-4-git-send-email-ionut.nicu@mindbit.ro>
	 <AANLkTikNO53eTTNE1Ed1Tt6Km8BBMah+Rqb6soAQYvCe@mail.gmail.com>
 <1287756522.17937.9.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51306 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758247Ab0JWU2s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Oct 2010 16:28:48 -0400
In-Reply-To: <1287756522.17937.9.camel@atlantis.mindbit.ro>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Ionut,
On Friday, October 22, 2010 9:09 AM Ionut Nicu wrote:
> Most likely I will have to break patch 4/4 from this series (which I
> also believe is way too big) into multiple patches and re-submit.
> 
> I'm expecting some advices from the maintainers/list on how to split
> patch 4 (lst_list removal).

I have a version of this patch but yours did it first :). You can break
it by functionality so that you don't break nor affect bridge's behavior
i.e.

Patch 1 can include the removing of the wrapper from:
drivers/staging/tidspbridge/core/_msg_sm.h
drivers/staging/tidspbridge/core/chnl_sm.c
drivers/staging/tidspbridge/core/io_sm.c
drivers/staging/tidspbridge/core/msg_sm.c
drivers/staging/tidspbridge/include/dspbridge/_chnl_sm.h
drivers/staging/tidspbridge/include/dspbridge/cmmdefs.h
The above files share some of the lists.

Patch 2:
drivers/staging/tidspbridge/pmgr/cmm.c

Patch 3:
drivers/staging/tidspbridge/pmgr/dev.c
drivers/staging/tidspbridge/rmgr/drv.c
drivers/staging/tidspbridge/rmgr/node.c
drivers/staging/tidspbridge/rmgr/proc.c

Patch 4:
drivers/staging/tidspbridge/rmgr/rmm.c

Patch 5:
Removing of the not needed files.

--
Regards,
Rene Sapiens