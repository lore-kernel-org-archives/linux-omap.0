From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
Date: Tue, 22 Jan 2013 12:40:54 -0800
Message-ID: <20130122204053.GT22517@atomide.com>
References: <1358634477-25868-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358634477-25868-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130121123020.GI15707@e106331-lin.cambridge.arm.com>
 <CALF0-+VOxtsfQLZCGujvjMrsGacbfVTMytRUX=CfKa3+FgnU1w@mail.gmail.com>
 <20130121183348.GI22517@atomide.com>
 <af696cd0-8a7f-4839-9600-87d5b9172585@email.android.com>
 <CALF0-+WvfyygnV5A=E8UGc=zp9pab79FzJRe1KywjPw-B4UGZA@mail.gmail.com>
 <20130122182749.GM15361@atomide.com>
 <CALF0-+XdsKvJJpmxZEYXyhTZksgKRoAJ4TcyPV+G9WUbb7Dt_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60113 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751267Ab3AVUlA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 15:41:00 -0500
Content-Disposition: inline
In-Reply-To: <CALF0-+XdsKvJJpmxZEYXyhTZksgKRoAJ4TcyPV+G9WUbb7Dt_g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "martinez.javier@gmail.com" <martinez.javier@gmail.com>, "matthias.bgg@googlemail.com" <matthias.bgg@googlemail.com>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Ezequiel Garcia <elezegarcia@gmail.com> [130122 11:46]:
> On Tue, Jan 22, 2013 at 3:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Ezequiel Garcia <elezegarcia@gmail.com> [130122 10:17]:
> >> On Mon, Jan 21, 2013 at 10:32 PM, Daniel Mack <zonque@gmail.com> wrote:
> >> >
> >> > I'm currently far away from my computer and can't prepare a patch for this, sorry. But I think you are right, so please just submit a patch for that, anyone :-)
> >> >
> >>
> >> Ok, I'll try to submit a patch as soon as possible. If anyone wants to
> >> do it instead, fine by me.
> >
> > No please go ahead as it seems that you can easily test it too.
> >
> 
> No problem.
> 
> I now wonder if it's okey to exit upon probe failure.
> In particular, the for_each should be like this:
> 
>         for_each_node_by_name(child, "nand") {
>                 ret = gpmc_probe_nand_child(pdev, child);
>                 if (ret < 0) {
>                         of_node_put(child);
>                         return ret;
>                 }
>         }
> 
> or like this:
> 
>         for_each_node_by_name(child, "nand") {
>                 ret = gpmc_probe_nand_child(pdev, child);
>                 WARN_ON(ret < 0);
>         }
> 
> Ideas?

Well I would return and make sure the resources are freed.

However, if this relates to using bootloader configured values
for the few cases where we don't have the timing information
for calculations available, then just doing a warning is
the way to go.

Regards,

Tony
