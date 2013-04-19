From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio/omap: ensure gpio context is initialised
Date: Fri, 19 Apr 2013 08:36:14 -0700
Message-ID: <20130419153614.GF10155@atomide.com>
References: <1366230707-32681-1-git-send-email-jon-hunter@ti.com>
 <871ua734mv.fsf@linaro.org>
 <51707D7C.1050600@ti.com>
 <5170911C.6010507@ti.com>
 <51709499.8030208@ti.com>
 <5170E4EE.7090100@ti.com>
 <87sj2mzkcf.fsf@linaro.org>
 <51715772.9020003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31360 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030594Ab3DSPgU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Apr 2013 11:36:20 -0400
Content-Disposition: inline
In-Reply-To: <51715772.9020003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130419 07:43]:
> On Friday 19 April 2013 07:35 PM, Kevin Hilman wrote:
> > Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> > 
> >> On Friday 19 April 2013 06:19 AM, Jon Hunter wrote:
> >>>
> >>> On 04/18/2013 07:34 PM, Jon Hunter wrote:
> >>>>
> >>>> On 04/18/2013 06:10 PM, Jon Hunter wrote:
> >>>>> On 04/18/2013 04:34 PM, Kevin Hilman wrote:
> >>>>
> >>>> ...
> >>>>
> >>>>>> Why not just init context right here if bank->loses_context &&
> >>>>>> !bank->context_valid?
> >>>>
> >>>> I really like this idea a lot. It can really clean-up the code
> >>>> and really make it much more readable. Before we were playing 
> >>>> some tricks with when we init'ed the get_context_loss_count()
> >>>> function pointer. How about the below?
> >>>>
> >>>> Tony, care to re-test?

Still works thanks:

Tested-by: Tony Lindgren <tony@atomide.com>

> > Assuming this driver could become a module someday (not terribly likely,
> > I know), but context_valid would have meaning for each module reload.
> > 
> I don't think GPIO can ever be a module(at least on OMAP) considering the way
> it is used in many SOCs and hence the objection on that flag. GPIO is really
> an infrastructure driver which is needed to be always available for the
> client drivers to work. 

Not really related to this fix.. But when booting with initramfs, we should
be able to make everything into loadable modules except things that are related
to enabling timers and interrupts. This is important for distros to be able
do generic kernels. Surely for mounting non-initramfs root GPIO is most
likely needed though :)

Regards,

Tony
