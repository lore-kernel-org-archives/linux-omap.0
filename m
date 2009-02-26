From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: Add GPIO support for jack
	reporting interface
Date: Thu, 26 Feb 2009 11:52:43 +0000
Message-ID: <20090226115243.GC4229@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2927 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbZBZLwr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 06:52:47 -0500
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Feb 26, 2009 at 01:57:03AM -0600, Lopez Cruz, Misael wrote:

>  struct snd_soc_jack_pin {
> +	struct snd_soc_jack *jack;
> +	struct snd_soc_jack_gpio *gpio_pin;
>  	struct list_head list;
>  	const char *pin;
>  	int mask;
>  	bool invert;
> +	/* GPIO */
> +	unsigned int gpio;
> +	unsigned int irq;
> +	unsigned long irqflags;
> +	irq_handler_t handler;
> +	struct work_struct work;
>  };

This needs to be rethought - it breaks the abstraction layers.

There are three things working together here:

 - The snd_soc_jack, which represents a physical jack on the system and
   is what is visible to user space.
 - The snd_soc_jack_pin, which represents a DAPM pin to update depending
   on some of the status bits supported by the jack.  Each snd_soc_jack
   has zero or more of these which are updated automatically.
 - The jack reporting mechanism, which represents something that can do
   detection - it is associated with a snd_soc_jack, reporting a subset
   of the status bits supported by the snd_soc_jack.  Each jack may
   have multiple reporting mechanisms, though it will need at least one
   to be useful.

These are all hooked together by the machine driver depending on the
system hardware.  The machine driver will set up the snd_soc_jack and
the list of pins to update then set up one or more jack detection
mechanisms to update that jack based on their current status.

For example, a system may have a stereo headset jack with two reporting
mechansms, one for the headphone and one for the microphone.  Some
systems won't be able to use their speaker output while a headphone is
connected and so will want to make sure to update both speaker and
headphone when the headphone jack status changes.

The GPIO jack detection code should operate only on a snd_soc_jack that
is provided to it by a machine driver - you'll need to define a
structure to hold the information the GPIO jack detection needs (there
is a structure there but you've not defined it so I'm not sure what you
have in it at the minute).

Please look at the wm8350 headphone detection for an example of how to
integrate a detection mechanism.

> +static void gpio_work(struct work_struct *work)
> +{
> +       struct snd_soc_jack_pin *pin;
> +       int report;
> +
> +       pin = container_of(work, struct snd_soc_jack_pin, work);
> +       report = pin->jack->status & pin->mask;
> +       if (gpio_get_value(pin->gpio))
> +               report |= pin->mask;
> +       else
> +               report &= ~pin->mask;
> +
> +       snd_soc_jack_report(pin->jack, report, pin->jack->jack->type);
> +}

The value to report should be supplied by the machine driver.

BTW, please remember to CC the maintainers of the things you're
submitting patches for.
