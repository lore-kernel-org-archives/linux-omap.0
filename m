From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: context_loss_count error value
Date: Wed, 18 May 2011 14:33:42 +0300
Message-ID: <1305718422.1834.23.camel@deskari>
References: <1305704452.1834.12.camel@deskari>  <87k4douvsd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33283 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932751Ab1ERLdr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 07:33:47 -0400
Received: by wye20 with SMTP id 20so1571005wye.34
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 04:33:45 -0700 (PDT)
In-Reply-To: <87k4douvsd.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, 2011-05-18 at 12:50 +0200, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
> > Hi Kevin,
> >
> > I was fixing DSS context loss handling which is a bit broken, and while
> > testing on OMAP3 Overo, with -rc7 and omap2plus_defconfig, I noticed
> > that get_context_loss_count() seems to always return 0.
> >
> > 0 should be returned when an error happens, and as far as I see in
> > pwrdm_get_context_loss_count(), no error is happening but the DSS
> > context has just never been lost and the returned count is thus 0.
> >
> > Is this correct? And what happens when the count wraps and goes back to
> > zero, does the function return 0 in that case?
> 
> Hmm, you're right.  zero is actually documented as the error return
> value (even though it's not really checked.)
> 
> Since driver's should only every care about the *difference* in value
> between two calls to context_loss_count(), this might not be a big deal,
> but a proper fix is probably to have the state counters start at one.

But if there happens an error in get_context_loss_count(), for whatever
reason, I'd guess it's safer from the driver's perspective to assume
that a context restore _is_ needed. If the driver handles zero value as
a normal return value, it would mean that the driver never restores
context if get_context_loss_count() returns 0 for all calls.

 Tomi


