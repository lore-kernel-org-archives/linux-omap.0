From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq
 handling
Date: Fri, 14 Nov 2014 21:53:28 -0600
Message-ID: <20141115035328.GA3289@saruman>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com>
 <1416014452-6712-2-git-send-email-al.kochet@gmail.com>
 <20141115014859.GC808@saruman>
 <7C4EE58D-8956-40C2-B649-775B2F551D2A@gmail.com>
 <20141115034756.GA2917@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44881 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935166AbaKODxI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2014 22:53:08 -0500
Content-Disposition: inline
In-Reply-To: <20141115034756.GA2917@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Alexander Kochetkov <al.kochet@gmail.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi again,

On Fri, Nov 14, 2014 at 09:47:56PM -0600, Felipe Balbi wrote:
> > > how ? This is an interesting bug which deserves further explanation.
> >=20
> > Look at the loops above, and at the omap_i2c_complete_cmd:
> >=20
> > static inline void
> > omap_i2c_complete_cmd(struct omap_i2c_dev *dev, u16 err)
> > {
> > 	dev->cmd_err |=3D err;
> > 	complete(&dev->cmd_complete);
> > }
> >=20
> > You can see, loop will be aborted if counter reached 100. Final state
> > of transfer depends on values stored in the 'err' and 'dev->cmd_err'.
> > If 'err' and 'dev->cmd_err' are zero, than transfer would be aborted
> > with status 0.

look at the IRQ handler again:

| omap_i2c_isr_thread(int this_irq, void *dev_id)
| {
| 	struct omap_i2c_dev *dev =3D dev_id;
| 	unsigned long flags;
| 	u16 bits;
| 	u16 stat;
| 	int err =3D 0, count =3D 0;
|=20
| 	spin_lock_irqsave(&dev->lock, flags);
| 	do {

[...]

| 		if (stat & OMAP_I2C_STAT_NACK) {
| 			err |=3D OMAP_I2C_STAT_NACK;
| 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
| 			break;
| 		}
|=20
| 		if (stat & OMAP_I2C_STAT_AL) {
| 			dev_err(dev->dev, "Arbitration lost\n");
| 			err |=3D OMAP_I2C_STAT_AL;
| 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_AL);
| 			break;
| 		}

[...]

|=20
| 	} while (stat);
|=20
| 	omap_i2c_complete_cmd(dev, err);
|=20
| out:
| 	spin_unlock_irqrestore(&dev->lock, flags);
|=20
| 	return IRQ_HANDLED;
| }

How could I ever call omap_i2c_complete_cmd() with 'err' set as 0 if I
had either a NACK or Arbitration Lost ?

--=20
balbi

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZs44AAoJEIaOsuA1yqREsjYP/0XUXjBXHVz655fpFajFx357
XH+MfOiyfJQUEcysTK7qI6OT/UCJmAnxc9YWtcKnkk5aLuP6t9VHhyd/UXnZxNR/
YLPsQqJ76UaVsxxiJ9MUeFNAjZa1oEWPcdxweLE7o1Fa3xVPLC5w2PDcLp45CPnK
khd6dC4PphVDLo6N/dLdrZoYgzdAqxxNh8K5LJF36EWJpT8YKSRYPxct0U3Bqkyh
d/79fjgLQAeg3NRlWWe0P8LBFEPItI4q3AwEAG+YgmJ/BYe7XbZh2rSrBUubDCYV
FO9ua6uWZNCcq2yYo50BkIyXk49OqLcm49LN1Y212ltAV/Q4HqP5oXBZVFkkMJWW
teXmlC99DlJvXt2QzQt4bDarucox/soFT+79lXCOcvUj1Jwiej7iD3WCApazFigt
UzPWY0960jgWZDxzDr3YlP7XFLFPyJVk5laWqnkxmylR91YW5KabsZHwQZ5smPtB
3vIEmB0qi9gJON/9ebk/vcZozAYhbwLKjAsBN0n+3AklD7CqwfQsziZVzjgZB3Zb
X7A7wq+cQmeTZy1BrQOd4XtVCi74O2w9X4Z555+qaLpfO0RhUivuz0vyGOXDtvut
AkqHgfJ9wHIm2IiHzD3FfwCLEaqdf+nSi9TbSsFAVl0JYwnvVt929zOKT+DCEP9q
7+TDkO7tZIUqeKRvgCmu
=r6Na
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
