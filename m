From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH] i2c: busses: i2c-omap: Increase timeout for i2c
 interrupt
Date: Fri, 10 Jul 2015 11:09:09 +0200
Message-ID: <20150710090909.GF1528@katana>
References: <1436504994-31137-1-git-send-email-vigneshr@ti.com>
 <559F8670.2060305@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vKFfOv5t3oGVpiF+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <559F8670.2060305@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>, Felipe Balbi <balbi@ti.com>
Cc: ext Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> 60 s sounds way too much and actually I simply don't believe this is
> the root cause. If I take a look into the driver, then I see, that

I agree, this is just a workaround.

> the design is not really the best. The whole IRQ handling could be
> actually performed in hard IRQ handler, without threading overhead.
> Putting even 2 bytes in the controller FIFO should not be too heavy
> for the hard IRQ handler. Then these ridiculous spin_lock()s. What
> is the reason behind? The IRQ is flagged with ONESHOT, so thread and
> hardirq handler are anyway mutually excluded. But if this thread
> ever runs longer than it's allowed in IRQ context, then it anyway
> produces this IRQ latency because it locks spin_lock_irqsave() for
> the whole time! So the whole point of threaded interrupt is missing.

Furthermore, this combination of threaded_irq and struct completion seems
bogus to me. If you just want to ensure the irq happened before timeout,
you just complete when the irq happened and do the "bottom half" after the
completion returned?

> I would propose you to throw away spinlocks. Convert threaded IRQ to
> just one hardirq handler. And continue debugging. You will reduce the
> load of the system with the above measures, maybe it will not happen
> any more, maybe you'll figure out that problem is somewhere else.

Or this.

Felipe converted it to threaded_irq, maybe he has something to add?


--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVn4u1AAoJEBQN5MwUoCm29k8P/jyNuGRTgPpswgSZr5wa98LA
H4zntBH4N/xbklds1TkozwW3BTPjYNIO+2ob1vncrvTcsgMnH1xOtfqsFjvAI220
fMbFWrYXuqNUZPn7X+7JO/j2IoDFTsB6NbzkBNVUWJbRht6XYmIr1U++vNhEjILu
YsVDjhauQoUtOuFbMjN8ty9RzKABLeza+fxY1aQgCROiiAwsBe3tx+IAzUC7nRfU
RsdmV8xewiZo0m3WJQHy0rX2UB1TuaBxW5TnPoeugpDCo9rbqo3mWfETQbMdsptL
FacUMzlNErj0fYA1njpRwcV0PFhyRCVPpphhdbb+2cPUyFMRMSbG3ONtbQUfYyZ5
C46bznaCBgoP3AeC8CbNte/W5+raEd32BaLtLpfOeWss/ePxgNYzQTYNae0KYBqw
EsK97sx/Fb+ofx1RGihcNmQWRSmd26zzb8Ht/TAKCaA8/wBSVFvYn89cGWhUJI9K
n0zN22LpqQs4wWAnjAOc2JDQ1rbVjY+K+voBKLFmuSTtlp1Uxpi3MZm5tOGv3gyk
xTz3OsTqdHLeEnE5AypuUHvMk0Acc1xP+JveDT4IYUutVyQMTEVnt+sfle2/KhM3
oktiL4hkjanb42vqVNrk8GeULtTejGOi9+iZSSQSCpv6ltWFRdNtHldJ+Uzmjx+T
4ATVoEaqD3DDmVQdpNq3
=br0N
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--
