From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/13] ARM: OMAP5: board-generic: Add device tree
 support.
Date: Mon, 7 May 2012 10:35:55 -0700
Message-ID: <20120507173555.GD5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-11-git-send-email-r.sricharan@ti.com>
 <4FA7CDC1.9050301@ti.com>
 <CAJ7qFSdBz1ccp0Z-4pWvbq0J0zb6j3Kto4cDz3R0kHT7YfRo0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13689 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757248Ab2EGRf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 13:35:57 -0400
Content-Disposition: inline
In-Reply-To: <CAJ7qFSdBz1ccp0Z-4pWvbq0J0zb6j3Kto4cDz3R0kHT7YfRo0w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Sricharan" <r.sricharan@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

* R, Sricharan <r.sricharan@ti.com> [120507 07:12]:
> Hi Benoit,
>   Thanks for the reviews.
> 
> >
> >> Adding the minimal support for OMAP5 soc with device tree.
> >
> >
> > You should probably split that patch since you are doing several things that
> > are not OMAP5 related.
> >
> > Do a patch that move the omap_init_irq into the INTC and GIC code first.
> >
> > Then, you can add a patch to add the OMAP5_DT machine entry.
> >
>   ok, will split this then accordingly.

Thanks, that allows us to remove the dependencies that will easily
cause merge errors adding let's say am33xx here.

Tony
