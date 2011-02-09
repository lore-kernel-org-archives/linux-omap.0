From: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Subject: Re: [PATCH v2 2/2] omap3: beaglexm: fix DVI initialization
Date: Wed, 09 Feb 2011 09:47:09 -0200
Message-ID: <1297252029.15396.4.camel@evatp>
References: <1297194235-7376-1-git-send-email-ricardo.salveti@canonical.com>
	 <1297194235-7376-3-git-send-email-ricardo.salveti@canonical.com>
	 <AANLkTin9VRwgMyw9LUr691n++QByq14JGdARwN3ZVqW0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:56816 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab1BILrQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 06:47:16 -0500
In-Reply-To: <AANLkTin9VRwgMyw9LUr691n++QByq14JGdARwN3ZVqW0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, charu@ti.com

On Wed, 2011-02-09 at 12:23 +0530, G, Manjunath Kondaiah wrote:
> On Wed, Feb 9, 2011 at 1:13 AM, Ricardo Salveti de Araujo
> <ricardo.salveti@canonical.com> wrote:
> > Function beagle_twl_gpio_setup is called after beagle_display_init, what
> > lets reset_gpio with an invalid value at the time it request the gpio.
> > As a side effect the DVI reset GPIO is not properly set.
> >
> > Also removing old code that powers down DVI in a hardcoded way, as it's
> > not necessary anymore.
> >
> > Tested with Beagle-xM and C4.
> 
> Surprised to see if this code works on C4 since there is gpio_request
> for gpio_170 in the beagle init code
> (linux omap master branch) which is before beagle_display_init()
> 
>         omap_mux_init_gpio(170, OMAP_PIN_INPUT);
>         gpio_request(170, "DVI_nPD");
>         /* REVISIT leave DVI powered down until it's needed ... */
>         gpio_direction_output(170, true);
> 
> The second gpio_request(for 170) should fail in beagle_display_init.
> Pls check and confirm.

That's why this part is also removed at my patch.

Cheers,
--
Ricardo Salveti de Araujo

