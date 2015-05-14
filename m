From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Thu, 14 May 2015 11:09:02 -0500
Message-ID: <20150514160902.GF24269@saruman.tx.rr.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <1431560196-5722-3-git-send-email-tony@atomide.com>
 <20150514020634.GB20006@saruman.tx.rr.com>
 <20150514155945.GL15563@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150514155945.GL15563@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 14, 2015 at 08:59:46AM -0700, Tony Lindgren wrote:
> > > +int dev_pm_request_wake_irq(struct device *dev,
> > > +			    int irq,
> > > +			    irq_handler_t handler,
> > > +			    unsigned long irqflags,
> > > +			    void *data)
> > > +{
> > > +	struct wake_irq *wirq;
> > > +	int err;
> > > +
> > > +	wirq =3D devm_kzalloc(dev, sizeof(*wirq), GFP_KERNEL);
> > > +	if (!wirq)
> > > +		return -ENOMEM;
> > > +
> > > +	wirq->dev =3D dev;
> > > +	wirq->irq =3D irq;
> > > +	wirq->handler =3D handler;
> >=20
> > you need to make sure that IRQF_ONESHOT is set in cases where handler is
> > NULL. Either set it by default:
> >=20
> > 	if (!handler)
> > 		irqflags |=3D IRQF_ONESHOT;
> >=20
> > or WARN() about it:
> >=20
> > 	WARN_ON((!handler && !(irqflags & IRQF_ONESHOT));
> >=20
> > Actually, after reading more of the code, you have some weird circular
> > call chain going on here. If handler is a valid function pointer, you
> > use as primary handler, so IRQ core will call it from hardirq context.
> > But you also save that pointer as wirq->handler, and call that from
> > within handle_threaded_wakeirq(). Essentially, handler() is called
> > twice, once with IRQs disabled, one with IRQs (potentially) enabled.
> >=20
> > What did you have in mind for handler() anyway, it seems completely
> > unnecessary.
>=20
> Yeah.. Let's just leave it out. You already mentioned it earlier and
> there's no use for it.
>=20
> The device driver can deal with the situation anyways in runtime resume.
>=20
> And like you said, it must be IRQF_ONESHOT, now there's a chance of
> consumer drivers passing other flags too.
>=20
> The the IO wake-up interrupt vs dedicated wake-up interrupt functions
> can be just something like:
>=20
> int dev_pm_request_wake_irq(struct device *dev, int irq);

right, then it's always IRQF_ONESHOT and always threaded.

> int dev_pm_request_wake_irq_managed(struct device *dev, int irq);

I don't get this. Would this request with devm_ while the former
wouldn't use devm_ ?

> > > +void dev_pm_free_wake_irq(struct device *dev)
> > > +{
> > > +	struct wake_irq *wirq =3D dev->power.wakeirq;
> > > +	unsigned long flags;
> > > +
> > > +	if (!wirq)
> > > +		return;
> > > +
> > > +	spin_lock_irqsave(&dev->power.lock, flags);
> > > +	wirq->manage_irq =3D false;
> > > +	spin_unlock_irqrestore(&dev->power.lock, flags);
> > > +	devm_free_irq(wirq->dev, wirq->irq, wirq);
> >=20
> > this seems unnecessary, the IRQ will be freed anyway when the device
> > kobj is destroyed, dev_pm_clear_wake_irq() seems important, however.
> >=20
> > > +	dev_pm_clear_wake_irq(dev);
> > > +}
>=20
> The life cycle of the request and free of the wake irq is not the
> same as the life cycle of the device driver. For example, serial
> drivers can request interrupts on startup and free them on shutdown.

fair enough, but then we start to consider the benefits of using
devm_ IRQ :-)

> > > +void dev_pm_disable_wake_irq(struct device *dev)
> > > +{
> > > +	struct wake_irq *wirq =3D dev->power.wakeirq;
> > > +
> > > +	if (wirq && wirq->manage_irq)
> > > +		disable_irq_nosync(wirq->irq);
> > > +}
> > > +EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);
> >=20
> > likewise, call this automatically from rpm_resume().
>=20
> Right.
> =20
> > This brings up a question, actually. What to do with devices which were
> > already runtime suspended when user initiated suspend-to-ram ? Do we
> > leave wakeups enabled, or do we revisit device_may_wakeup() and
> > conditionally runtime_resume the device, disable wakeup, and let its
> > ->suspend() callback be called ?
>=20
> I believe that's already handled properly, but implemented in each
> consumer driver with the if device_may_wakeup enabled_irq_wake.

I see, but perhaps even that can be partially automated at some point
:-)

--=20
balbi

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVVMieAAoJEIaOsuA1yqREnZ0P/R2iSkLkjXb43MHWYjmVbYF5
D418vqNg/vyCNnux63jV/jWwUwovxmuTn9eT7ST+OWSd3nQInw1MjJGgC1nQMz9F
soa/n/5qtDGr89Lj1zfHf0UcIw/M6gQWHopakzbz/iYPXk3oLNuh6G0k5F6zXljL
ZrabIGlpYUrvCa/3QII81u8W1DJzJxPOMrzaTDIRiNtINm58g0jj522G0tAtTGtJ
bC0kuHu7aOPwXkMx0r0p0Ai9reidGuKdESAKxM89WbI8mSXCIW9IVdDqeJHexk3I
3JLlwCr6TXLJHOvHx5DlKQmfSrK+vVVylD9J01RXYl17IudOx70CqVKp8dfBV7Ll
4CeowhaHzCnx98Mw9JcbiGC3IzXwdPd55RcNxNF3E7tZb8JI2nlgQ5QLjjScy5PL
r6WGOfDg+6uh7ANJDfC8A+sjSqpCbKfmJ7gMFwrq2QxYu8ALGTePNDaim9Ssmm0k
EQisXB6r92JyWeLJQi2CZaUmB36Xw5qGn1h+P7ENqN1fzSoVvStOD5NhfXmdCn/x
NoyKxCZrfzw/SFVoJ8I8BcxNmUs7D0H4bQE4Re6QAJby+h6J2X37WZMk85eQyqMg
yjh+vQIyp1fubQ0RFDlU8kerH1w79FYy/2BgDBkVjCPhjKP70dbR4XjVSXrzxcOC
VLszWFjGOtit2JYFhOBv
=akh1
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
