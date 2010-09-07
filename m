From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: omap3: regulator_get() failure in ads7846
Date: Tue, 7 Sep 2010 12:56:33 +0100
Message-ID: <20100907115633.GB25830@sirena.org.uk>
References: <B85A65D85D7EB246BE421B3FB0FBB59301F6C8381A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F6C8381A@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 07, 2010 at 05:16:44PM +0530, Premi, Sanjeev wrote:

> ts->reg = regulator_get(&spi->dev, "vcc");

> This regulator isn't defined for omap3evm. And I suspect - once
> defined - the name will be different than "vcc".

What makes you say this?  The names for regulator supplies are defined
in terms of the chip being supplied, not in terms of the board.

> Looking at pointers on how this should be handled.

The best thing to do is to define the mapping for the regulator.  You
can work around it by enabling REGULATOR_DUMMY.
