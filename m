From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
Date: Mon, 18 Nov 2013 17:46:38 +0000
Message-ID: <20131118174638.GQ13640@lee--X1>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
 <20131118172510.GI16038@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:36115 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab3KRRqn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 12:46:43 -0500
Received: by mail-oa0-f52.google.com with SMTP id h16so1527500oag.39
        for <linux-omap@vger.kernel.org>; Mon, 18 Nov 2013 09:46:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131118172510.GI16038@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

> > > +static struct of_dev_auxdata twl_auxdata_lookup[] =3D {
> > > +	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
> > > +	{ /* sentinel */ },
> > > +};
> > > +
> > >  /* NOTE: This driver only handles a single twl4030/tps659x0 chip=
 */
> > >  static int
> > >  twl_probe(struct i2c_client *client, const struct i2c_device_id =
*id)
> > > @@ -1271,10 +1276,14 @@ twl_probe(struct i2c_client *client, cons=
t struct i2c_device_id *id)
> > >  		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
> > >  	}
> > > =20
> > > -	if (node)
> > > -		status =3D of_platform_populate(node, NULL, NULL, &client->dev=
);
> > > -	else
> > > +	if (node) {
> > > +		if (pdata)
> > > +			twl_auxdata_lookup[0].platform_data =3D pdata->gpio;
> > > +		status =3D of_platform_populate(node, NULL, twl_auxdata_lookup=
,
> > > +					      &client->dev);
> > > +	} else {
> > >  		status =3D add_children(pdata, irq_base, id->driver_data);
> >=20
> > Why doesn't the TWL driver use the MFD framework for this stuff?
>=20
> that's reminiscent from years ago and, surely, needs to be fixed. Sho=
uld
> we gate $subject for that, though ? This has been in tree for quite a
> few years already and Tony's patch is still a step forward, since mos=
t
> omap3 platforms would break on DT-only without it.

I didn't say that I would reject the patch. I was just surprised to
see so much hand-rolling, as the MFD core code does much of it
automatically. This is the first time I've taken a look at this and it
seems to be quite the relic.

> There are quite a few folks who could volunteer to fixing that after
> Tony's patch is in (me included, although there could be better choic=
es
> hehe).

Well it's not doing any harm. I'll make a note to fix it myself if a)
no one has done so already and b) I manage to find some spare
time. The latter issue is less likely to be resolved. :)

Are you Acking this patch by the way?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
