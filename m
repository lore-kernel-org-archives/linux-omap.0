From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Correct offset in OMAP4_WKUP_IOPAD macro
Date: Mon, 12 May 2014 09:36:43 -0700
Message-ID: <20140512163642.GK31772@atomide.com>
References: <CAGhQ9VwU_BjrD+c9uJn9FBwo6v_BOMUCKwiOW-7eqOu056a79A@mail.gmail.com>
 <20140421153539.GB23945@atomide.com>
 <CAGhQ9VyFQgcOw8y97R6HR1apXo-89JyktADxR6jb1EJipXqqjA@mail.gmail.com>
 <CAGhQ9VxCA_VnO18zWgtWUExNE6YJd+krNEVLtyZTpyY6hRyHUg@mail.gmail.com>
 <20140506001237.GK25949@atomide.com>
 <CAGhQ9Vw+cR-cKQ-w3psZPOWOqwugntXq-9g5=4cZV-ijQZecTQ@mail.gmail.com>
 <20140509160725.GG17814@atomide.com>
 <CAGhQ9VwALSFVn3dd+VWV4AWBZnHUFqpJv7yQyLvR4U+W6nL+aQ@mail.gmail.com>
 <20140512161647.GJ31772@atomide.com>
 <CAGhQ9VwHqUmTKHBxBG3rm1AXQZHovDVvOEiGJfVCJHSOtFE45Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18929 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbaELQgq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 12:36:46 -0400
Content-Disposition: inline
In-Reply-To: <CAGhQ9VwHqUmTKHBxBG3rm1AXQZHovDVvOEiGJfVCJHSOtFE45Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: linux-omap@vger.kernel.org

* Joachim Eastwood <manabian@gmail.com> [140512 09:27]:
> 
> So you are okey with just OMAP4_IOPAD for both core and wkup pads?

Well if we ever wanted to add range checking, the macro would have
to have size of the iopad range in it too. But that's probably
out of the scope for these macros anyways and is already done by
the driver.
 
> If so I'll send out a patch with the stuff above for OMAP4 and 5.
> 
> Then I'll update my patch set, rebase it on your omap-for-v3.16/dt
> branch and post it the list.

OK thanks.

Tony
