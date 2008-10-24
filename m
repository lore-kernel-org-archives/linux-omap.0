From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [patch 2.6.27-omap-git 3/4] remove omap_set_gpio_direction()
Date: Fri, 24 Oct 2008 10:00:31 +0300
Message-ID: <20081024100031.0d5a1db5.jarkko.nikula@nokia.com>
References: <200810222356.21049.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21872 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYJXHBG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 03:01:06 -0400
In-Reply-To: <200810222356.21049.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Wed, 22 Oct 2008 23:56:20 -0700
"ext David Brownell" <david-b@pacbell.net> wrote:

> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> More conversion to the standard GPIO interfaces:  stop using
> omap_set_gpio_direction() entirely, and switch over completely
> to the gpio_direction_output() call.

>  drivers/cbus/cbus.c                     |   13 ++++++-------
>
Not for David, but somebody here at Nokia should look/remember is hack
below really necessary:

#ifdef CONFIG_ARCH_OMAP1
/* We use our own MPUIO functions to get closer to 1MHz bus speed */

>  drivers/leds/leds-omap.c                |    2 +-
>
IMO this driver should go and board-palmtt.c to use
drivers/leds/leds-gpio.c instead.


Jarkko
