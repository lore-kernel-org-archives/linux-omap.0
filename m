From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH 3/4] staging: tidspbridge: remove gb bitmap
 implementation
Date: Fri, 22 Oct 2010 17:08:42 +0300
Message-ID: <1287756522.17937.9.camel@atlantis.mindbit.ro>
References: <1287752251-5847-1-git-send-email-ionut.nicu@mindbit.ro>
	 <1287752251-5847-4-git-send-email-ionut.nicu@mindbit.ro>
	 <AANLkTikNO53eTTNE1Ed1Tt6Km8BBMah+Rqb6soAQYvCe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:50502 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756002Ab0JVOIw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Oct 2010 10:08:52 -0400
In-Reply-To: <AANLkTikNO53eTTNE1Ed1Tt6Km8BBMah+Rqb6soAQYvCe@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Andy,

On Fri, 2010-10-22 at 16:18 +0300, Andy Shevchenko wrote:
> Briefly I see the clean up of the code as well, which is not related
> to the mentioned description.
> I guess it would be better to split this patch at least to two.
> 

Point taken. I will split this patch into 2 patches: one that converts
gb to bitmap and one which does the code cleanup.

Most likely I will have to break patch 4/4 from this series (which I
also believe is way too big) into multiple patches and re-submit.

I'm expecting some advices from the maintainers/list on how to split
patch 4 (lst_list removal).

Thanks,
Ionut.

