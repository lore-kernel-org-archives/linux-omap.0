From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: context_loss_count error value
Date: Wed, 25 May 2011 09:05:46 +0300
Message-ID: <1306303546.2062.6.camel@deskari>
References: <1305704452.1834.12.camel@deskari> <87k4douvsd.fsf@ti.com>
	 <1305718422.1834.23.camel@deskari> <877h9ot7c3.fsf@ti.com>
	 <1305729690.30372.7.camel@deskari> <1306252069.2194.28.camel@deskari>
	 <87lixv1x3s.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:49077 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752069Ab1EYGFw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 02:05:52 -0400
Received: by eyg5 with SMTP id 5so3262455eyg.24
        for <linux-omap@vger.kernel.org>; Tue, 24 May 2011 23:05:49 -0700 (PDT)
In-Reply-To: <87lixv1x3s.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2011-05-24 at 16:45 -0700, Kevin Hilman wrote:
> Hi Tomi,
> 
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
> > On Wed, 2011-05-18 at 17:41 +0300, Tomi Valkeinen wrote:
> >> On Wed, 2011-05-18 at 16:24 +0200, Kevin Hilman wrote:
> >> 
> >> > Looking closer at the code, a zero return happens only when
> >> > 
> >> > 1) no hwmod associated to omap_device
> >> > 2) no power domain associated to hwmod
> >> > 3) power domain has not (yet) lost context
> >> > 
> >> > None of these are actually error conditions per-se, and in all cases, it
> >> > indidates that context has not been lost (or we can't tell if context
> >> > has been lost.) 
> >> 
> >> If the pm code cannot tell whether the context has been lost or not, the
> >> driver must assume it has been lost, do you agree? If so, the driver
> >> must handle zero return value differently, and always restore context.
> >> 
> >> > So I think the current code is correct.
> >> 
> >> How is it correct if it returns an error even if no error has happened
> >> =)? Either the code or the documentation is wrong.
> >> 
> >> How about the wrap-around case? Does the loss count go back to zero?
> >
> > Any conclusion on this?
> 
> Sorry for the lag... been travelling, and finally back home...
> 
> You're right, the code is just wrong here and would lead to strange
> return value checking in the callers to be correct.
> 
> I think the best fix for this problem is to use a signed return value
> which can wrap as expected, and then use return negative error codes
> (e.g. -ENODEV).

When I first saw this context_loss_count in Nokia's kernel tree, it was
returning int and was called get_last_off_on_transaction_id. I wonder
why it ended up returning u32 in mainline...

> Care to send a patch?  or do you have any other suggestions for a fix?

Sure, I'll cook up a patch.

Looking at other users of get_context_loss_count, I see that omap hsmmc
is also using it. Interestingly hsmmc code uses the value returned from
omap_pm_get_dev_context_loss_count() as int, and checks if the returned
value is < 0.

So changing omap_pm_get_dev_context_loss_count() to return an int would
also "fix" hsmmc code =).

 Tomi


