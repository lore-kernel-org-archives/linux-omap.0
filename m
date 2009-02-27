From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/3] ASoC: Add GPIO support for
	jack	reporting interface
Date: Fri, 27 Feb 2009 13:05:03 +0000
Message-ID: <20090227130502.GA4415@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com>
	<20090226115243.GC4229@sirena.org.uk>
	<2C7D3DF36ADFFC479B44490D912B616705ECC76DF8@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECC76DF8@dlee07.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 27, 2009 at 04:52:35AM -0600, Lopez Cruz, Misael wrote:

> * Create a new structure "snd_soc_jack_gpio" holding info specific for a
>   gpio pin like: gpio, irq, irqflags, irqhandler, private data (to be
>   passed to irqhandler).

Yes, roughly.  The jack_gpio will also need to know the status bits to
update and which jack to update.  I'd expect something along the lines
of:

struct snd_soc_jack_gpio {
	struct snd_soc_jack *jack;
	int report;         /* Value to report when jack detected */
	int invert_report;  /* Report presence when GPIO low */
	int gpio;           /* GPIO to read */
};

possibly with some other data stored (eg, a debounce time).  You can use
gpio_to_irq() to get the interrupt number.

If the machine drivers need to customise the IRQ handler code itself
then it's probably getting to the point where another detection method
should be written, though perhaps I'm missing something?

> * Create a new function "snd_soc_jack_add_gpios" to add all jack_gpios that
>   belong to a specific jack. This function should add all gpio pin references
>   in a linked list as it's done for dapm pins. The linked list will be
>   useful to be able to release acquired resources in another function
>   "snd_soc_jack_free_gpios".

Since the detection mechanism will need to know the jack it's notifying
it should be possible to set up every GPIO detector at once - they'll
all have to know which jack to point to anyway.  Given that it'd be as
easy to use an array and not bother with the linked list.  The reason
the pins are added to a list is that we need to iterate over them all
whenever the jack status changes to update the status of the pins.

> * Machine driver will be responsible to call add_gpios function passing an
>   array of gpios related to each jack.

Yes, the machine driver should set up that link.

> * Machine driver will tie each jack_gpio with corresponding jack in a
>   machine specific jack_data structure, one hook per jack_gpio in the jack.
>   A handler will also be associated to the jack_data structure. This
>   jack_data struct will be passed to the gpio irqhandler as private data.

I'd *expect* you can live without the custom handler, though I could be
wrong.
