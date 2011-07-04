From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH v6 08/18] mfd: twl6040: Add initial support
Date: Mon, 4 Jul 2011 16:11:48 +0300
Message-ID: <7536276.uh7gaa9vHu@barack>
References: <1308663556-29120-1-git-send-email-peter.ujfalusi@ti.com> <1308663556-29120-9-git-send-email-peter.ujfalusi@ti.com> <20110704114844.GA3021@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20110704114844.GA3021@sortiz-mobl>
Sender: linux-input-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

On Monday 04 July 2011 13:48:44 Samuel Ortiz wrote:
> Hi Peter,
>=20
> On Tue, Jun 21, 2011 at 04:39:06PM +0300, Peter Ujfalusi wrote:
> > +int twl6040_is_powered(struct twl6040 *twl6040)
> > +{
> > +	return twl6040->power_count;
> > +}
> > +EXPORT_SYMBOL(twl6040_is_powered);
>=20
> Do we really need to export this one ?

No, we don't.
At the end we do not need this function at all either.
I'm going to remove it.
=20
> > +static inline int twl6040_get_rev(struct twl6040 *twl6040)
> > +{
> > +	return twl6040->rev;
> > +}

No need for this either, I'll remove it.

> > +
> > +static inline int twl6040_request_irq(struct twl6040 *twl6040, int=
 irq,
> > +				      irq_handler_t handler,
> > +				      unsigned long irqflags,
> > +				      const char *name,
> > +				      void *data)
> > +{
> > +	if (!twl6040->irq_base)
> > +		return -EINVAL;
> > +
> > +	return request_threaded_irq(twl6040->irq_base + irq, NULL, handle=
r,
> > +				    irqflags, name, data);
> > +}
> > +
> > +static inline void twl6040_free_irq(struct twl6040 *twl6040, int i=
rq,
> > +				    void *data)
> > +{
> > +	if (!twl6040->irq_base)
> > +		return;
> > +
> > +	free_irq(twl6040->irq_base + irq, data);
> > +}
>=20
> I don't see the value of those 3 inline functions. Removing them woul=
d make
> the code actually more understandable (especially for the 2nd one).

The twl6040_request_irq is also used by the ASoC codec driver, and the =
vibra=20
driver, but if you think it is better to replace those as well, I will =
do it=20
right away.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
