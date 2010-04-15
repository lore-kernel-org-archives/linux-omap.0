From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v3 4/5(7)] input: serio: add support for Amstrad Delta serial keyboard port
Date: Thu, 15 Apr 2010 20:16:07 +0200
Message-ID: <201004152016.10035.jkrzyszt@tis.icnet.pl>
References: <201004150419.05038.jkrzyszt@tis.icnet.pl> <201004150431.06719.jkrzyszt@tis.icnet.pl> <20100415161451.GA13966@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100415161451.GA13966@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, e3-hacking@earth.li
List-Id: linux-omap@vger.kernel.org

Thursday 15 April 2010 18:14:51 Dmitry Torokhov napisa=C5=82(a):
> Hi Janusz,

Hi Dmitry,

> On Thu, Apr 15, 2010 at 04:31:03AM +0200, Janusz Krzysztofik wrote:
> > +
> > +config SERIO_AMS_DELTA
> > +	tristate "Amstrad Delta (E3) mailboard support"
> > +	depends on MACH_AMS_DELTA
> > +	default y
> > +	select AMS_DELTA_FIQ
> > +	select KEYBOARD_ATKBD
>
> I'd rather not select atkbd here since it is not required for this
> driver to work but simply adjust your defconfig.

I was just trying to address possible future support questions, as you =
can=20
already find them in the e3-hacking 2006 archives :).

OK, I'll drop it then and move the config back inside the "if SERIO"...=
"endif"=20
block.

> > +
> > +	if (!(machine_is_ams_delta()))
> > +		return -ENODEV;
>
> Extra parens.

Yes, it looks like I'm too much wary. I'll drop them.

> Otherwise:
>
> 	Acked-by: Dmitry Torokhov <dtor@mail.ru>

Thanks.

> I assume it is going to be merged with the rest of your patches throu=
gh
> a tree other than linux-input.

Probably yes, since it depends on most of them. Let's see first what To=
ny=20
says.

Regards,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
