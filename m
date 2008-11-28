From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] TPS6235x drivers added in drivers/i2c/chips.
Date: Thu, 27 Nov 2008 22:32:14 -0800
Message-ID: <200811272232.15187.david-b@pacbell.net>
References: <1227850090-16131-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:37244 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751220AbYK1GcR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 01:32:17 -0500
In-Reply-To: <1227850090-16131-1-git-send-email-mani.pillai@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Thursday 27 November 2008, Manikandan Pillai wrote:
> Implements the basic driver for TPS6235x devices populated on the
> PR785 board. tps6235x.c contains the driver code for TPS devices used on 
> PR785 boards. Driver code is added it to the build.
> 
> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
> ---
>  drivers/i2c/chips/Makefile   |    1 +
>  drivers/i2c/chips/tps6235x.c |  416 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 417 insertions(+), 0 deletions(-)

Really quick comments only ... key point:  plan to merge this to
mainline instead of just the OMAP tree.  Which means you should
be structuring the driver (and patch) in more standard ways from
the first, notably:

 - Both drivers/i2c/chips/Makefile and its Kconfig sibling
   are very clear:  don't add new drivers to that directory!

 - Patches that add drivers should be standalone and, as much
   as possible, complete.  In this case, it's missing Kconfig.

In this case, the driver seems to most naturally live in the
new drivers/regulator subtree, and implement the regulator
interface.  If it doesn't fit well ... that's a reason to
suggest updates to that regulator framework(*).

Using the regulator framework will also affect how you merge
board support.  Wanting a pr785_enbl_dcdc() board-specific
call is a clue that you're doing something wrong... in this
case, regulator_enable() and regulator_disable() will do
the job much more politely.

A subsequent patch iteration should probably go to LKML.


You'll get this comment before long, so I'll say it right
now:  use i2c_smbus_{read,write}_byte_data() calls instead
of the lower level I2C calls.  It'll be more portable, and
use less code in this driver ... even if it does increase
the runtime cost of these (infrequent) calls.


> +static const struct i2c_device_id tps_6235x_id[] = {
> +	{ "tps62352_core_pwr", 0},
> +	{ "tps62353_mpu_pwr", 1},
> +	{},
> +};

Strike the "_core_pwr" and "_mpu_pwr" suffixes.  Those are
not inherent tasks of the chip; they are policies set up
by board designs, and recognized in software by how the
components get set up.  This driver shouldn't try to care
about such board-specific policies.

The data sheet covers TPS6254x for x in 0..6 but this driver
omits most of those.  Best to support them all.

- Dave

(*) The regulator framework is new.  It does, and will,
    need changes to make sure it does what it needs to do.
    You might not encounger such issues.  Or, you might...

 
