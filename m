From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv3 1/2] Input: pwm-vibra: new driver
Date: Wed, 10 May 2017 14:56:50 -0700
Message-ID: <20170510215650.GA29507@dtor-ws>
References: <20170505092823.26009-1-sebastian.reichel@collabora.co.uk>
 <20170505092823.26009-2-sebastian.reichel@collabora.co.uk>
 <20170507213800.GA39686@dtor-ws>
 <20170508185128.2vkgkxn6cfnmkqc7@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170508185128.2vkgkxn6cfnmkqc7@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 08, 2017 at 08:51:28PM +0200, Sebastian Reichel wrote:
> On Sun, May 07, 2017 at 02:38:00PM -0700, Dmitry Torokhov wrote:
> > > +static int __maybe_unused pwm_vibrator_suspend(struct device *dev)
> > > +{
> > > +	struct platform_device *pdev = to_platform_device(dev);
> > > +	struct pwm_vibrator *vibrator = platform_get_drvdata(pdev);
> > > +	struct input_dev *input = vibrator->input;
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&input->event_lock, flags);
> > 
> > Hmm, no, this is not goting to work. The original patch had a chance if
> > PWM was not sleeping, but with introduction of regulator and work this
> > definitely sleeps.
> 
> Actually PWM is sleeping, that's why I added work (regulator was
> added later) :)
> 
> > I think we should solve issue of events [not] being delivered during
> > suspend transition in input core, and simply drop spin_lock_irqsave()
> > here and in resume().
> 
> Sounds good. will you take care of the input-core change?

Yeah, I'll add it to my todo... In the mean time, when you sending a new
version of this driver simply drop
spin_lock_irqsave/spin_unlock_irqrestore.

Thanks.

-- 
Dmitry
