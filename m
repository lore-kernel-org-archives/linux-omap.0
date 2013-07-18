From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] drivers: Add pinctrl handling for dynamic pin
 states
Date: Thu, 18 Jul 2013 00:50:06 -0700
Message-ID: <20130718074508.GQ7656@atomide.com>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090539.5541.980.stgit@localhost>
 <51E70ADF.8090805@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43309 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752360Ab3GRHuM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jul 2013 03:50:12 -0400
Content-Disposition: inline
In-Reply-To: <51E70ADF.8090805@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linus.walleij@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130717 14:28]:
> On 07/16/2013 03:05 AM, Tony Lindgren wrote:
> > We want to have static pin states handled separately from
> > dynamic pin states, so let's add optional state_active.
> > 
> > Then if state_active is defined, let's check and make sure
> > state_idle and state_sleep match state_active for the
> > pin groups to avoid checking them during runtime as the
> > active and idle pins may need to be toggled for many
> > devices every time we enter and exit idle.
> 
> > +	 * Note that if active state is defined, sleep and idle states must
> > +	 * cover the same pin groups as active state.
> >  	 */
> >  	dev->pins->sleep_state = pinctrl_lookup_state(dev->pins->p,
> >  					PINCTRL_STATE_SLEEP);
> > -	if (IS_ERR(dev->pins->sleep_state))
> > +	if (IS_ERR(dev->pins->sleep_state)) {
> >  		/* Not supplying this state is perfectly legal */
> >  		dev_dbg(dev, "no sleep pinctrl state\n");
> > +	} else if (!IS_ERR(dev->pins->active_state)) {
> > +		ret = pinctrl_check_dynamic(dev, dev->pins->active_state,
> > +					    dev->pins->sleep_state);
> 
> Oh, I see you're trying to check that the set of pins in the active,
> sleep, and idle states are identical.

Right, that's to avoid any further checking during runtime for runtime PM.
 
> But I think that pinctrl_check_dynamic() only checks that one state is a
> subset of the other, not that the two states are equal. Instead, I think
> you want to comparison coded in pinctrl_check_dynamic() to be:

In pinctrl_check_dynamic() we check that the pins match between the
states, and the number of found pins matches the first set. I'll
take a look if we check the total pins between the two sets.
 
> gen_group_list_of_pinctrl_state(s1, array1);
> gen_group_list_of_pinctrl_state(s2, array2);
> mismatch = memcmp(array1, array2, length);

Well we could allocate and sort the pins, but the number of pins
for runtime PM is typically very small for each pin consumer device.
Typically you just need to toggle RX pin to GPIO mode for idle. And
this check is only done during consumer driver probe time. So
optimizing it for larger sets could be done at any point later on
as needed.

Regards,

Tony
