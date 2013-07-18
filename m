From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] drivers: Add pinctrl handling for dynamic pin
 states
Date: Thu, 18 Jul 2013 06:48:07 -0700
Message-ID: <20130718134806.GW7656@atomide.com>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090539.5541.980.stgit@localhost>
 <51E70ADF.8090805@wwwdotorg.org>
 <20130718074508.GQ7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130718074508.GQ7656@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linus.walleij@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [130718 00:57]:
> * Stephen Warren <swarren@wwwdotorg.org> [130717 14:28]:
> > 
> > Oh, I see you're trying to check that the set of pins in the active,
> > sleep, and idle states are identical.
> 
> Right, that's to avoid any further checking during runtime for runtime PM.
>  
> > But I think that pinctrl_check_dynamic() only checks that one state is a
> > subset of the other, not that the two states are equal. Instead, I think
> > you want to comparison coded in pinctrl_check_dynamic() to be:
> 
> In pinctrl_check_dynamic() we check that the pins match between the
> states, and the number of found pins matches the first set. I'll
> take a look if we check the total pins between the two sets.

That that is a bit painful right now to check properly as we don't
have any sorting, and we could use that elsewhere too for checks
probably..
  
> > gen_group_list_of_pinctrl_state(s1, array1);
> > gen_group_list_of_pinctrl_state(s2, array2);
> > mismatch = memcmp(array1, array2, length);
> 
> Well we could allocate and sort the pins, but the number of pins
> for runtime PM is typically very small for each pin consumer device.
> Typically you just need to toggle RX pin to GPIO mode for idle. And
> this check is only done during consumer driver probe time. So
> optimizing it for larger sets could be done at any point later on
> as needed.

..so for now, let's just check the total number of pins for the sets
like Felipe suggested. I think we're better off improving the pinctrl
data first to make various checks easier.

What you're suggesting with the mepcmp() can be done easily if we add
something like device_get_pins() and have the pins sorted for the
various states for a device at the device probe time.

Regards,

Tony
