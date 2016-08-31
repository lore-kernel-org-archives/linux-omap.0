From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 1/3] mfd: lp873x: Add lp873x PMIC support
Date: Wed, 31 Aug 2016 12:16:04 +0100
Message-ID: <20160831111604.GG27357@dell>
References: <1470977889-27991-1-git-send-email-j-keerthy@ti.com>
 <1470977889-27991-2-git-send-email-j-keerthy@ti.com>
 <20160831075633.GO10121@dell>
 <c54c042b-1661-07a4-53f9-c67550a41e68@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c54c042b-1661-07a4-53f9-c67550a41e68@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, broonie@kernel.org, linus.walleij@linaro.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 31 Aug 2016, Keerthy wrote:
> On Wednesday 31 August 2016 01:26 PM, Lee Jones wrote:
> > On Fri, 12 Aug 2016, Keerthy wrote:
> > 
> > > The LP873X chip is a power management IC for Portable Navigation Systems
> > >     and Tablet Computing devices. It contains the following components:
> > > 
> > >      - Regulators.
> > >      - Configurable General Purpose Output Signals(GPO).

[...]

> > > +static const struct i2c_device_id lp873x_id_table[] = {
> > > +	{ "lp873x", LP873X },
> > > +	{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, lp873x_id_table);
> > 
> > Don't set the ID in this table.
> 
> I did not understand this. Could you please elaborate?
> You mean no need of LP873X can just be a '0' as i am seeing in other mfd
> drivers?

Just leave it blank.  No need for the second attribute.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
