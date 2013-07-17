From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/4] pinctrl: Add support for additional dynamic states
Date: Wed, 17 Jul 2013 15:23:41 -0600
Message-ID: <51E70B5D.6030802@wwwdotorg.org>
References: <20130716090310.5541.36777.stgit@localhost> <20130716090536.5541.36289.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:41122 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126Ab3GQVXn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jul 2013 17:23:43 -0400
In-Reply-To: <20130716090536.5541.36289.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/16/2013 03:05 AM, Tony Lindgren wrote:
> To toggle dynamic states, let's add the optional active state in
> addition to the static default state. Then if the optional active
> state is defined, we can require that idle and sleep states cover
> the same pingroups as the active state.
> 
> Then let's add pinctrl_check_dynamic() and pinctrl_select_dynamic()
> to use instead of pinctrl_select() to avoid breaking existing users.
> 
> With pinctrl_check_dynamic() we can check that idle and sleep states
> match the active state for pingroups during init, and don't need to
> do it during runtime.
> 
> Then with the states pre-validated, pinctrl_select_dynamic() can
> just toggle between the dynamic states without extra checks.
> 
> Note that pinctr_select_state() still has valid use cases, such as
> changing states when the pins can be shared between two drivers
> and don't necessarily cover the same pingroups. For dynamic runtime
> toggling of pin states, we should eventually always use just
> pinctrl_select_dynamic().

Something in this series should edit Documentation/pinctrl.txt to
explain the philosophy behind the static/dynamic state split. That
philosophy and/or semantics are more important to review than the code...

Related to that, I'm worried that using pinctrl_select_state() and
pinctrl_select_dynamic() appear to be mutually-exclusive options here.
Why shouldn't e.g. a pinctrl-based I2C mux also be able to do runtime
PM? Does the mux setting select which states are used for runtime PM, or
does runtime PM override the basic mux setting, or must the pincrl-I2C
mux manually implement custom runtime-PM/pinctrl interaction since
there's no generic answer to those questions? How many more custom
exceptions will there be?
