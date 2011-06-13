From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 01/28] OMAP: change get_context_loss_count ret value
 to int
Date: Mon, 13 Jun 2011 19:45:04 +0300
Message-ID: <1307983504.1847.87.camel@deskari>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com>
	 <1307958710.1847.56.camel@deskari>
	 <BANLkTimi0RZ8Fe7VpY9J7dMPH6tpVzf=dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:59224 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753821Ab1FMQpM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 12:45:12 -0400
In-Reply-To: <BANLkTimi0RZ8Fe7VpY9J7dMPH6tpVzf=dw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghongdemath, Girish" <girishsg@ti.com>
Cc: paul@pwsan.com, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

On Mon, 2011-06-13 at 11:37 -0500, Ghongdemath, Girish wrote:
> Tomi,
> Couple of queries,
> 
> On Mon, Jun 13, 2011 at 4:51 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > Paul, can you take this patch and queue it for an rc?
> >
> >  Tomi
> >
> > On Thu, 2011-06-09 at 16:56 +0300, Tomi Valkeinen wrote:
> >> get_context_loss_count functions return context loss count as u32, and
> >> zero means an error. However, zero is also returned when context has
> >> never been lost and could also be returned when the context loss count
> >> has wrapped and goes to zero.
> >>
> >> Change the functions to return an int, with negative value meaning an
> >> error.
> >>
> 
> >> +             if (off_mode_enabled) {
> 
> - why have a check for off_mode_enabled? As this only detects valid
> next state for MPU/CORE. Other pwrdm can still
> hit OFF.

It does what the code did previously, without changing the logic. And
this doesn't detect anything, it's just an dummy emulation for context
loss to test the drivers.

> >> +                     count++;
> >> +                     /*
> >> +                      * Context loss count has to be a non-negative value.
> >> +                      * Clear the sign bit to get a value range from 0 to
> >> +                      * INT_MAX.
> >> +                      */
> >> +                     count &= INT_MAX;
> >> +                     dummy_context_loss_counter = count;
> >> +             }
> >>       }
> 
> - Why not use u32 instead?

So that we can return error values. That was the whole point of this
patch.

 Tomi


