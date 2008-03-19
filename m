From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dmtimer posting
Date: Wed, 19 Mar 2008 17:58:35 +0200
Message-ID: <20080319155835.GE14860@atomide.com>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA382@dlee13.ent.ti.com> <20080319141504.GB14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA4F9@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54362 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767AbYCSTg4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 15:36:56 -0400
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742903CCA4F9@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [080319 16:47]:
> Hi,
> 
> > Cool. Here's a version that gets rid of the lookup table by encoding
> the
> > posted write pending bit into the reg offset. This should be OK, as
> the
> > functions are used within dmtimer.c only.
> 
> Ok, that looks nice and will generate a bit better code.  I thought
> briefly on that it but wanted the change to be small and was a little
> worried someone might use the offset somewhere else.  But, they way you
> did it makes the 2nd aspect go away.
> 
> * You have defined WPSHIFT to 8.  However, that bit is currently taken
> by WP_TOCR.  I chose 15 hoping if the register expanded it would be the
> last one in a u_int16 and still can be encoded in an op code as a shift
> value.  A 16 would be a good codegen value, but always assume u_int32
> register.  As the registers are u_int32 in current implementations,
> probably 16 is a better value.

OK, good catch.

> > The init of other timers into posted mode is not done yet, so I
> changed
> > the timer->posted handling too.
> 
> Not inited in software, BUT the power on reset of the timer module is to
> posted mode in reset.  Its better to have someone shut it off in both
> places as its on by default.

OK

> I'll tweak the points mentioned and fix a typo in the description and
> send a version.

OK

Tony
