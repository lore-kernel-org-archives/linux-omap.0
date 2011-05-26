From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: context_loss_count error value
Date: Thu, 26 May 2011 08:55:15 +0300
Message-ID: <1306389315.1922.4.camel@deskari>
References: <1305704452.1834.12.camel@deskari> <87k4douvsd.fsf@ti.com>
	 <1305718422.1834.23.camel@deskari> <877h9ot7c3.fsf@ti.com>
	 <1305729690.30372.7.camel@deskari> <1306252069.2194.28.camel@deskari>
	 <87lixv1x3s.fsf@ti.com> <1306312262.2062.16.camel@deskari>
	 <87ipsyvdc6.fsf@ti.com> <1306349159.2062.32.camel@deskari>
	 <87tycitteb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:46231 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750753Ab1EZFzV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 01:55:21 -0400
Received: by ewy3 with SMTP id 3so198690ewy.22
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 22:55:18 -0700 (PDT)
In-Reply-To: <87tycitteb.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, 2011-05-25 at 13:30 -0700, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
> > On Wed, 2011-05-25 at 11:34 -0700, Kevin Hilman wrote:
> >> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

<snip>

> >> 
> >> > +		if (off_mode_enabled) {
> >> > +			count = (count + 1) & 0x7fffffff;
> >> > +			dummy_context_loss_counter = count;
> >> > +		}
> >> 
> >> Again, I don't think this masking is needed.   count is already an
> >> 'int', so when it gets bigger than INT_MAX, it will wrap.
> >
> > When count is INT_MAX and one is added to it, it'll wrap to INT_MIN,
> > i.e. maximum negative value, which would be an error value. So by
> > masking out the highest bit we'll get nonnegative count range from 0 to
> > INT_MAX.
> >
> > Perhaps a comment would be justified here =).
> 
> Indeed, and using INT_MAX instead of the hard-coded constants would help
> readability also.

It may be just me, but as I see it, INT_MAX is a number like any other,
and using it as a mask feels confusing to me.

Would this be ok to you:

/*
 * Context loss count has to be a non-negative value. Clear the sign
 * bit to get a value range from 0 to INT_MAX.
 */
count &= ~(1 << 31);

 Tomi


