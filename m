From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] dmtimer posting
Date: Wed, 19 Mar 2008 09:47:11 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903CCA4F9@dlee13.ent.ti.com>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA382@dlee13.ent.ti.com> <20080319141504.GB14860@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43532 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758778AbYCSTqu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 15:46:50 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080319141504.GB14860@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

Hi,

> Cool. Here's a version that gets rid of the lookup table by encoding
the
> posted write pending bit into the reg offset. This should be OK, as
the
> functions are used within dmtimer.c only.

Ok, that looks nice and will generate a bit better code.  I thought
briefly on that it but wanted the change to be small and was a little
worried someone might use the offset somewhere else.  But, they way you
did it makes the 2nd aspect go away.

* You have defined WPSHIFT to 8.  However, that bit is currently taken
by WP_TOCR.  I chose 15 hoping if the register expanded it would be the
last one in a u_int16 and still can be encoded in an op code as a shift
value.  A 16 would be a good codegen value, but always assume u_int32
register.  As the registers are u_int32 in current implementations,
probably 16 is a better value.

> The init of other timers into posted mode is not done yet, so I
changed
> the timer->posted handling too.

Not inited in software, BUT the power on reset of the timer module is to
posted mode in reset.  Its better to have someone shut it off in both
places as its on by default.

I'll tweak the points mentioned and fix a typo in the description and
send a version.

Regards,
Richard W.



