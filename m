From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 2/3] mfd: lp873x: Add lp873x PMIC support
Date: Tue, 9 Aug 2016 10:44:16 +0100
Message-ID: <20160809094416.GX5243@dell>
References: <1467215067-6486-1-git-send-email-j-keerthy@ti.com>
 <1467215067-6486-3-git-send-email-j-keerthy@ti.com>
 <20160805080322.GO5243@dell>
 <57A44D21.2080106@ti.com>
 <20160805090147.GT5243@dell>
 <57A81849.7010707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57A81849.7010707@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, linus.walleij@linaro.org, gnurou@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Mon, 08 Aug 2016, Keerthy wrote:
> On Friday 05 August 2016 02:31 PM, Lee Jones wrote:
> > On Fri, 05 Aug 2016, Keerthy wrote:
> > > On Friday 05 August 2016 01:33 PM, Lee Jones wrote:
> > > > On Wed, 29 Jun 2016, Keerthy wrote:
> > > > 
> > > > > The LP873X chip is a power management IC for Portable Navigation Systems
> > > > >       and Tablet Computing devices. It contains the following components:
> > > > > 
> > > > >        - Regulators.
> > > > >        - Configurable General Purpose Output Signals(GPO).
> > > > > 
> > > > > PMIC interacts with the main processor through i2c. PMIC has
> > > > > couple of LDOs(Linear Regulators), couple of BUCKs (Step-Down DC-DC
> > > > > Converter Cores) and GPOs(General Purpose Output Signals).
> > > > > 
> > > > > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > > > > ---
> > > > > 
> > > > > Changes in v4:
> > > > > 
> > > > >     * Added Author.
> > > > >     * Added the mfd_cell for gpio.
> > > > > 
> > > > > Changes in v3:
> > > > > 
> > > > >     * Reordered the probe code.
> > > > >     * Fixed Typo in Kconfig description.
> > > > >     * Removed unused member from struct lp873x.
> > > > > 
> > > > >    drivers/mfd/Kconfig        |  14 +++
> > > > >    drivers/mfd/Makefile       |   2 +
> > > > >    drivers/mfd/lp873x.c       |  99 +++++++++++++++++
> > > > >    include/linux/mfd/lp873x.h | 264 +++++++++++++++++++++++++++++++++++++++++++++
> > > > >    4 files changed, 379 insertions(+)
> > > > >    create mode 100644 drivers/mfd/lp873x.c
> > > > >    create mode 100644 include/linux/mfd/lp873x.h

[...]

> > > > > +static const struct i2c_device_id lp873x_id_table[] = {
> > > > > +	{ "lp873x", LP873X },
> > > > > +	{ "lp8732", LP873X },
> > > > > +	{ "lp8733", LP873X },
> > > > 
> > > > Do you use these IDs at any point?
> > > 
> > > I have lp8733 and lp8732 at the moment. They are register exact but
> > > different parts none the less. Hence having separate strings. As of now no
> > > differences seen in gpio/regulator modules so not using them anywhere.
> > 
> > I have a patch-set pending on the I2C list that removes all unused
> > 'struct i2c_device_id' tables.  To identify which ones are in use and
> > which ones can be removed, it would help if you could remove the
> > unused .id field.
> 
> I guess you are referring to this:
> 
> http://www.gossamer-threads.com/lists/linux/kernel/2457552
> 
> I applied the above series and i see that by using driver_new in lp873x
> MFD driver i no longer need the mandatory i2c_device_id. Thanks.
> I will send a series on top of your i2c set v5 without any unused device_id.
> I will add a dependency on your set.

I would not do that if I were you.  That set has been pending for
years.  I'm just saying, when that patch-set is accepted, it will be
easier to identify removable tables if they do not contain populated,
but unused .id entries.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
