From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3: regulator_get() failure in ads7846
Date: Tue, 7 Sep 2010 18:56:47 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6C838DE@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301F6C8381A@dbde02.ent.ti.com>
 <20100907115633.GB25830@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100907115633.GB25830@sirena.org.uk>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-input-owner@vger.kernel.org 
> [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Mark Brown
> Sent: Tuesday, September 07, 2010 5:27 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; linux-input@vger.kernel.org
> Subject: Re: omap3: regulator_get() failure in ads7846
> 
> On Tue, Sep 07, 2010 at 05:16:44PM +0530, Premi, Sanjeev wrote:
> 
> > ts->reg = regulator_get(&spi->dev, "vcc");
> 
> > This regulator isn't defined for omap3evm. And I suspect - once
> > defined - the name will be different than "vcc".
> 
> What makes you say this?  The names for regulator supplies are defined
> in terms of the chip being supplied, not in terms of the board.

[sp] The name "vcc" is too generic name for the regulator supply. If
     there were more than one supplies as in case of the omap3evm, it
     would be difficult to name the supply as "vcc".

     Assuming there is another (different) driver which uses "vcc"
     (as ads7846 uses currently) but uses different supply, what is
     expected behavior?

     If, however, the name here was something like "vcc_ts", then
     the supplies could be defined for any board as:

     static struct regulator_consumer_supply my_board_ts_supply = {
        .supply	= "vcc_ts",
     };

     This would be more portable for other boards as well.

     OR

     Does regulator_get() searches by "device_name-supply_id" pair?
     Then, my comments above don't hold... And I would try the
     mapping you mentioned below.

> 
> > Looking at pointers on how this should be handled.
> 
> The best thing to do is to define the mapping for the regulator.  You
> can work around it by enabling REGULATOR_DUMMY.

[sp] Yes, this would be a workaround; but it comes with another
     warning on console.

Best regards,
Sanjeev

> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 