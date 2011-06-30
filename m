From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix wrong OMAP_ES_x_y defines that make
 omap_rev_lt_x_y and friends misbehave
Date: Thu, 30 Jun 2011 06:23:15 -0700
Message-ID: <20110630132315.GN23145@atomide.com>
References: <BANLkTinWdQsjttt0m1h9KbVPjb6rWXNpvA@mail.gmail.com>
 <BANLkTi=75up6OQwRzGJ586eVLorEdpCa7w@mail.gmail.com>
 <20110614114116.GQ3352@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024D563DE4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:28390 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751356Ab1F3NXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 09:23:20 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D563DE4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Tasslehoff Kjappfot <tasskjapp@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [110616 06:22]:
> > 
> > Hmm, we don't seem to have these in the mainline kernel?
> > Maybe take a look if something still needs to patched
> > there?
> 
> [sp] Yes. these don't apply on mainline.
>      I believe the kernel is using this patch I submitted [1],
>      (or derived from it), but missing [2].
> 
> Tony,
>   Now that there are multiple processors with their own
>   revisions, do you believe an update version of [1]
>   patch would be useful?

Yes please take a look and see if we still need to patch
something in the mainline kernel for this.

Regards,

Tony
 
>   [1] http://marc.info/?l=linux-omap&m=127972517400499&w=2
>   [2] http://marc.info/?l=linux-omap&m=128597605524824&w=2
