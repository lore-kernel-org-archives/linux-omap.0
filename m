From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH 1/3] ASoC: Add GPIO support for
	jack	reporting interface
Date: Sun, 1 Mar 2009 19:54:36 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECC77374@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com>
	<20090226115243.GC4229@sirena.org.uk>
	<2C7D3DF36ADFFC479B44490D912B616705ECC76DF8@dlee07.ent.ti.com>
	<20090227130502.GA4415@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090227130502.GA4415@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> > * Create a new structure "snd_soc_jack_gpio" holding info 
> > specific for a gpio pin like: gpio, irq, irqflags,
> > irqhandler, private data (to be passed to irqhandler).
> 
> Yes, roughly.  The jack_gpio will also need to know the 
> status bits to update and which jack to update.  I'd expect 
> something along the lines
> of:
> 
> struct snd_soc_jack_gpio {
> 	struct snd_soc_jack *jack;
> 	int report;         /* Value to report when jack detected */
> 	int invert_report;  /* Report presence when GPIO low */
> 	int gpio;           /* GPIO to read */
> };
> 
> possibly with some other data stored (eg, a debounce time).  
> You can use gpio_to_irq() to get the interrupt number.
> 
> If the machine drivers need to customise the IRQ handler code 
> itself then it's probably getting to the point where another 
> detection method should be written, though perhaps I'm 
> missing something?

Well, customise the IRQ handler itself probably not since the
irq handler only needs to queue a work for doing the actual
detection/report. There can be a generic detection/report function
for gpio, I was thinking in something like:

void gpio_detect(struct snd_soc_jack_gpio *gpio)
{
        struct snd_soc_jack *jack = gpio->jack;
        int enable;
        int report;

        if (gpio->debounce_time > 0)
                mdelay(gpio->debounce_time);

        enable = gpio_get_value(gpio->gpio);
        if (gpio->invert)
                enable != enable;

        if (enable)
                report = gpio->report;
        else
                report = 0;

        snd_soc_jack_report(jack, report, gpio->report);
}

This way we will be updating only bits associated to that particular
gpio. But in a previous mail you mentioned about a case:

> Some systems won't be able to use their speaker output while a
> headphone is connected and so will want to make sure to update
> both speaker and headphone when the headphone jack status
> changes.

Having a single/generic report function like shown above (as is) we
can't handle that case.

Could we leave the actual implementation of this report function to
the machine driver? Since the things being done in detection function
are common (even if other status are wanted to be updated), then
probably machine driver could define a specific function ("action")
for doing extra tasks, it can be called from generic gpio detect
function. Could it be a valid approach?

-Misa
