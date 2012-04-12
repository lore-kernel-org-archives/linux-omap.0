From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
Date: Thu, 12 Apr 2012 11:15:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204121107450.29473@utopia.booyaka.com>
References: <1331659524-7635-1-git-send-email-rnayak@ti.com> <1331659524-7635-3-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204101803020.20894@utopia.booyaka.com> <4F8565C7.4080506@ti.com> <alpine.DEB.2.00.1204111251100.29473@utopia.booyaka.com>
 <4F86D304.1020902@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57011 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab2DLRPA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 13:15:00 -0400
In-Reply-To: <4F86D304.1020902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anand Gadiyar <gadiyar@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

Hi Rajendra,

On Thu, 12 Apr 2012, Rajendra Nayak wrote:

> On Thursday 12 April 2012 12:29 AM, Paul Walmsley wrote:
> > That approach sounds fine to me, but I don't think Fernando's patch will
> > help with I2C..  Since it uses a custom reset function omap_i2c_reset(),
> > the delay will actually need to go there.
> 
> While working on fixing this I stumbled upon a couple of other
> things which don't seem right.
> 
> The i2c custom reset funtion (omap_i2c_reset) uses a hwmod exposed
> api to set the SOFTRESET bit, however it then accesses the hwmod
> internal structure to poll on RESETDONE status bit. Should there be
> another function exposed to poll on RESETDONE too?

Sure, something like that would make sense for 3.5.

> _reset() function documents its return value to be -ETIMEDOUT, if the
> module fails to reset in time, and hence expects the custom reset
> function to return the same in such cases. The omap_i2c_reset() function
> seems to return 0 even in cases of timeout. However looking more closely
> the return value from _reset() does not seem to be used in the framework
> today.
> 
> The comment in _ocp_softreset() suggests the intent was to add a new
> state to the hwmod state machine.
> 
>         /*
>          * XXX add _HWMOD_STATE_WEDGED for modules that don't come back from
>          * _wait_target_ready() or _reset()
>          */
> 
> is it still the case, or should _reset() just return a void?

There's a patch queued to pass along the return status from _reset():

http://marc.info/?l=linux-omap&m=133417544011862&w=2

As far as the new state goes, if you'd like to add a new state to indicate 
an IP block that fails _reset()/_wait_target_ready() and should be blocked 
from further use, that sounds good to me...


regards,

- Paul
