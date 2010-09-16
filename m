From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing
 frequency
Date: Thu, 16 Sep 2010 13:49:35 -0700
Message-ID: <20100916204935.GP29610@atomide.com>
References: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com>
 <20100915224007.GJ4174@atomide.com>
 <alpine.DEB.2.00.1009151707370.458@utopia.booyaka.com>
 <AANLkTimC7_pGag4e+Q0fasP=mdsug8xrU95UJLKOJHvf@mail.gmail.com>
 <20100916185743.GJ29610@atomide.com>
 <AANLkTinXdow4tzmwpx6nRe5VCN5Q8_aKz9EibxKinWWO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59075 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab0IPUtk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 16:49:40 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinXdow4tzmwpx6nRe5VCN5Q8_aKz9EibxKinWWO@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, khilman@deeprootsystems.com

* Gadiyar, Anand <gadiyar@ti.com> [100916 13:16]:
> On Fri, Sep 17, 2010 at 12:27 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> For the past - OMAP3 and before - we'll do our best to scrub all internal
> trees for missing bugs/features/what not and hopefully this will
> go upstream as we discover those.
> 
> Sounds fair?

Sounds fair. But it might be worth checking that you guys have a system
in place for collecting omap specific fixes and promptly merging them
upstream to the mainline tree.

Regards,

Tony
