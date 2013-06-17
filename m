From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 01/22] mfd/ti_am335x_tscadc: remove regmap
Date: Mon, 17 Jun 2013 13:41:40 +0200
Message-ID: <51BEF5F4.4090600@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <1370950268-7224-2-git-send-email-bigeasy@linutronix.de> <20130611142336.GE29135@zurbaran> <51B7358D.7000605@linutronix.de> <20130614135358.GR1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130614135358.GR1403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/14/2013 03:53 PM, Mark Brown wrote:
> On Tue, Jun 11, 2013 at 04:34:53PM +0200, Sebastian Andrzej Siewior
> wrote:
> 
> It does give you tracepoints and debugfs.  If it's making things at
> all complicated we need to look at why that is and figure out how
> to fix that since it's probably an issue for other users.

debugfs are tracepoints is our offer? Let me check the price one more
time.

A simply mmio read does right now:
- lock + unlock.
  each time you chase another pointer plus enable/disable interrupts
  plus you have to save flags in another structure.

- _regmap_read()
  We check a few variables and then we go after reg_read and we end up
  in _regmap_raw_read().
  Here we call _regmap_range_lookup() which should return NULL. Next
  thing we invoke map->format.format_reg(). Finally we can call
  map->bus->read() which brings us to regmap_mmio_read().
  At the end we invoke map->format.parse_val().

write looks most likely the same.

A simple register read invokes 5 functions pointers. I am not counting
the function arguments in between and I am also not counting the number
of arguments which are involved and take pointer as well. This is a lot
of stuff that is done for a simple read of an mmio.

I understand that most of this may not be expensive in total if it
comes to SPI or I2C and all the goodies like reg caching and one
interface which deals with SPI and I2C. I also understand that some
chips have a non standard interface and are either BE or LE. We have
similar things on USB where people wired the BUS wrongly either at the
BUS level or at the SoC level so some PowerPC have an in-core ehci
controller but its registers are BE and not LE like it should be. The
solution here was variable check a simple swap() in that case.
I like abstractions but this gone a little too far I think.

This is a lot of for a simple mmio access. In terms of performance: If
I add a trace point to my read and write I have still less code which
is called and it can be disabled. This regmap overhead is always there
chasing pointers.

As I said before: I doubt that you get this regmap access in an one GiB
network driver and in turn remove their trace points to register access.

Please don't get me wrong: It is still nice for slow buses and this ADC
driver isn't anything close to high performance like a 1GiB network
driver but it adds a lot of unwanted overhead which I prefer not to
have.

Sebastian
