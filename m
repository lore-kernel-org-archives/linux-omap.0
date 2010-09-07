From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: omap3: regulator_get() failure in ads7846
Date: Tue, 7 Sep 2010 15:18:40 +0100
Message-ID: <20100907141839.GA31268@opensource.wolfsonmicro.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301F6C8381A@dbde02.ent.ti.com>
 <20100907115633.GB25830@sirena.org.uk>
 <B85A65D85D7EB246BE421B3FB0FBB59301F6C838DE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F6C838DE@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 07, 2010 at 06:56:47PM +0530, Premi, Sanjeev wrote:

> > From: linux-input-owner@vger.kernel.org 
> > [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Mark Brown

> > What makes you say this?  The names for regulator supplies are defined
> > in terms of the chip being supplied, not in terms of the board.

> [sp] The name "vcc" is too generic name for the regulator supply. If
>      there were more than one supplies as in case of the omap3evm, it
>      would be difficult to name the supply as "vcc".

As I said above: these are defined in terms of the *chip* being
supplied.  The name of the pin on the device does not change depending
on which board they're soldered down on and is orthogonal to both the
name of the supply on the regulator and both are orthogonal to the name
the rail is given on a given board.

>      Assuming there is another (different) driver which uses "vcc"
>      (as ads7846 uses currently) but uses different supply, what is
>      expected behavior?

The expected behaviour is that both devices request the supplies under
the names that they are given by the chip.

>      If, however, the name here was something like "vcc_ts", then
>      the supplies could be defined for any board as:

>      static struct regulator_consumer_supply my_board_ts_supply = {
>         .supply	= "vcc_ts",
>      };

>      This would be more portable for other boards as well.

Using strings like this doesn't scale - you may have two devices of a
given type with different supply arrangements on a board, for example.

>      Does regulator_get() searches by "device_name-supply_id" pair?
>      Then, my comments above don't hold... And I would try the
>      mapping you mentioned below.

Yes, this is the reason why we require the struct device in get().

> > > Looking at pointers on how this should be handled.

> > The best thing to do is to define the mapping for the regulator.  You
> > can work around it by enabling REGULATOR_DUMMY.

> [sp] Yes, this would be a workaround; but it comes with another
>      warning on console.

Yes, you're not really supposed to use it in production.
