From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] power: bq24190_charger: Check the interrupt status
 on resume
Date: Mon, 23 Jan 2017 16:47:43 -0800
Message-ID: <20170124004742.GZ7403@atomide.com>
References: <20170120220440.1971-1-tony@atomide.com>
 <20170120220440.1971-2-tony@atomide.com>
 <20170122015441.wzsbigozefzr5wzw@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170122015441.wzsbigozefzr5wzw@earth>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [170121 17:55]:
> Hi Tony,
> 
> I think your runtime_resume is missing runtime_pm_get/put_sync, see
> below:
> 
> On Fri, Jan 20, 2017 at 02:04:39PM -0800, Tony Lindgren wrote:
> > [...]
> > +static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
> > +{
> > +	struct bq24190_dev_info *bdi = data;
> > +
> > +	bdi->irq_event = true;
> > +	pm_runtime_get_sync(bdi->dev);
> > +	bq24190_check_status(bdi);
> > +	pm_runtime_put_sync(bdi->dev);
> 
> bq24190_check_status is called with runtime_pm enabled.
> 
> > +	bdi->irq_event = false;
> >  
> >  	return IRQ_HANDLED;
> >  }
> >
> > [...]
> >
> > +static int bq24190_runtime_resume(struct device *dev)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
> > +
> > +	if (!bdi->initialized)
> > +		return 0;
> > +
> > +	if (!bdi->irq_event) {
> > +		dev_dbg(bdi->dev, "checking events on possible wakeirq\n");
> > +		bq24190_check_status(bdi);
> 
> bq24190_check_status is called without runtime_pm enabled.

But it's the runtime_resume call we're calling it from :)

I don't think there is anything to configure in bq24190 at least
at this point, we just want to see if we got the wakeirq call
resume while in some deeper idle state.

Regards,

Tony
