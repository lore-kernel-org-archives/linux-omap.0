From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
Date: Fri, 19 Sep 2014 08:37:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.10.1409190710320.5612@nanos>
References: <1411067086-16613-1-git-send-email-nm@ti.com>
 <1411067086-16613-4-git-send-email-nm@ti.com>
 <alpine.DEB.2.10.1409181749170.4206@nanos> <20140919030333.GA6088@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140919030333.GA6088@kahuna>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@linaro.org>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, lee.jones@linaro.org, LAK <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 18 Sep 2014, Nishanth Menon wrote:
> On 17:57-20140918, Thomas Gleixner wrote:
> 
> I suppose I can improve the commit message to elaborate this better?
> Will that help?

You also want to improve the comment in the empty handler.

> > 
> > > +	 */
> > > +	return IRQ_NONE;

And it still does not explain WHY you think that returning IRQ_NONE is
the right thing to do here. You actually handle the interrupt, right?
Just because the handler is an NOP does not mean you did not handle
it.

> > > +static int palmas_i2c_suspend(struct i2c_client *i2c,  pm_message_t mesg)
> > > +{
> > > +	struct palmas *palmas = i2c_get_clientdata(i2c);
> > > +	struct device *dev = &i2c->dev;
> > > +
> > > +	if (!palmas->wakeirq)
> > > +		return 0;
> > > +
> > > +	if (device_may_wakeup(dev))
> > > +		enable_irq(palmas->wakeirq);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int palmas_i2c_resume(struct i2c_client *i2c)
> > > +{
> > > +	struct palmas *palmas = i2c_get_clientdata(i2c);
> > > +	struct device *dev = &i2c->dev;
> > > +
> > > +	if (!palmas->wakeirq)
> > > +		return 0;
> > > +
> > > +	if (device_may_wakeup(dev))
> > > +		disable_irq_nosync(palmas->wakeirq);
> > 
> > Again, why nosync?
> true - nosync is not necessary at here. disable_irq is however necessary
> as we are not interested in wakeup events for level changes.
> 
> We just use the enable/disable to control when we'd want to arm the pin
> for waking up from suspend state.

And what is issuing the call to enable/disable_irq_wake()? 

So if that interrupt is not marked proper then you can bring your
device into a wont resume state easily

       start suspend
       enable wakeirq
       disable_device_irqs()
	   if (!iswakeup_irq())
	      disable_irq() // does not mask due to lazy masking

       ....
       wakeirq fires
          if (irq_is_disabled())
	     mask_irq();

       transition into suspend

Now your pinctrl irq is masked at the HW level and wont wake the
machine up ever again.

So now looking at that pinctrl irq chip thing, which seems to be
designed to handle these kind of wakeups. That thing looks massivly
wrong as well, simply because it enforces to use
enable_irq/disable_irq().

So because the sole purpose of this chip is to handle the separate
wakeup style interrupt, it should actually NOT enable the interrupt in
the irq_unmask callback.

Simply because during normal operation nothing is interested in the
interrupt and any operation which might enable it (including request
irq) is just making the system handle completely pointless interrupts
and hoops and loops juggling with enable/disable irq.

So the right thing here is to have an empty unmask function and do the
actual unmask only in the irq_set_wake() callback. mask of course
needs to do what it says. The point is, that the following sequence of
code will just work w/o generating an interrupt on the wakeirq line
outside of the wake enabled context.

dev_init()
	request_wakeirq();

suspend()
	if (may_wake())
	   enable_irq_wake();

resume()
	if (may_wake())
	   disable_irq_wake();

The other omap drivers using this have the same issue ... And of
course they are subtly different.

The uart one handles the actual device interrupt, which is violating
the general rule of possible interrupt reentrancy in the pm-runtime
case if the two interrupts are affine to two different cores. Yes,
it's protected by a lock and works by chance ....

The mmc one issues a disable_irq_nosync() in the wakeup irq handler
itself.

WHY does one driver need that and the other does not? You are not even
able to come up with a common scheme for OMAP. I don't want to see the
mess others are going to create when this stuff becomes more used.

Thanks,

	tglx
