From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 4/4] drivers: Add pinctrl handling for dynamic pin states
Date: Wed, 17 Jul 2013 15:21:35 -0600
Message-ID: <51E70ADF.8090805@wwwdotorg.org>
References: <20130716090310.5541.36777.stgit@localhost> <20130716090539.5541.980.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130716090539.5541.980.stgit@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linus.walleij@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/16/2013 03:05 AM, Tony Lindgren wrote:
> We want to have static pin states handled separately from
> dynamic pin states, so let's add optional state_active.
> 
> Then if state_active is defined, let's check and make sure
> state_idle and state_sleep match state_active for the
> pin groups to avoid checking them during runtime as the
> active and idle pins may need to be toggled for many
> devices every time we enter and exit idle.

> +	 * Note that if active state is defined, sleep and idle states must
> +	 * cover the same pin groups as active state.
>  	 */
>  	dev->pins->sleep_state = pinctrl_lookup_state(dev->pins->p,
>  					PINCTRL_STATE_SLEEP);
> -	if (IS_ERR(dev->pins->sleep_state))
> +	if (IS_ERR(dev->pins->sleep_state)) {
>  		/* Not supplying this state is perfectly legal */
>  		dev_dbg(dev, "no sleep pinctrl state\n");
> +	} else if (!IS_ERR(dev->pins->active_state)) {
> +		ret = pinctrl_check_dynamic(dev, dev->pins->active_state,
> +					    dev->pins->sleep_state);

Oh, I see you're trying to check that the set of pins in the active,
sleep, and idle states are identical.

But I think that pinctrl_check_dynamic() only checks that one state is a
subset of the other, not that the two states are equal. Instead, I think
you want to comparison coded in pinctrl_check_dynamic() to be:

gen_group_list_of_pinctrl_state(s1, array1);
gen_group_list_of_pinctrl_state(s2, array2);
mismatch = memcmp(array1, array2, length);
