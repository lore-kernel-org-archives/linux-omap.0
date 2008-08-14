From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] input: add more error checks to lm8323 driver
Date: Thu, 14 Aug 2008 17:36:02 +0300
Message-ID: <20080814143601.GG9226@atomide.com>
References: <1218648977-5685-1-git-send-email-felipe.balbi@nokia.com> <1218648977-5685-2-git-send-email-felipe.balbi@nokia.com> <1218648977-5685-3-git-send-email-felipe.balbi@nokia.com> <1218648977-5685-4-git-send-email-felipe.balbi@nokia.com> <20080814133432.GD9226@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50696 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbYHNOfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2008 10:35:00 -0400
Content-Disposition: inline
In-Reply-To: <20080814133432.GD9226@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080814 16:32]:
> * Felipe Balbi <felipe.balbi@nokia.com> [080813 20:37]:
> > If we can't reach the driver, we stop trying to probe
> > it. Useful when building kernel for n800 and n810.
> > 
> > n800 doesn't have lm8323, so that driver shouldn't probe
> > there.
> 
> Pushing today.

Actually this breaks the keyboard on n810 as lm8323_reset() fails
during probe. And I guess n800 should not call probe now at all
as the I2C device is not registered. So I'll revert this for now.

Tony

> 
> Tony
> 
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  drivers/input/keyboard/lm8323.c |   42 +++++++++++++++++++++++++++++---------
> >  1 files changed, 32 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
> > index 72bb587..3d10a0f 100644
> > --- a/drivers/input/keyboard/lm8323.c
> > +++ b/drivers/input/keyboard/lm8323.c
> > @@ -348,10 +348,10 @@ static void lm8323_process_error(struct lm8323_chip *lm)
> >  	}
> >  }
> >  
> > -static void lm8323_reset(struct lm8323_chip *lm)
> > +static int lm8323_reset(struct lm8323_chip *lm)
> >  {
> >  	/* The docs say we must pass 0xAA as the data byte. */
> > -	lm8323_write(lm, 2, LM8323_CMD_RESET, 0xAA);
> > +	return lm8323_write(lm, 2, LM8323_CMD_RESET, 0xAA);
> >  }
> >  
> >  static int lm8323_configure(struct lm8323_chip *lm)
> > @@ -360,6 +360,7 @@ static int lm8323_configure(struct lm8323_chip *lm)
> >  	int clock = (CLK_SLOWCLKEN | CLK_RCPWM_EXTERNAL);
> >  	int debounce = lm->debounce_time >> 2;
> >  	int active = lm->active_time >> 2;
> > +	int ret;
> >  
> >  	/*
> >  	 * Active time must be greater than the debounce time: if it's
> > @@ -368,13 +369,25 @@ static int lm8323_configure(struct lm8323_chip *lm)
> >  	if (debounce >= active)
> >  		active = debounce + 3;
> >  
> > -	lm8323_write(lm, 2, LM8323_CMD_WRITE_CFG, 0);
> > -	lm8323_write(lm, 2, LM8323_CMD_WRITE_CLOCK, clock);
> > -	lm8323_write(lm, 2, LM8323_CMD_SET_KEY_SIZE, keysize);
> > +	ret = lm8323_write(lm, 2, LM8323_CMD_WRITE_CFG, 0);
> > +	if (ret)
> > +		goto err;
> > +	ret = lm8323_write(lm, 2, LM8323_CMD_WRITE_CLOCK, clock);
> > +	if (ret)
> > +		goto err;
> > +	ret = lm8323_write(lm, 2, LM8323_CMD_SET_KEY_SIZE, keysize);
> > +	if (ret)
> > +		goto err;
> >  	lm8323_set_active_time(lm, lm->active_time);
> > -	lm8323_write(lm, 2, LM8323_CMD_SET_DEBOUNCE, debounce);
> > -	lm8323_write(lm, 3, LM8323_CMD_WRITE_PORT_STATE, 0xff, 0xff);
> > -	lm8323_write(lm, 3, LM8323_CMD_WRITE_PORT_SEL, 0, 0);
> > +	ret = lm8323_write(lm, 2, LM8323_CMD_SET_DEBOUNCE, debounce);
> > +	if (ret)
> > +		goto err;
> > +	ret = lm8323_write(lm, 3, LM8323_CMD_WRITE_PORT_STATE, 0xff, 0xff);
> > +	if (ret)
> > +		goto err;
> > +	ret = lm8323_write(lm, 3, LM8323_CMD_WRITE_PORT_SEL, 0, 0);
> > +	if (ret)
> > +		goto err;
> >  
> >  	/*
> >  	 * Not much we can do about errors at this point, so just hope
> > @@ -382,6 +395,11 @@ static int lm8323_configure(struct lm8323_chip *lm)
> >  	 */
> >  
> >  	return 0;
> > +
> > +err:
> > +	dev_err(&lm->client->dev, "failed to configure lm8323\n");
> > +
> > +	return ret;
> >  }
> >  
> >  /*
> > @@ -721,7 +739,9 @@ static int lm8323_probe(struct i2c_client *client,
> >  	else if (lm->active_time == -1) /* Disable sleep. */
> >  		lm->active_time = 0;
> >  
> > -	lm8323_reset(lm);
> > +	err = lm8323_reset(lm);
> > +	if (err)
> > +		goto fail2;
> >  
> >  	/* Nothing's set up to service the IRQ yet, so just spin for max.
> >  	 * 100ms until we can configure. */
> > @@ -738,7 +758,9 @@ static int lm8323_probe(struct i2c_client *client,
> >  
> >  		msleep(1);
> >  	}
> > -	lm8323_configure(lm);
> > +	err = lm8323_configure(lm);
> > +	if (err)
> > +		goto fail2;
> >  
> >  	/* If a true probe check the device */
> >  	if (lm8323_read_id(lm, data) != 0) {
> > -- 
> > 1.6.0.rc1.71.gfba5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
