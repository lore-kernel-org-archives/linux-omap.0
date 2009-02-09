From: Joonyoung Shim <dofmind@gmail.com>
Subject: Re: [PATCH] twl4030-gpio: Fix getting the value of the TWL4030 GPIO
	output pin
Date: Mon, 9 Feb 2009 22:02:28 +0900
Message-ID: <4e1455be0902090502l554ca462m9c096e359a5b29c3@mail.gmail.com>
References: <4e1455be0902062213o769a4d15ha0c892508839dbad@mail.gmail.com>
	 <200902070000.49089.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:28243 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbZBINCa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 08:02:30 -0500
In-Reply-To: <200902070000.49089.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

2009/2/7 David Brownell <david-b@pacbell.net>:
> On Friday 06 February 2009, Joonyoung Shim wrote:
>> If TWL4030 GPIO pin is output, must read the value from REG_GPIODATAOUTx
>> register in twl4030_get_gpio_datainout().
>
> Why "must"?  The goal is to return the *actual* value of the pin,
> not the intended one.  When an external signal overwhelms the drive
> capability of that GPIO -- just a couple mA -- the correct value
> to return can't be the value written in the output register.

but, it doesn't return actual value of the pin if twl4030 GPIO pin is output.

For example, the GPIO13 pin of twl4030 is configured as an output
using gpio_direction_output() and assigns the GPIO's value to 1
using gpio_set_value_cansleep(), the result of "# cat /sys/kernel/debug/gpio"
reports to me as follows.

GPIOs 192-209, platform/twl4030_gpio, twl4030, can sleep:
 gpio-205 (keyled              ) out lo

but it should have reported "hi" instead of "lo".


>
> Plus, this patch won't even link ... you changed the name of the
> function at its definition, but not at its use points.

Sorry, i missed some code.

>
> NAK, unless you can show there's a real bug this addresses...
>
> - Dave
>
