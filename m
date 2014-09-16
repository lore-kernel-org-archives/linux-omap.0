From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] mfd: twl4030-power: use 'ti,system-power-controller'
 as alternative way to support system power off
Date: Tue, 16 Sep 2014 16:05:37 -0700
Message-ID: <20140916230537.GU25162@lee--X1>
References: <1409771208-21867-1-git-send-email-nm@ti.com>
 <1409771208-21867-3-git-send-email-nm@ti.com>
 <20140909000126.GU3238@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:32843 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbaIPXFy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2014 19:05:54 -0400
Received: by mail-pd0-f171.google.com with SMTP id p10so745782pdj.16
        for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2014 16:05:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140909000126.GU3238@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 08 Sep 2014, Tony Lindgren wrote:

> * Nishanth Menon <nm@ti.com> [140903 12:07]:
> > ti,system-power-controller is more or less the standard way of
> > indicating that the PMIC is the system wide power controller and he=
nce
> > may be used to switch off the system. Almost ALL TI PMIC drivers an=
d
> > many Maxim PMIC drivers follow the same style.
> >=20
> > So support 'ti,system-power-controller' in addition to the usual
> > 'ti,use_poweroff' to indicate that the PMIC instance has control fo=
r
> > switching off the system.
> >=20
> > Signed-off-by: Nishanth Menon <nm@ti.com>
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

I assume you're going to resend this with the document modifications?
When you do, don't forget to apply Tony's Ack, as it will ensure a
faster merge.

> > ---
> >  drivers/mfd/twl4030-power.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-powe=
r.c
> > index 3bc969a..1c129ba 100644
> > --- a/drivers/mfd/twl4030-power.c
> > +++ b/drivers/mfd/twl4030-power.c
> > @@ -627,6 +627,9 @@ static bool twl4030_power_use_poweroff(const st=
ruct twl4030_power_data *pdata,
> >  	if (pdata && pdata->use_poweroff)
> >  		return true;
> > =20
> > +	if (of_property_read_bool(node, "ti,system-power-controller"))
> > +		return true;
> > +
> >  	if (of_property_read_bool(node, "ti,use_poweroff"))
> >  		return true;
> > =20

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
