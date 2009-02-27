From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH 1/3] ASoC: Add GPIO support for
	jack	reporting interface
Date: Fri, 27 Feb 2009 04:52:35 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECC76DF8@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com>
	<20090226115243.GC4229@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090226115243.GC4229@sirena.org.uk>
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


> >  struct snd_soc_jack_pin {
> > +	struct snd_soc_jack *jack;
> > +	struct snd_soc_jack_gpio *gpio_pin;
> >  	struct list_head list;
> >  	const char *pin;
> >  	int mask;
> >  	bool invert;
> > +	/* GPIO */
> > +	unsigned int gpio;
> > +	unsigned int irq;
> > +	unsigned long irqflags;
> > +	irq_handler_t handler;
> > +	struct work_struct work;
> >  };
> 
> This needs to be rethought - it breaks the abstraction layers.

Ok, I see. Here is the new plan:

* Create a new structure "snd_soc_jack_gpio" holding info specific for a
  gpio pin like: gpio, irq, irqflags, irqhandler, private data (to be
  passed to irqhandler).

* Create a new function "snd_soc_jack_add_gpios" to add all jack_gpios that
  belong to a specific jack. This function should add all gpio pin references
  in a linked list as it's done for dapm pins. The linked list will be
  useful to be able to release acquired resources in another function
  "snd_soc_jack_free_gpios".

* Machine driver will be responsible to call add_gpios function passing an
  array of gpios related to each jack.

* Machine driver will tie each jack_gpio with corresponding jack in a
  machine specific jack_data structure, one hook per jack_gpio in the jack.
  A handler will also be associated to the jack_data structure. This
  jack_data struct will be passed to the gpio irqhandler as private data.

-Misa
