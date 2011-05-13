From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [RFC] OMAP4: clock: shrink clock data utilizing
 preprocessor.
Date: Fri, 13 May 2011 04:30:13 -0700
Message-ID: <20110513113013.GP31483@atomide.com>
References: <1305247077-15927-1-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26116 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750930Ab1EMLaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 07:30:17 -0400
Content-Disposition: inline
In-Reply-To: <1305247077-15927-1-git-send-email-vzapolskiy@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Zapolskiy <vzapolskiy@gmail.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Vladimir Zapolskiy <vzapolskiy@gmail.com> [110512 17:35]:
> This mass change reduces homogeneous data chunks along clock
> definitions. No semantical difference is added to the change,
> and still it could be introduced easily.
> 
> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c | 3313 +++++++++-------------------------
>  1 files changed, 848 insertions(+), 2465 deletions(-)

Hehehe, the diffstat certainly looks good :)

This would be best done for all of them using some
perl/sed/python script. And could be done for the hwmod data
too. Do you already have something like that available?

Paul and & Benoit, what's your take on doing something like
this? I'd assume updating your data generation scripts would
be trivial?

Regards,

Tony
