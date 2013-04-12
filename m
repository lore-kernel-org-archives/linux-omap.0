From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio/omap: implement irq_enable/disable using
 mask/unmask.
Date: Fri, 12 Apr 2013 14:07:01 +0300
Message-ID: <20130412110701.GF7361@arwen.pp.htv.fi>
References: <1365758001-15562-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <1365758001-15562-2-git-send-email-andreas.fenkart@streamunlimited.com>
 <5167DFC8.8060202@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59269 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab3DLLHU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Apr 2013 07:07:20 -0400
Content-Disposition: inline
In-Reply-To: <5167DFC8.8060202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Andreas Fenkart <andreas.fenkart@streamunlimited.com>, jon-hunter@ti.com, khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org, daniel@zonque.org

--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 12, 2013 at 03:49:52PM +0530, Santosh Shilimkar wrote:
> On Friday 12 April 2013 02:43 PM, Andreas Fenkart wrote:
> > In PM suspend, some omaps can't detect sdio irqs via the sdio interface.
> > The way to implement this, is to declare the corresponding pin as part
> > of the sdio interface and as a gpio input via pinctrl-single states.
> > The MMC driver request states "default" "active" and "idle" during the
> > probe, then toggles between active and idle during the runtime. This
> > requires low overhead functions for enable/disable of gpio irqs.
> >=20
> > For level triggered interrupt there is no difference between masking
> > and disabling an interrupt. For edge interrupt interrupts there is.
> > When masked, interrupts should still be latched to the interrupt status
> > register so when unmasked later there is an interrupt straight away.
> > However, if the interrupt is disabled then gpio events occurring will n=
ot
> > be latched/stored. Hence proposed patch is incomplete for edge type
> > interrupts.
> >=20
> > Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> > ---
> Patch is incomplete and still confusing ;-) if some one reads the
> patch without the thread. I think you have already ask the question/
> suggestion in past but its better to split masking/disabling functions
> and make them behave properly. Mapping enable/disable to mask/unmask
> to get around the issue seems more of a hack.

right, specially since IRQ susystem will already do that for
irq_enable():

kernel/irq/chip.c::irq_enable()

192 void irq_enable(struct irq_desc *desc)
193 {
194         irq_state_clr_disabled(desc);
195         if (desc->irq_data.chip->irq_enable)
196                 desc->irq_data.chip->irq_enable(&desc->irq_data);
197         else
198                 desc->irq_data.chip->irq_unmask(&desc->irq_data);
199         irq_state_clr_masked(desc);
200 }

In fact this patch shouldn't be necessary if only IRQ subsystem would do
the same for irq_disable() (though it doesn't and I haven't fully read
the code you to understand why, however there's definitely a reason):

202 void irq_disable(struct irq_desc *desc)
203 {
204         irq_state_set_disabled(desc);
205         if (desc->irq_data.chip->irq_disable) {
206                 desc->irq_data.chip->irq_disable(&desc->irq_data);
207                 irq_state_set_masked(desc);
208         }
209 }

--=20
balbi

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZ+rVAAoJEIaOsuA1yqREltgQAIS0ogiHGhcP/4hmUl/C9tUI
7zhItdXbgCQ/3nj+DpAxQ9+X/2Id9OFcOzEHpuMqED/UAUm8RgEyniZeS7ARba6Q
gwxlMhVPVlinl7uATKwXbqEyEWp6trJscGtRi/0pfxTOWfjbuaW17PLJpnefcuVB
1uEsvEZI/OS4OZr8Cq50lBK0+ZLR/kd1ob3aEWJe2aTt8BjCRRwGnbovychUSYdU
06ST4XXWA5EuuMZ4BhbDN+NsdK/zgaeHlUu0OTPfOWhwqGj6uwy5S2b4Mt93GFvs
PN9HiuForVNMG4RVrO8EyWcNll5EYZXVVmN7gr1+hUcoOghYWNVEtL5bf3dP3ieo
JtnX9XJfkm8UbiDnqCfVKa2Zw83RE70imufFOOloyVVjt7GDpTAarKIecT8uPaOg
xjDPYYPjyAU2Nh2TmODr1ELm+lBtIa8rfWvks9kTwKpkB0KDE5KjE4uv0JaTRWry
XHb+OLsRk5tgULPyQPiUU/5gCXP3jPRV0mcGINaCWuptPIiEBF8/zXXxeA1tW7g/
3wCrc1x2FJbyaPyhMwjVnAC7Niuw3sxneRRHMICkJJx9wr9KV9bfGTaUqjEqAUQa
RumXLKkHfYlcEdhJLKchj42NHoL3eOX/pSq7V4zTqZaXEL9s4nHmIG7rSl+rTCM+
1ibtJTW+inMj0asoFrc9
=Lyeq
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
