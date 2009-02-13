From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Add support for TPS6235x support
Date: Fri, 13 Feb 2009 14:15:53 -0800
Message-ID: <200902131415.54104.david-b@pacbell.net>
References: <1233723366-13053-1-git-send-email-mani.pillai@ti.com> <20090204115110.GA29849@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:30499 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753582AbZBMWP4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2009 17:15:56 -0500
In-Reply-To: <20090204115110.GA29849@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>, Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 04 February 2009, Mark Brown wrote:
> On Wed, Feb 04, 2009 at 10:26:06AM +0530, Manikandan Pillai wrote:
> > The patch has been fixed for comments given by David Brownell
> > and Mark Brown for adding TPS6235x support on OMAP3 EVM.
> > Comments fixed include
> > moving Makefile changes to this patch
> > dev_err used
> > removed the extra configuration option from Kconfig
> 
> > Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
> 
> This looks fine from a regulator API point of view.

So what's the plan for merging it then?  I suspect it
relates to board-specific init ... regulator_register()
having changed signature for the 2.6.30 merge window,
and this FIXME remaining un-addressed:

>        /* FIXME board init code should provide init_data->driver_data
>         * saying how to configure this regulator:  how big is the
>         * inductor (affects light PFM mode optimization), slew rate,
>         * PLL multiplier, and so forth.
>         */

Maybe there should be a <linux/regulator/tps6235x.h>
header with that board-specific data, and the framework
data that's now thankfully not required to be held in
the platform_data.  (That init_data->driver_data was
sort of a workaround for inability to use platform_data
in the normal way...)


The tps6235x_dcdc_is_enabled() function won't handle
I2C errors well ... I suggest at least one retry, and
some fixed return value if that fails (instead of some
bit from the error status).  The big issue of course
is that the regulator framework doesn't believe there
can be errors in such calls.

Part of an answer to that framework issue would be
implementing the new regulator.get_status() operation.
That can return not just enabled/disabled, but also
report the "out of regulation" status ... or errno, in
case of I2C troubles.  (That patch is also in the
merge queue for 2.6.30, plus the current OMAP tree.)


Minor style point:  TPS6235X_VSM_MSK shouldn't be
parenthesizing that constant value.

- Dave


