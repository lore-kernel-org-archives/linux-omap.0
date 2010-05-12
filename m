From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/2] input: touchscreen: introduce tsc2005 driver
Date: Tue, 11 May 2010 17:03:36 -0700
Message-ID: <20100512000336.GS13931@atomide.com>
References: <1271688664-21525-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1271688664-21525-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, dmitry.torokhov@gmail.com, Lauri Leukkunen <lauri.leukkunen@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@nokia.com> [100419 07:47]:
> From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
> 
> Introduce a driver for the Texas Instruments TSC2005 touchscreen
> controller (http://focus.ti.com/docs/prod/folders/print/tsc2005.html).
> 
> The patch is based on a driver by Lauri Leukkunen, with modifications
> by David Brownell, Phil Carmody, Imre Deak, Hiroshi DOYU, Ari Kauppi,
> Tony Lindgren, Jarkko Nikula, Eero Nurkkala and Roman Tereshonkov.
> 
> Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
> [aaro.koskinen@nokia.com: patch description, rebasing & cleanup]
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>
> Cc: Imre Deak <imre.deak@nokia.com>
> Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Cc: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> ---
> 
> v4: Refreshed the patches against the current mainline
> (13bd8e4673d527a9e48f41956b11d391e7c2cfe0). No other changes as no
> comments were received.
> 
> The v3 has some major modifications. I have tried to clean up and simplify
> the driver. All action takes place in thread context, SPI transfers are
> synchronous, the spinlock is removed, and there are no long sections
> with interrupts disabled. The driver should be now SMP safe.
> 
> Also the following review comments are addressed:
> 	- Use del_timer_sync() instead of del_timer().
> 	- Use mod_timer() always instead of add_timer().
> 	- Use attribute_group.
> 	- Delete filtering and averaging which belong to upper layers.
> 	- Delete pen_down sysfs file.
> 
> The previous version and comments can be seen here:
> http://marc.info/?t=125734115600004&r=1&w=2

Any news on this? Would be nice to get this merged in as it sounds
like the N900 display will finally be usable in the mainline kernel
too.

Regards,

Tony
