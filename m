From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] N900: add device tree
Date: Thu, 4 Jul 2013 20:19:39 +0300
Message-ID: <20130704171939.GA27374@blackmetal.musicnaut.iki.fi>
References: <20130613141001.GF8164@atomide.com>
 <20130613142809.GA3775@amd.pavel.ucw.cz>
 <20130613145724.GH8164@atomide.com>
 <20130613155240.GB3775@amd.pavel.ucw.cz>
 <20130613161418.GJ8164@atomide.com>
 <20130613230808.GA14876@amd.pavel.ucw.cz>
 <20130614055629.GM8164@atomide.com>
 <20130614212816.GA31768@atrey.karlin.mff.cuni.cz>
 <20130617111031.GQ20992@atomide.com>
 <20130701211753.GC15318@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130701211753.GC15318@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, b-cousson@ti.com, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 01, 2013 at 11:17:54PM +0200, Pavel Machek wrote:
> This adds device tree with neccessary support to boot with functional
> video (on both emulator and real N900 device).

Is this really correct? You have commented out the USB, so there is no
way for a developer to interact with the device.

Some minor issue too:

> +/*
> + * Copyright (C) 2013 Pavel Machek <pavel@ucw.cz>
> + * Copyright 2013 Aaro Koskinen <aaro.koskinen@iki.fi>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 (or later) as
> + * published by the Free Software Foundation.

Should be just GPLv2.

A.
