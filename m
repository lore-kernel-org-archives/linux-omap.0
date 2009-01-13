From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Changes for adding and building TPS6235x based PR785 board support
Date: Tue, 13 Jan 2009 13:49:09 -0800
Message-ID: <200901131349.09907.david-b@pacbell.net>
References: <1231832505-7166-1-git-send-email-mani.pillai@ti.com> <20090113145909.GQ7344@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:31914 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752381AbZAMVtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2009 16:49:12 -0500
In-Reply-To: <20090113145909.GQ7344@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@sirena.org.uk

On Tuesday 13 January 2009, Tony Lindgren wrote:
> The the read/write_reg should be in drivers/mfd somewhere.

I wouldn't think so ... it's not an MFD, it's just a
regulator that has a feature that's not yet envisioned
by the current regulator framework.  (Floor/Ceiling
controls, basically.)


> > @@ -160,5 +218,14 @@ int __init omap_register_i2c_bus(int bus_id, u=
32
> > clkrate, }
> > =A0
> > =A0=A0=A0=A0=A0=A0omap_i2c_mux_pins(bus_id - 1);
> > -=A0=A0=A0=A0=A0return platform_device_register(pdev);
> > +=A0=A0=A0=A0=A0platform_device_register(pdev);
> > +#if defined(CONFIG_OMAP3EVM_PR785)
> > +=A0=A0=A0=A0=A0if (bus_id =3D=3D 1) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0omap_i2c_register_child(pde=
v, "vdd2_consumer", \
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0&vdd2_platform_device);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0omap_i2c_register_child(pde=
v, "vdd1_consumer", \
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0&vdd1_platform_device);
> > +=A0=A0=A0=A0=A0}
> > +#endif
> > +=A0=A0=A0=A0=A0return 0;
> > =A0}
>
> Argh, i2c-omap.c is the _bus_ driver, not i2c device!

Right.  I don't understand why there's this urge to
scatter board-specific code throughout the driver
tree, instead of leaving it all in mach-omap2/pr785.c
and having the tps6235x.c driver be a pure regulator
driver...


> How different tps6235 is from the twl4030? Maybe you can just add
> functionality to the existing drivers/mfd/twl4030-core.c.

It's very different ... the tps623x chips are trivial,
with about four registers each.  No capability OTHER
than being a voltage regulator.

Which is why it's puzzling to see it take so long to
just get a simple voltage regulator driver patch...


Admittedly, the regulator framework is new, and parts
of it still seem to me like they have design problems.
But even so, it's not so hard to figure out how to pass
board-specific regulator configuration data down to the
regulator drivers from a pr785.c board driver.

Now, there *can* be a bit of chicken/egg going on in
some of that initialization.  But I don't think that
applies to all of the PR785 support.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
