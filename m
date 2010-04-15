From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 4/5(7)] input: serio: add support for Amstrad Delta
 serial keyboard port
Date: Thu, 15 Apr 2010 09:14:51 -0700
Message-ID: <20100415161451.GA13966@core.coreip.homeip.net>
References: <201004150419.05038.jkrzyszt@tis.icnet.pl>
 <201004150431.06719.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:40227 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab0DOQPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 12:15:01 -0400
Content-Disposition: inline
In-Reply-To: <201004150431.06719.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, e3-hacking@earth.li

Hi Janusz,

On Thu, Apr 15, 2010 at 04:31:03AM +0200, Janusz Krzysztofik wrote:
> +
> +config SERIO_AMS_DELTA
> +	tristate "Amstrad Delta (E3) mailboard support"
> +	depends on MACH_AMS_DELTA
> +	default y
> +	select AMS_DELTA_FIQ
> +	select KEYBOARD_ATKBD

I'd rather not select atkbd here since it is not required for this
driver to work but simply adjust your defconfig.

> +
> +	if (!(machine_is_ams_delta()))
> +		return -ENODEV;

Extra parens.

Otherwise:

	Acked-by: Dmitry Torokhov <dtor@mail.ru>

I assume it is going to be merged with the rest of your patches through
a tree other than linux-input.

-- 
Dmitry
