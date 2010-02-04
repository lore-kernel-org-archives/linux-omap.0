From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] Input: ads7846: add regulator support
Date: Thu, 04 Feb 2010 17:08:11 +0200
Message-ID: <4B6AE2DB.90809@compulab.co.il>
References: <1265290758-2035-1-git-send-email-notasas@gmail.com> <20100204142439.GA1139@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100204142439.GA1139@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Mark Brown wrote:
> On Thu, Feb 04, 2010 at 03:39:18PM +0200, Grazvydas Ignotas wrote:
> 
>> The ADS7846/TSC2046 touchscreen controllers can (and usually are)
>> connected to various regulators for power, so add regulator support.
>> Make it optional for now to avoid breaking all current users of this
>> driver.
> 
> This should not be required.  The regulator API stubs itself out when it
> is not built so all API calls report as successful.

And what about boards that have the ads7846 tied to power rail and still
want to use regulator API for other staff?

>> +	ts->reg = regulator_get(&spi->dev, "vcc");
>> +	if (!IS_ERR(ts->reg)) {
>> +		err = regulator_enable(ts->reg);
>> +		if (err)
>> +			goto err_put_regulator;
>> +	}
> 
> If the regulator API is not compiled in then the regulator_get() will
> return succesfully.  If the regulator API is in use then failure to
> acquire the regulator is a serious problem which really should be at a
> minimium be being communicated to the user.  For example, the regulator
> API may end up powering down regulators which it believes are unused or
> the regulator may not be powered by default and needs to be enabled.
> 
> The updates to fix up the boards that need this are fairly
> straightforward and given that it's fairly easy to identify systems
> which are using the driver in mainline so I'd really prefer not to go
> down the route of trying to carry on in the face of error, it papers
> over stuff now but is not robust in the face of future changes.

The updates are straightforward for boards that actually _have_
regulator powering the touchscreen controller. What about the boards
that do not have such a regulator?

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.
