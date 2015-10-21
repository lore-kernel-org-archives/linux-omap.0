From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Wed, 21 Oct 2015 08:20:28 -0700
Message-ID: <20151021152028.GO3078@atomide.com>
References: <20151006083346.GL23801@atomide.com>
 <56139A72.6040600@ti.com>
 <20151006100000.GN23801@atomide.com>
 <56139CE9.8020002@ti.com>
 <5613A256.8000105@ti.com>
 <20151006110134.GO23801@atomide.com>
 <5613ABEF.9000904@ti.com>
 <20151016212510.GF24370@atomide.com>
 <562496DB.4050803@ti.com>
 <56274D69.1090402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56274D69.1090402-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [151021 01:31]:
> On 19/10/15 10:08, Roger Quadros wrote:
> > On 17/10/15 00:25, Tony Lindgren wrote:
> >> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [151006 04:13]:
> >>>
> >>> Fine. The updated series is now at
> >>>
> >>> git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:rogerq/linux.git
> >>>  * [new branch]      for-v4.4/gpmc-v4
> >>
> >> Looks like it produces some build errors, this with RMKs 3430 and =
4430
> >> only .configs:
> >>
> >> drivers/memory/omap-gpmc.c:2035:43: error: =E2=80=98struct gpio_ch=
ip=E2=80=99 has no
> >> member named =E2=80=98irqdomain=E2=80=99
> >> drivers/memory/omap-gpmc.c:2116:8: error: implicit declaration of
> >> function =E2=80=98gpiochip_irqchip_add=E2=80=99 [-Werror=3Dimplici=
t-function-declaration]
> >>
> >=20
> > Good catch. We'll have to select GPIOLIB_IRQCHIP for this driver.
> >=20
> >> Maybe run randconfig builds on it for overnight?
> >=20
> > OK. I'll do that.
>=20
> I couldn't run randconfig beyond few iterations as it keeps failing
> everywhere. How do we limit the randconfig options to OMAP only
> platforms?

You can use Felipe's scripts from github.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
